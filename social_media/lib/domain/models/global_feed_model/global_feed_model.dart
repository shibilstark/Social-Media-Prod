import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

class GlobalFeed {
  final PostModel postModel;
  final UserModel userModel;

  GlobalFeed({required this.postModel, required this.userModel});
}
