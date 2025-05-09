import 'package:clothes_app/core/constants.dart';
import 'package:clothes_app/core/label_keys.dart';
import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/core/validators.dart';
import 'package:clothes_app/ui/providers/auth_provider.dart';
import 'package:clothes_app/ui/screens/login_screen.dart';
import 'package:clothes_app/ui/widgets/my_fonts.dart';
import 'package:clothes_app/ui/widgets/my_loading_button.dart';
import 'package:clothes_app/ui/widgets/my_text_button.dart';
import 'package:clothes_app/ui/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20,
                  children: [
                    // login screen header
                    Utils.bottomRightCornerRoundImage(
                        context, "images/cloth_template.jpg"),
                    Container(
                      padding: padding20,
                      margin: padding16,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            spacing: 10,
                            children: [
                              MyTextField(
                                  hintText: nameKey,
                                  prefixIcon: const Icon(Icons.person),
                                  validator: (text) =>
                                      Validators.checkName(text),
                                  controller: provider.nameCtrl),
                              MyTextField(
                                  hintText: emailKey,
                                  prefixIcon: const Icon(Icons.email),
                                  controller: provider.emailCtrl,
                                  validator: (text) =>
                                      Validators.checkEmail(text)),
                              Selector<AuthProvider, bool>(
                                  selector: (_, provider) => provider.isObscure,
                                  builder: (_, isObscure, __) {
                                    return MyTextField(
                                        hintText: passwordKey,
                                        prefixIcon: const Icon(
                                          Icons.password,
                                        ),
                                        isObscure: isObscure,
                                        suffixIcon: GestureDetector(
                                          onTap: provider.toggleObscure,
                                          child: Icon(
                                            isObscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                        controller: provider.passwordCtrl,
                                        validator: (text) =>
                                            Validators.checkPassword(text));
                                  }),
                              Column(
                                children: [
                                  MyLoadingButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await provider.signUpUser(context);
                                      }
                                    },
                                    title: "Sign Up"
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 4,
                                    children: [
                                      MyFonts.labelL(
                                          "Already have an account?"),
                                      MyTextButton(
                                        onPressed: () => Utils.getPage(
                                            context, LoginScreen()),
                                        title: loginKey,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            );
          })
    );
  }
}
