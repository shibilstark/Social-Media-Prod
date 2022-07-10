import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/new_post/post_state_values.dart';

import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/local_models/post_type_model.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';

@injectable
class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  final PostRepo _postRepo;
  NewPostBloc(this._postRepo)
      : super(PostInitialState(
            failure: null, post: null, status: PostStateValues.initial)) {
    on<PickPost>((event, emit) async {
      emit(state.copyWith(status: PostStateValues.loading));

      final result = await _postRepo.pickPost(type: event.type);

      final newState = result.fold(
        (post) {
          return state.copyWith(status: PostStateValues.success, post: post);
        },
        (failure) {
          return state.copyWith(
              status: PostStateValues.error,
              failure: MainFailures(
                  failureType: failure.failureType, error: failure.error));
        },
      );

      emit(newState);
    });

    on<UploadPost>((event, emit) async {
      emit(state.copyWith(status: PostStateValues.uploading));
      final result = await _postRepo.uploadPost(model: event.model);

      final newState = result.fold(
        (post) {
          return state.copyWith(
            status: PostStateValues.uploaded,
          );
        },
        (failure) {
          return state.copyWith(
              status: PostStateValues.notUploaded,
              failure: MainFailures(
                  failureType: failure.failureType, error: failure.error));
        },
      );

      emit(newState);
    });
  }
}
