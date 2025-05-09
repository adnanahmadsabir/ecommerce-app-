import 'package:clothes_app/domain/entities/user.dart';

abstract class AdminUsersRepo {
  Future<List<User?>?> get();
}
