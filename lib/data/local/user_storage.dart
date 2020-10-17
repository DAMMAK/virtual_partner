import 'package:hive/hive.dart';
import 'package:tikbot/data/local/user.dart';

class UserStorage {
  static const _userStorageBox = 'user';

  UserStorage._();

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<UserStorage> getInstance() async {
    await Hive.openBox(_userStorageBox);
    return UserStorage._();
  }

  void addUser(User user) {
    final userBox = Hive.box(_userStorageBox);
    userBox.add(user);
  }

  User getCurrentUser() {
    final userBox = Hive.box(_userStorageBox);
    // Since Hive doesn't provide a Query Mechanism like sharedPreferences fir now am querying for the first inserted row in the db
    return userBox.get(0) as User ?? User(name: "", email: "");
  }
}
