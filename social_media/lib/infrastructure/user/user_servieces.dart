import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/infrastructure/user/user_repo.dart';

@LazySingleton(as: UserRepo)
class UserServices implements UserRepo {
  @override
  Future<Either<UserModel, MainFailures>> getCurrentUser() async {
    try {
      final userData = (await UserDataStore.getUserData());

      if (userData == null) {
        return Right(MainFailures(
            error: "User Not Found", failureType: MyAppFilures.userNotFound));
      } else {
        final currentUser = await FirebaseFirestore.instance
            .collection(Collections.users)
            .doc(userData.id)
            .get();

        final UserModel model = UserModel.fromMap(currentUser.data()!);

        return Left(model);
      }
    } on FirebaseException catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }

  @override
  Future<Either<UserModel, MainFailures>> getUeserWithId(
      {required String id}) async {
    try {
      final currentUser = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(id)
          .get();
      final UserModel model = UserModel.fromMap(currentUser.data()!);

      return Left(model);
    } on FirebaseException catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }
}
