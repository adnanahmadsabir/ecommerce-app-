import 'package:clothes_app/data/models/user_model.dart';
import 'package:clothes_app/features/users/domain/repos/sign_up_repo.dart';

class SignUpUseCase {
  final SignUpRepo signUpRepo;
  SignUpUseCase(this.signUpRepo);
  SignUpRepo get repo => signUpRepo;

  Future<List<dynamic>?> signUp(
      String name, String email, String password) async {
    final data =
        UserModel(name: name, email: email, password: password).toJson();
    final result = await repo.signUp(data);
    if (result == null) return null;
    final status = result['success'] as bool;
    return [status, result['message']];
  }
}
