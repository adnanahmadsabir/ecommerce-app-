import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/features/admin/ui/screens/admin_users_screen.dart';
import 'package:clothes_app/ui/widgets/my_fonts.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        spacing: 10,
        children: [
          _container(context, false),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  onTap: () => Utils.getPage(context, AdminUsersScreen()),
                  leading: Icon(
                    Icons.group,
                  ),
                  title: MyFonts.headlineS("Customers"),
                )
              ],
            ),
          ),
          _container(context, true)
        ],
      ),
    );
  }

  Widget _container(BuildContext context, bool isBorderOnTop) {
    return Container(
        height: MediaQuery.sizeOf(context).height * 0.08,
        decoration: BoxDecoration(
            border: isBorderOnTop
                ? Border(top: BorderSide())
                : Border(bottom: BorderSide())));
  }
}
