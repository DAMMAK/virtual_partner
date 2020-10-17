import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType()
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  User({this.name, this.email});

  @override
  String toString() {
    return 'User{name: $name, email: $email}';
  }
}
