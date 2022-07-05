import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/post/post_model.dart';
import 'package:social_media/domain/models/post_type/post_type.dart';

abstract class PostRepo {
  Future<Either<PostTypeModel?, MainFailures>> pickPost(
      {required PostType type});
  Future<Either<UploadTask, MainFailures>> uploadPost(
      {required PostModel model});
  Future<Either<List<PostModel>, MainFailures>> getUserPosts(
      {required String userId});
}
