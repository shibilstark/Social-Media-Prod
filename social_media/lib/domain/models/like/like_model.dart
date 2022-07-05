// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostLights {
  final String lighterId;
  final DateTime date;

  PostLights({
    required this.lighterId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lighterId': lighterId,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory PostLights.fromMap(Map<String, dynamic> map) {
    return PostLights(
      lighterId: map['lighterId'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostLights.fromJson(String source) =>
      PostLights.fromMap(json.decode(source) as Map<String, dynamic>);
}
