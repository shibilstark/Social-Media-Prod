import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';

abstract class UserRepo {
  Future<Either<ProfileFeedModel, MainFailures>> fetchUser(
      {required String id});
  Future<Either<bool, MainFailures>> removeProfileImage();
  Future<Either<bool, MainFailures>> changeProfilePic({required String pic});
}
