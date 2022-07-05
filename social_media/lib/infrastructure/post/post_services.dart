import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';

import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'dart:io';
import 'package:dartz/dartz.dart';

import 'package:social_media/domain/models/post/post_model.dart';
import 'package:social_media/domain/models/post_type/post_type.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';

@LazySingleton(as: PostRepo)
class PostServieces implements PostRepo {
  @override
  Future<Either<PostTypeModel, MainFailures>> pickPost(
      {required PostType? type}) async {
    try {
      if (type == PostType.image) {
        final result = await FilePicker.platform
            .pickFiles(type: FileType.image, allowMultiple: false);

        if (result == null) {
          return Right(MainFailures(
              error: "File not selected",
              failureType: MyAppFilures.clientFailure));
        } else {
          final model = PostTypeModel(file: result, type: PostType.image);
          return Left(model);
        }
      } else {
        final result = await FilePicker.platform
            .pickFiles(type: FileType.video, allowMultiple: false);

        if (result == null) {
          return Right(MainFailures(
              error: "File not selected",
              failureType: MyAppFilures.clientFailure));
        } else {
          final model = PostTypeModel(file: result, type: PostType.video);
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

  @override
  Future<Either<UploadTask, MainFailures>> uploadPost(
      {required PostModel model}) async {
    try {
      UploadTask? task;
      final destination =
          "posts/${model.userId + model.id + model.creationData.day.toString()}";

      final ref = FirebaseStorage.instance.ref(destination);

      task = ref.putFile(File(model.post));
      Left(task);

      final snapShot = await task.whenComplete(() {});

      final url = await snapShot.ref.getDownloadURL();
      log(url);

      final newPostModel = model.copyWith(post: url);
      final userCollection =
          FirebaseFirestore.instance.collection(Collections.users);
      final usersData = await userCollection.get();

      final postCollection =
          FirebaseFirestore.instance.collection(Collections.post);

      await postCollection.add(newPostModel.toMap());

      final users = usersData.docs.toList();

      users.forEach((user) async {
        final currentUserId = user.data()[UmKeys.userId];
        if (currentUserId == model.userId) {
          final UserModel userModel = UserModel.fromMap(user.data());

          userModel.posts.add(newPostModel.id);

          await userCollection.doc(model.userId).update(userModel.toMap());

          return;
        }
      });

      // for (var user in users) {
      // final currentUserId = user.data()[UmKeys.userId];
      // if (currentUserId == model.userId) {
      //   final posts = user.data()[UmKeys.posts] as List<String>;

      //   posts.add(newPostModel.id);
      //   await userCollection
      //       .doc(model.userId)
      //       .update({UmKeys.posts: posts as List<dynamic>});
      // }
      // }

      log("postModel Uploaded");
      return Left(task);
    } on Exception catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    }
    // throw (e) {
    //   log(e.toString());
    // };
  }

  @override
  Future<Either<List<PostModel>, MainFailures>> getUserPosts(
      {required String userId}) async {
    try {
      final postCollection =
          await FirebaseFirestore.instance.collection(Collections.post).get();

      final posts = postCollection.docs.toList();

      final List<PostModel> showPosts = [];

      for (var post in posts) {
        if (post.data()["id"] == userId) {
          final PostModel postModel = PostModel.fromMap(post.data());
          showPosts.add(postModel);
        } else {
          continue;
        }
      }

      showPosts.sort((a, b) {
        return int.parse(b.creationData.toString()) -
            int.parse(a.creationData.toString());
      });

      return Left(showPosts);
    } on Exception catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    }
    throw UnimplementedError();
  }
}
