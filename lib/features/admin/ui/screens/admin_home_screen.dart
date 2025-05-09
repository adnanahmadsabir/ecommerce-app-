import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/features/admin/ui/providers/admin_users_provider.dart';
import 'package:clothes_app/features/admin/ui/screens/admin_users_screen.dart';
import 'package:clothes_app/ui/widgets/my_appbar.dart';
import 'package:clothes_app/ui/widgets/my_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppbar(
            context: context,
            isLeading: true,
            title:
                "Total users: ${context.watch<AdminUsersProvider>().totalUsers.toString()}",
            actions: [
              IconButton(
                  onPressed: () => Utils.getPage(context, AdminUsersScreen()),
                  icon: const Icon(Icons.groups))
            ]),
        // drawer: AdminDrawer(),
        body: Center(
            child: Stack(alignment: AlignmentDirectional.center, children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.4,
                    fit: BoxFit.cover,
                    image: const AssetImage('images/cloth_template.jpg'))),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                spacing: 10,
                children: [
                  const Icon(Icons.add_photo_alternate_rounded,
                      color: Colors.black54, size: 150),
                  FilledButton.icon(
                      onPressed: () => showDialogForSelectImage(context),
                      label: const Text('Add New Item'),
                      icon: const Icon(Icons.add)),
                ],
              ),
            ),
          ),
        ])));
  }

  void showDialogForSelectImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          final provider = context.read<AdminUsersProvider>();
          return Stack(
            children: [
              SimpleDialog(
                title: const Text("Item Image"),
                children: [
                  SimpleDialogOption(
                      onPressed: () => provider.selectImage(
                          context: context, isCameraSource: true),
                      child: const Text("Capture Image with phone camera")),
                  SimpleDialogOption(
                      onPressed: () => provider.selectImage(context: context),
                      child: const Text("Pick Image from gallery")),
                  SimpleDialogOption(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.redAccent),
                      )),
                ],
              ),
              Selector<AdminUsersProvider, bool>(
                  selector: (_, provider) => provider.isLoading,
                  builder: (_, isLoading, __) => MyLoader(isLoading: isLoading))
            ],
          );
        });
  }
}
