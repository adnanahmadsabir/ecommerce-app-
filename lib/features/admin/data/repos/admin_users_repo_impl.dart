import 'package:clothes_app/data/services/api_service.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/features/admin/domain/repos/admin_users_repo.dart';
import 'package:flutter/cupertino.dart';

class AdminUsersRepoImpl implements AdminUsersRepo {
  final ApiService apiService;
  AdminUsersRepoImpl(this.apiService);

  @override
  Future<List<User?>?> get() async {
    // TODO: implement get
    try {
      final users = <User?>[];
      final result = await apiService.get("admin/users_info.php");
      if (result == null) return null;
      for (var user in result['message']) {
        users.add(User(name: user[0], email: user[1]));
      }
      return users;
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }
}
