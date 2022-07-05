import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/post/post_model.dart';
import 'package:social_media/domain/models/post_type/post_type.dart';

abstract class PostRepo {
  Future<Either<PostTypeModel?, MainFailures>> pickPost(
      {required PostType type});
  Future<Either<bool, MainFailures>> uploadPost({required PostModel model});
}
