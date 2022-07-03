import 'package:hive_flutter/adapters.dart';
import 'package:social_media/domain/db/db_values.dart';
part 'user_cred.g.dart';

@HiveType(typeId: 4)
class UserId {
  @HiveField(0)
  final String userID;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String pass;
  UserId({required this.userID, required this.email, required this.pass});
}

class UserCredStore {
  static saveUserCred({required UserId userId}) async {
    final db = await Hive.openBox<UserId>(DbValues.userCred);
    await db.clear();
    await db.add(userId);
  }

  static clearUserCred() async {
    final db = await Hive.openBox<UserId>(DbValues.userCred);
    await db.clear();
  }

  static Future<UserId?> getUserCred() async {
    final db = await Hive.openBox<UserId>(DbValues.userCred);
    final data = db.values.first;
    return data;
  }
}
