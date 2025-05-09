import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/domain/usecases/login_use_case.dart';
import 'package:clothes_app/domain/usecases/sign_up_use_case.dart';
import 'package:clothes_app/features/admin/ui/screens/admin_home_screen.dart';
import 'package:clothes_app/ui/screens/dashboard/dashboard_screen.dart';
import 'package:clothes_app/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  AuthProvider(this.loginUseCase, this.signUpUseCase);

  /// Variables
  bool _isObscure = true;
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();

  /// Getters
  bool get isObscure => _isObscure;
  String get email => emailCtrl.text;
  String get password => passwordCtrl.text;
  String get name => nameCtrl.text;

  /// Events {
  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void resetFieldsCtrl({bool isClearNameCtrl = false}) {
    emailCtrl.clear();
    passwordCtrl.clear();
    if (isClearNameCtrl) nameCtrl.clear();
  }

  /// HTTP EVENTS
  Future<void> _handleLogin(BuildContext context, {bool isUser = true}) async {
    final result = isUser
        ? await loginUseCase.loginUser(email, password)
        : await loginUseCase.loginAdmin(email, password);
    if (!context.mounted) return;
    switch (result) {
      case null:
        Utils.showSnackBar(context, "Something went wrong!");
        break;
      case false:
        Utils.showSnackBar(context, "Invalid email or password!");
        break;
      default:
        resetFieldsCtrl();
        Utils.getPage(context, isUser ? DashboardScreen() : AdminHomeScreen());
    }
  }

  /// }

  Future<void> loginUser(BuildContext context) async {
    await _handleLogin(context);
  }

  Future<void> loginAdmin(BuildContext context) async {
    await _handleLogin(context, isUser: false);
  }

  // fun for sign up new user
  Future<void> signUpUser(BuildContext context) async {
    final result = (await signUpUseCase.signUp(name, email, password) ??
        [false, "Something went wrong!"]);
    debugPrint("$result");
    final msg = result.last;
    if (!context.mounted) return;
    switch (result.first) {
      case null:
        Utils.errorToast(context);
        break;
      case false:
        Utils.showSnackBar(context, msg);
        break;
      default:
        resetFieldsCtrl(isClearNameCtrl: true);
        Utils.showSnackBar(context, msg);
        Utils.getPage(context, DashboardScreen());
    }
  }

  Future<User?> getUser() async => await loginUseCase.getUser();
  Future<void> logOut(BuildContext context) async {
    await loginUseCase.logOut();
    if (context.mounted) Utils.getPage(context, LoginScreen());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
