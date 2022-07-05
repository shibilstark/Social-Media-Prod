import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/new_post/new_post_enums/new_post_enums.dart';
import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/post/post_model.dart';
import 'package:social_media/domain/models/post_type/post_type.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';
part 'new_post_event.dart';
part 'new_post_state.dart';

@injectable
class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  final PostRepo _postServiece;
  NewPostBloc(this._postServiece)
      : super(NewPostInitial(
            post: null,
            status: NewPostEnum.initial,
            failure: null,
            postType: null)) {
    on<SelectPost>((event, emit) async {
      emit(state.copyWith(status: NewPostEnum.loading));
      Either<PostTypeModel?, MainFailures> result;

      if (event.type == PostType.image) {
        result = await _postServiece.pickPost(type: PostType.image);
      } else {
        result = await _postServiece.pickPost(type: PostType.video);
      }

      result.fold(
        (file) {
          if (file == null) {
            emit(state.copyWith(status: NewPostEnum.fileNotPicked));
          }
          emit(state.copyWith(
              status: NewPostEnum.filePicked,
              post: file!.file,
              postType: file.type));
        },
        (err) {
          emit(state.copyWith(
              status: NewPostEnum.fileNotPicked,
              failure: MainFailures(
                  failureType: MyAppFilures.clientFailure, error: err.error)));
        },
      );
    });

    on<UploadPost>((event, emit) async {
      emit(state.copyWith(status: NewPostEnum.loading));
    });
  }
}
