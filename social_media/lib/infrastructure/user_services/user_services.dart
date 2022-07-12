import 'dart:developer';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/user/user_bloc.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/user_services/user_repository.dart';

@LazySingleton(as: UserRepo)
class UserServices implements UserRepo {
  @override
  Future<Either<ProfileFeedModel, MainFailures>> fetchUser(
      {required String id}) async {
    try {
      final user = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(id)
          .get();
      final UserModel userModel = UserModel.fromMap(user.data()!);
      final postsInModel = userModel.posts.toList();
      final postCollection =
          await FirebaseFirestore.instance.collection(Collections.post).get();

      final posts = postCollection.docs.toList();
      final List<PostModel> showPosts = [];
      if (postsInModel.isNotEmpty) {
        for (var post in posts) {
          for (String eachPost in postsInModel) {
            if (eachPost == post.data()['postId']) {
              PostModel postModel = PostModel.fromMap(post.data());

              showPosts.add(postModel);
            } else {
              continue;
            }
          }
        }
      }

      final feed = ProfileFeedModel(user: userModel, post: showPosts);

      return Left(feed);
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }

  @override
  Future<Either<bool, MainFailures>> removeProfileImage() async {
    try {
      final user = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();
      final UserModel userModel = UserModel.fromMap(user.data()!);

      final newUserModel = userModel.copyWith(profileImage: "");

      await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .set(newUserModel.toMap());

      return const Left(true);
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }

  @override
  Future<Either<bool, MainFailures>> changeProfilePic(
      {required String pic}) async {
    try {
      final user = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();

      final UserModel userModel = UserModel.fromMap(user.data()!);

      UploadTask? task;
      final destination =
          "posts/${Global.USER_DATA.id + DateTime.now.toString() + "profileImage"}";

      final ref = FirebaseStorage.instance.ref(destination);
      task = ref.putFile(File(pic));

      final snapShot = await task.whenComplete(() {});
      final url = await snapShot.ref.getDownloadURL();

      final newUserModel = userModel.copyWith(profileImage: url);
      await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .set(newUserModel.toMap());

      await Fluttertoast.showToast(msg: "Profile Changed Successfully");

      return Left(true);
    } on FirebaseException catch (e) {
      await Fluttertoast.showToast(msg: e.code.split("-").join(" "));

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      await Fluttertoast.showToast(msg: e.toString());
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }
}

  // _changeProfilePic({required String pic}) async {
  //   try {
  //     final user = await FirebaseFirestore.instance
  //         .collection(Collections.users)
  //         .doc(Global.USER_DATA.id)
  //         .get();

  //     final UserModel userModel = UserModel.fromMap(user.data()!);

  //     UploadTask? task;
  //     final destination =
  //         "posts/${Global.USER_DATA.id + DateTime.now.toString() + "profileImage"}";

  //     final ref = FirebaseStorage.instance.ref(destination);
  //     task = ref.putFile(File(pic));

  //     final snapShot = await task.whenComplete(() {});
  //     final url = await snapShot.ref.getDownloadURL();

  //     final newUserModel = userModel.copyWith(profileImage: url);
  //     await FirebaseFirestore.instance
  //         .collection(Collections.users)
  //         .doc(Global.USER_DATA.id)
  //         .set(newUserModel.toMap());

  //     await Fluttertoast.showToast(msg: "Profile Changed Successfully");
  //   } on FirebaseException catch (e) {
  //     await Fluttertoast.showToast(msg: e.code.split("-").join(" "));

  //     return Right(MainFailures(
  //         error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
  //   } catch (e) {
  //     await Fluttertoast.showToast(msg: e.toString());
  //     log(e.toString());
  //     return Right(MainFailures(
  //         error: e.toString(), failureType: MyAppFilures.firebaseFailure));
  //   }
  // }

