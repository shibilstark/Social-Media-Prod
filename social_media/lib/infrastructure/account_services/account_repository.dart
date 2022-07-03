import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/constants/user_model_keys.dart';
import 'package:social_media/domain/db/user_cred/user_cred.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/infrastructure/account_services/account_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/main.dart';

@LazySingleton(as: AccountServices)
class UsersAccountRepository implements AccountServices {
//
//
//
//
// Createing New User
  @override
  Future<Either<bool, MainFailures>> creeteAccount(
      {required UserModel model}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      final usersCollection = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(model.userId);
      final data = model.toMap();
      usersCollection.set(data);

      return const Left(true);
    } on FirebaseException catch (e) {
      Right(FirebaseFailure(err: e.toString().split("-").join(" ")));
    } catch (e) {
      return const Right(MainFailures(
        failureType: MyAppFilures.clientFailure,
        error: "Some thing went wrong",
      ));
    }
    return const Right(MainFailures(
        error: "Something Went Wrong",
        failureType: MyAppFilures.clientFailure));
  }

//
//
//
//
// Sending Verifiaction Email

  @override
  Future<Either<bool, MainFailures>> loginToAccount(
      {required String email, required String password}) async {
    String? currentUserId;

    try {
      final usersCollection =
          await FirebaseFirestore.instance.collection(Collections.users).get();

      final users = usersCollection.docs;

      for (var user in users) {
        if (user.data()["email"] == email &&
            user.data()["password"] == password) {
          final model = UserModel.fromMap(user.data());

          // final userIdObj = UserId(
          //   userID: model.userId.toString(),
          //   email: model.email.toString(),
          //   pass: model.password.toString(),
          // );

          final userIdObj =
              UserId(userID: model.userId, email: email, pass: password);
          await UserCredStore.saveUserCred(userId: userIdObj);

          final userData = (await UserCredStore.getUserCred())!;

          Global.USER_ID = userData.userID;

          if (model.isEmailVerified == true) {
            return const Left(true);
          } else {
            return const Left(false);
          }
        } else {
          return const Right(MainFailures(
              error: "Password or Email is Incorrect",
              failureType: MyAppFilures.emailOrPasswordFailure));
        }
      }
    } on FirebaseException catch (e) {
      return Right(FirebaseFailure(err: e.toString()));
    } catch (e) {
      return Right(ClientFailure(err: e.toString()));
    }

    return const Right(MainFailures(
        failureType: MyAppFilures.clientFailure,
        error: "Something Went Wrong"));
  }

//
//
//
//
// Verify Email

  @override
  Future<Either<bool, MainFailures>> sendVerificationEmail() async {
    try {
      log("hood");
      final UserId userId = (await UserCredStore.getUserCred())!;

      log(" check ${userId.email}");
      log(" check ${userId.pass}");
      log(" check ${userId.userID}");

      log("verification emial sending to  ${userId.email}");

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userId.email, password: userId.pass);

      final user = FirebaseAuth.instance.currentUser!;

      await user.sendEmailVerification();
      log("verification emial send,check email ${userId.email}");
      return const Left(true);
    } on FirebaseException catch (e) {
      log(e.toString());
      return Right(FirebaseFailure(err: e.toString().split("-").join(" ")));
    } catch (e) {
      log(e.toString());
      return const Right(MainFailures(
          failureType: MyAppFilures.clientFailure,
          error: "Something went wrong"));
    }
  }

  @override
  Future<Either<bool, MainFailures>> verifyEmail() async {
    try {
      log("started");
      final userData = (await UserCredStore.getUserCred())!;
      final newUser = FirebaseAuth.instance.currentUser!;
      await newUser.reload();
      log("reloaded");
      final bool isEmailVerifiedByUser = newUser.emailVerified;
      if (isEmailVerifiedByUser) {
        final userCollection =
            FirebaseFirestore.instance.collection(Collections.users);
        final usersData = await userCollection.get();

        final users = usersData.docs.toList();

        for (var user in users) {
          final pass = user.data()["password"];
          final mail = user.data()["email"];

          if (mail == userData.email && pass == userData.pass) {
            final userID = user.data()["userId"];

            userCollection.doc(userID).update({
              UserModelKeys.isEmailVerified: true,
            });

            log("updated");

            return const Left(true);
          } else {
            log("error");
            return const Right(MainFailures(
                failureType: MyAppFilures.emailOrPasswordFailure,
                error: "Email or Password went wrong"));
          }
        }
      } else {
        const Right(MainFailures(
            error: "Email NotVerified",
            failureType: MyAppFilures.emailOrPasswordFailure));
      }
    } on FirebaseAuthException catch (e) {
      return Right(MainFailures(
          failureType: MyAppFilures.firebaseFailure, error: e.toString()));
    }
    throw (e) {
      return const Right(MainFailures(
        failureType: MyAppFilures.clientFailure,
        error: "Something went wrong ",
      ));
    };
  }

  @override
  Future<Either<bool, MainFailures>> logOut(
      {required String email, required String password}) {
    throw UnimplementedError();
  }
}
