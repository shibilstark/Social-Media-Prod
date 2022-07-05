// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:social_media/core/constants/enums.dart';

class PostTypeModel {
  final FilePickerResult file;
  final PostType type;

  PostTypeModel({required this.file, required this.type});
}
