import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/user/user_bloc.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/local_models/post_type_model.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';
import 'package:social_media/infrastructure/user_services/user_repository.dart';
import 'package:social_media/infrastructure/user_services/user_services.dart';

part 'upload_post_event.dart';
part 'upload_post_state.dart';

@injectable
class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  final PostRepo _postRepo;
  UploadPostBloc(this._postRepo) : super(UploadPostInitial()) {
    on<UploadPost>((event, emit) async {
      emit(UploadPostLoading());
      final result = await _postRepo.uploadPost(model: event.postModel);

      final newState = result.fold(
        (status) {
          final UserRepo userRepo = UserServices();

          UserBloc bloc = UserBloc(userRepo);

          bloc.add(FetchCurrentUser(id: Global.USER_DATA.id));
          return UploadPostSuccess(status: status);
        },
        (failure) {
          return UploadPostError(failure: failure);
        },
      );

      emit(newState);
    });
  }
}
