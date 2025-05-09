import 'package:clothes_app/data/services/api_service.dart';
import 'package:clothes_app/data/services/pref_service.dart';
import 'package:clothes_app/features/users/domain/repos/sign_up_repo.dart';
import 'package:flutter/cupertino.dart';

class SignUpRepoImpl implements SignUpRepo {
  final PrefService prefService;
  final ApiService apiService;

  SignUpRepoImpl(this.prefService, this.apiService);

  @override
  Future<Map<String, dynamic>?> signUp(Map<String, dynamic> data) async {
    try {
      final result = await apiService.post('user/sign_up.php', data);
      debugPrint("$result");
      if (result == null) return null;
      final msg = result['message'] as bool;
      debugPrint("Result $result");
      if (msg) {
        await prefService.set(data);
        return result;
      }
      return result['data'];
    } catch (e) {
      debugPrint("Error Occur $e");
      return null;
    }
  }
}
