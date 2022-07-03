import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

abstract class AccountServices {
  Future<Either<bool, MainFailures>> creeteAccount({required UserModel model});
  Future<Either<bool, MainFailures>> sendVerificationEmail();

  Future<Either<bool, MainFailures>> loginToAccount(
      {required String email, required String password});
  Future<Either<bool, MainFailures>> logOut(
      {required String email, required String password});
  Future<Either<bool, MainFailures>> verifyEmail();
}
