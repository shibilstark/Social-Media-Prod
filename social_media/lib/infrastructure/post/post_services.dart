import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media/application/user/user_bloc.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/colors/colors.dart';

import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/local_models/post_type_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';
import 'package:social_media/infrastructure/user_services/user_repository.dart';
import 'package:social_media/infrastructure/user_services/user_services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

@LazySingleton(as: PostRepo)
class PostServices implements PostRepo {
  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return ((bytes / math.pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  @override
  Future<Either<PostTypeModel?, MainFailures>> pickPost(
      {required String type}) async {
    try {
      // ignore: unrelated_type_equality_checks
      if (type == PostType.image) {
        final result = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: false);

        if (result == null) {
          return const Right(MainFailures(
              error: "File not selected",
              failureType: MyAppFilures.clientFailure));
        } else {
          // return Left(PostTypeModel(file: result, type: PostType.image));

          final image = await ImageCropper().cropImage(
            sourcePath: result.paths.single!,
            // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio4x3
            ],
            compressFormat: ImageCompressFormat.jpg,
            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: "Crop Image",
                toolbarColor: darkBg,
                toolbarWidgetColor: pureWhite,
              )
            ],
          );

          if (image == null) {
            return const Right(MainFailures(
                error: "File not selected",
                failureType: MyAppFilures.clientFailure));
          } else {
            return Left(PostTypeModel(
                file: image.path, type: PostType.image, thumbnail: null));
          }
        }
      } else {
        final result = await FilePicker.platform
            .pickFiles(type: FileType.video, allowMultiple: false);

        if (result == null) {
          return const Right(MainFailures(
              error: "File not selected",
              failureType: MyAppFilures.clientFailure));
        } else {
          final size = await getFileSize(result.files.single.path!, 0);
          if (size == "15 MB") {
            return const Right(MainFailures(
                error: "Max size is 15 MB",
                failureType: MyAppFilures.clientFailure));
          }
          final thumbnail = await VideoThumbnail.thumbnailFile(
            video: result.paths.single!,
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG,
            maxHeight: 100,
            quality: 100,
          );

          final model = PostTypeModel(
            file: result.paths.single!,
            type: PostType.video,
            thumbnail: thumbnail,
          );
          return Left(model);
        }
      }
    } on Exception catch (e) {
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    } catch (e) {
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    }
  }

  _uploadFileToCloud({
    required SendPort sendPort,
    required PostModel model,
    required String type,
  }) async {
    try {
      if (type == PostType.image) {
        UploadTask? task;
        final destination =
            "posts/${model.userId + model.postId + model.createdAt.day.toString()}";

        final ref = FirebaseStorage.instance.ref(destination);
        task = ref.putFile(File(model.post));

        final progress = task.snapshotEvents;

        final snapShot = await task.whenComplete(() {});

        final url = await snapShot.ref.getDownloadURL();

        final newPostModel = model.copyWith(post: url);
        final userCollection =
            FirebaseFirestore.instance.collection(Collections.users);
        final usersData = await userCollection.get();

        final postCollection =
            FirebaseFirestore.instance.collection(Collections.post);

        await postCollection.doc(newPostModel.postId).set(newPostModel.toMap());

        final users = usersData.docs.toList();

        users.forEach((user) async {
          final currentUserId = user.data()[UmKeys.userId];
          if (currentUserId == model.userId) {
            final UserModel userModel = UserModel.fromMap(user.data());

            userModel.posts.add(newPostModel.postId);

            await userCollection.doc(model.userId).update(userModel.toMap());
            Fluttertoast.showToast(msg: "Post Uploaded successfully");
          }

          return sendPort.send({
            'status': true,
          });
        });

        sendPort.send(true);
      } else {
        UploadTask? video;
        UploadTask? thumb;
        final destination =
            "posts/${model.userId + model.postId + model.createdAt.day.toString()}";

        final videoRef = FirebaseStorage.instance.ref(
            "posts/${model.userId + model.postId + model.createdAt.toString()}");
        final thumbRef = FirebaseStorage.instance.ref(
            "posts/${model.userId + model.postId + model.createdAt.toString()}thumb");
        video = videoRef.putFile(File(model.post));
        thumb = thumbRef.putFile(File(model.videoThumbnail!));

        final videoUploadprogress = video.snapshotEvents;
        final videoUploadsnapShot = await video.whenComplete(() {});
        final thumbUploadProgress = thumb.snapshotEvents;
        final thumbUploadsnapShot = await thumb.whenComplete(() {});

        final videoUrl = await videoUploadsnapShot.ref.getDownloadURL();
        final thumbUrl = await thumbUploadsnapShot.ref.getDownloadURL();

        final newPostModel =
            model.copyWith(post: videoUrl, videoThumbnail: thumbUrl);
        final userCollection =
            FirebaseFirestore.instance.collection(Collections.users);
        final usersData = await userCollection.get();

        final postCollection =
            FirebaseFirestore.instance.collection(Collections.post);

        await postCollection.doc(newPostModel.postId).set(newPostModel.toMap());

        final users = usersData.docs.toList();

        users.forEach((user) async {
          final currentUserId = user.data()[UmKeys.userId];
          if (currentUserId == model.userId) {
            final UserRepo userRepo = UserServices();

            final userBloc = UserBloc(userRepo);
            final UserModel userModel = UserModel.fromMap(user.data());

            userModel.posts.add(newPostModel.postId);

            await userCollection.doc(model.userId).update(userModel.toMap());
            Fluttertoast.showToast(msg: "Post Uploaded successfully");
          }

          return sendPort.send({
            'status': true,
          });
        });

        sendPort.send(true);
      }
    } on Exception catch (e) {
      // log(e.toString());
      sendPort.send(Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure)));
    } catch (e) {
      // log(e.toString());
      sendPort.send(Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure)));
    }
  }

  @override
  Future<Either<bool, MainFailures>> uploadPost(
      {required PostModel model}) async {
    try {
      final successPort = ReceivePort();
      // final errorPort = ReceivePort();

      final isolate = await Isolate.spawn(
          _uploadFileToCloud(
              model: model, sendPort: successPort.sendPort, type: model.type),
          successPort.sendPort);

      // context.callMethod();

      // ignore: prefer_const_constructors
      return Left(true);
    } on Exception catch (e) {
      // log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    } catch (e) {
      // log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    }
  }
}
