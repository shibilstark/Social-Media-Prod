import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/controllers/text_editing_controllers.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/infrastructure/accounts/account_repo.dart';

@LazySingleton(as: AccountRepo)
class AccountServices implements AccountRepo {
  //
  //
  //
  //
  //
  //
  //
  //
  @override
  Future<Either<UserModel, MainFailures>> createAccount(
      {required String password, required UserModel model}) async {
    try {
      final collection =
          FirebaseFirestore.instance.collection(Collections.users);

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: model.email, password: password);

      await collection.doc(model.userId).set(model.toMap());

      return Left(model);
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    }
  }

  //
  //
  //
  //
  //
  //
  //
  //
  @override
  Future<Either<UserModel, MainFailures>> login(
      {required String email, required String password}) async {
    try {
      final collection =
          await FirebaseFirestore.instance.collection(Collections.users).get();
      final users = collection.docs;

      for (var user in users) {
        if (user.data()[UmKeys.email] == email) {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          // final User currentUser = userCred.user!;

          await UserDataStore.saveUserData(
              id: user.data()[UmKeys.userId], email: email);
          return Left(UserModel.fromMap(user.data()));
        } else {
          return const Right(MainFailures(
              error: "User Not Found",
              failureType: MyAppFilures.emailOrPasswordFailure));
        }
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

    return const Right(MainFailures(
        error: "Something went wrong",
        failureType: MyAppFilures.clientFailure));
  }

  //
  //
  //
  //
  //
  //
  //
  //
  @override
  Future<Either<UserModel, MainFailures>> logOut() async {
    try {
      await UserDataStore.clearUserData();
      await FirebaseAuth.instance.signOut();
    } on FirebaseException catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }

    return const Right(MainFailures(
        error: "Something went wrong",
        failureType: MyAppFilures.clientFailure));
  }

  //
  //
  //
  //
  //
  //
  //
  //
  @override
  Future<Either<bool, MainFailures>> sendVerifiacationEmail(
      {required String email}) async {
    try {
      final userData = (await UserDataStore.getUserData())!;
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      log("verification emial send,check email ${userData.email}");

      return const Left(true);
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

  //
  //
  //
  //
  //
  //
  //
  //
  @override
  Future<Either<bool, MainFailures>> verifyEmail(
      {required String email}) async {
    try {
      final userData = (await UserDataStore.getUserData())!;
      final newUser = FirebaseAuth.instance.currentUser!;
      await newUser.reload();

      if (newUser.emailVerified) {
        final userCollection =
            FirebaseFirestore.instance.collection(Collections.users);
        final usersData = await userCollection.get();

        final users = usersData.docs.toList();

        for (var user in users) {
          final mail = user.data()["email"];

          if (mail == userData.email) {
            final userID = user.data()["userId"];

            userCollection.doc(userID).update({
              UmKeys.isEmailVerified: true,
            });

            log("updated");
            return const Left(true);
          } else {
            return Right(MainFailures(
                error: "Email Not Match",
                failureType: MyAppFilures.emailOrPasswordFailure));
          }
        }
      } else {
        return const Left(false);
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

    return const Right(MainFailures(
        error: "Something went wrong",
        failureType: MyAppFilures.clientFailure));
  }

  @override
  Future<Either<bool, MainFailures>> checkEmailVerified() async {
    try {
      Timer? timer;
      bool isVerfied = false;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Global.USER_DATA.email,
          password:
              TextFieldAuthenticationController.loginPassword.text.trim());

      final user = FirebaseAuth.instance.currentUser!;
      checkInstance() async {
        await user.reload();
        isVerfied = user.emailVerified;
        if (isVerfied) {
          if (timer!.isActive) {
            timer.cancel();
          }
          return const Left(true);
        } else {
          Left(false);
        }
      }

      timer = Timer.periodic(Duration(seconds: 3), (_) {
        log("checking");
        checkInstance();
      });
    } on FirebaseException catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
    return const Right(MainFailures(
        error: "Something went wrong",
        failureType: MyAppFilures.clientFailure));
  }
}
