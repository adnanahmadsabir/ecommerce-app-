import 'package:clothes_app/data/models/user_model.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/domain/repos/login_repo.dart';
import 'package:flutter/cupertino.dart';

class LoginUseCase {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);

  LoginRepo get _repo => loginRepo;

  Future<bool?> loginUser(String email, String password) async {
    final data = UserModel(email: email, password: password).toJson();
    debugPrint("$data");
    final result = await _repo.loginUser(data);
    if (result == null) return null;
    return result['success'] == false ? false : true;
  }

  Future<bool?> loginAdmin(String email, String password) async {
    final data = UserModel(email: email, password: password).toJson();

    final result = await _repo.loginAdmin(data);
    if (result == null) return null;
    return result['success'] == false ? false : true;
  }

  Future<User?> getUser() async => await _repo.getUser();

  Future<void> logOut() async {
    await _repo.logOut();
  }
}
