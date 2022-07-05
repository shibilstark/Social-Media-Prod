import 'package:injectable/injectable.dart';
import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:file_picker/src/file_picker_result.dart';
import 'package:file_picker/src/file_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/post/post_model.dart';
import 'package:social_media/domain/models/post_type/post_type.dart';
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
  Future<Either<bool, MainFailures>> uploadPost({required PostModel model}) {
    // TODO: implement uploadPost
    throw UnimplementedError();
  }
}
