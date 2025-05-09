import 'package:clothes_app/core/constants.dart';
import 'package:clothes_app/core/label_keys.dart';
import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/core/validators.dart';
import 'package:clothes_app/features/admin/ui/screens/admin_login_screen.dart';
import 'package:clothes_app/features/users/ui/screens/sign_up_screen.dart';
import 'package:clothes_app/ui/providers/auth_provider.dart';
import 'package:clothes_app/ui/widgets/my_fonts.dart';
import 'package:clothes_app/ui/widgets/my_loading_button.dart';
import 'package:clothes_app/ui/widgets/my_password_text_field.dart';
import 'package:clothes_app/ui/widgets/my_text_button.dart';
import 'package:clothes_app/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();
    return Scaffold(
      body: LayoutBuilder(builder: (context, cons) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: cons.maxHeight),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                Utils.bottomRightCornerRoundImage(
                    context, "images/clothes.jpg"),
                // login screen header
                Container(
                  padding: padding20,
                  margin: padding16,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: 10,
                        children: [
                          MyTextField(
                              hintText: emailKey,
                              prefixIcon: const Icon(Icons.email),
                              controller: provider.emailCtrl,
                              validator: (text) =>
                                  Validators.checkEmail(text)),
                          MyPasswordTextField(controller: provider.passwordCtrl, hintText: passwordKey),
                          // Selector<AuthProvider, bool>(
                          //     selector: (_, provider) => provider.isObscure,
                          //     builder: (_, isObscure, __) => MyTextField(
                          //         hintText: passwordKey,
                          //         prefixIcon: const Icon(
                          //           Icons.password,
                          //         ),
                          //         isObscure: isObscure,
                          //         suffixIcon: GestureDetector(
                          //           onTap: provider.toggleObscure,
                          //           child: Icon(
                          //             isObscure
                          //                 ? Icons.visibility_off
                          //                 : Icons.visibility,
                          //           ),
                          //         ),
                          //         controller: provider.passwordCtrl,
                          //         validator: (text) =>
                          //             Validators.checkPassword(text))),
                          MyLoadingButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await provider.loginUser(context);
                              }
                            },
                            title: loginKey,
                          ),
                          Column(
                            spacing: 2,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 4,
                                children: [
                                  MyFonts.titleS("Don't have an account?"),
                                  MyTextButton(
                                      onPressed: () => Utils.getPage(
                                          context, SignUpScreen()),
                                      title: 'Register Now')
                                ],
                              ),
                              MyFonts.titleM("OR"),
                              Row(
                                mainAxisAlignment: yAlignCenter,
                                spacing: 4,
                                children: [
                                  MyFonts.titleS(
                                    "Are you an admin?",
                                  ),
                                  MyTextButton(
                                      onPressed: () {
                                        provider.resetFieldsCtrl();
                                        Utils.getPage(
                                            context, AdminLoginScreen());
                                      },
                                      title: 'Check Now')
                                ],
                              )
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
