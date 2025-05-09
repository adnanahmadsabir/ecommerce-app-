import 'dart:io';

import 'package:clothes_app/core/constants.dart';
import 'package:clothes_app/core/my_future_builder.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/ui/providers/auth_provider.dart';
import 'package:clothes_app/ui/providers/file_provider.dart';
import 'package:clothes_app/ui/providers/item_provider.dart';
import 'package:clothes_app/ui/widgets/my_loader.dart';
import 'package:clothes_app/ui/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({super.key});

  // Sing Out confirmation dialog
  void _confirmSignOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
                title: MyText("SignOut", textAlign: leftTxt),
                content: MyText(
                  "Are you sure?\nyou want to Sign Out from app.",
                  textAlign: leftTxt,
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No')),
                  TextButton(
                      onPressed: () =>
                          context.read<AuthProvider>().logOut(context),
                      child: const Text('Yes'))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Widget Rebuilds!");
    final provider = context.read<AuthProvider>();
    return MyFutureBuilder<User?>(
        future: provider.getUser(),
        onData: (user) {
          return Stack(children: [
            Padding(
                padding: padding20,
                child: Column(spacing: 14, children: [
                  Selector<FileProvider, File?>(
                      selector: (_, provider) => provider.getImage,
                      builder: (ctx, image, __) {
                        return Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                                radius: 80,
                                backgroundImage: image != null
                                    ? FileImage(image)
                                    : const AssetImage("images/10.jpg")),
                            IconButton.filled(
                                onPressed: () => context
                                    .read<ItemProvider>()
                                    .toggleButtonsState(),
                                icon: const Icon(Icons.camera_alt_outlined))
                          ],
                        );
                      }),
                  Selector<ItemProvider, bool>(
                      selector: (_, provider) => provider.showButtons,
                      builder: (ctx, showButtons, __) {
                        return showButtons
                            ? Row(
                                spacing: 10,
                                mainAxisAlignment: yAlignCenter,
                                children: [
                                    IconButton(
                                        onPressed: () => ctx
                                            .read<FileProvider>()
                                            .pickImage(isCameraSource: true),
                                        icon: const Icon(
                                          Icons.camera_alt,
                                        )),
                                    IconButton(
                                        onPressed: () => ctx
                                            .read<FileProvider>()
                                            .pickImage(),
                                        icon: const Icon(
                                          Icons.photo,
                                        ))
                                  ])
                            : const SizedBox();
                      }),
                  _containerWidget(Icons.person, user!.name ?? "Unknown"),
                  _containerWidget(
                      Icons.email, user.email ?? "example@gmail.com"),
                  FilledButton(
                      onPressed: () => _confirmSignOut(context),
                      child: const Text("Sign Out"))
                ])),
            Selector<FileProvider, bool>(
                selector: (_, provider) => provider.isLoading,
                builder: (_, isLoading, __) => MyLoader(isLoading: isLoading))
          ]);
        });
  }

  // widget
  Card _containerWidget(IconData icon, String title) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: padding10,
        child: Row(
          spacing: 12,
          children: [Icon(icon), MyText(title, fontWeight: bold)],
        ),
      ),
    );
  }
}
