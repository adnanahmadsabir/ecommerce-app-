import 'package:clothes_app/domain/entities/user.dart';

/// Datatype short-cut
typedef FutureMap = Future<Map<String, dynamic>?>;

abstract class LoginRepo {
  FutureMap loginUser(Map<String, dynamic> data);
  FutureMap loginAdmin(Map<String, dynamic> data);
  Future<User?> getUser();
  Future<void> logOut();
}
