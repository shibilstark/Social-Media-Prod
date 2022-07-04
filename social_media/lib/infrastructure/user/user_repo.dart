import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

abstract class UserRepo {
  Future<Either<UserModel, MainFailures>> getCurrentUser();
  Future<Either<UserModel, MainFailures>> getUeserWithId({required String id});
}
