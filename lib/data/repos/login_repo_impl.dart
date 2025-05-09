import 'package:clothes_app/data/services/api_service.dart';
import 'package:clothes_app/data/services/pref_service.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/domain/repos/login_repo.dart';
import 'package:flutter/cupertino.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiService apiService;
  final PrefService prefService;
  LoginRepoImpl(this.apiService, this.prefService);

  Future<void> _handleInfo(Map<String, dynamic>? info) async {
    debugPrint("$info");

    if (info == null) return;
    if (info['success'] == false) return;
    await prefService.set(info);
  }

  @override
  FutureMap loginUser(Map<String, dynamic> data) async {
    try {
      final result = await apiService.post('user/login.php', data);
      final info = result!['data'] as Map<String, dynamic>?;
      await _handleInfo(info);
      debugPrint("$result");
      return result;
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }

  @override
  FutureMap loginAdmin(Map<String, dynamic> data) async {
    try {
      final result = await apiService.post('admin/login.php', data);
      final info = result!['data'] as Map<String, dynamic>?;
      _handleInfo(info);
      return result;
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }

  @override
  Future<User?> getUser() async {
    return await prefService.get();
  }

  @override
  Future<void> logOut() async {
    await prefService.remove();
  }
}
