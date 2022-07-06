import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:social_media/application/get_post/get_post_enums/get_post_enums.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/global_feed_model/global_feed_model.dart';
import 'package:social_media/domain/models/post/post_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';
import 'package:social_media/infrastructure/post/post_services.dart';

part 'get_post_event.dart';
part 'get_post_state.dart';

@injectable
class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  final PostRepo _postRepo;
  GetPostBloc(this._postRepo)
      : super(GetPostInitial(
            status: GetPostEnums.initial,
            failure: null,
            posts: null,
            feed: null)) {
    on<GetPost>((event, emit) async {
      emit(state.copyWith(status: GetPostEnums.loading));

      final result = await _postRepo.getUserPosts(userId: event.userId);

      result.fold(
        (posts) {
          emit(state.copyWith(status: GetPostEnums.success, posts: posts));
        },
        (error) {
          emit(state.copyWith(
              status: GetPostEnums.error,
              failure: MainFailures(
                  failureType: error.failureType, error: error.error)));
        },
      );
    });

    on<GetAllPostFeeds>((event, emit) async {
      emit(state.copyWith(status: GetPostEnums.loading));

      final result = await _postRepo.getAllPostFeeds();

      result.fold(
        (posts) {
          posts.shuffle();
          emit(state.copyWith(status: GetPostEnums.success, feed: posts));
        },
        (error) {
          emit(state.copyWith(
              status: GetPostEnums.error,
              failure: MainFailures(
                  failureType: error.failureType, error: error.error)));
        },
      );
    });
  }
}
