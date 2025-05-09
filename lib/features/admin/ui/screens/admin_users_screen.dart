import 'package:clothes_app/core/my_future_builder.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/features/admin/ui/providers/admin_users_provider.dart';
import 'package:clothes_app/ui/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            myAppbar(context: context, title: "Users Info", isLeading: true),
        body: MyFutureBuilder<List<User?>>(
            future: context.watch<AdminUsersProvider>().get(),
            onData: (users) => users.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (_, index) {
                      final user = users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: 20,
                          ),
                        ),
                        title: Text(user!.name.toString()),
                        subtitle: Text(user.email.toString()),
                      );
                    })));
  }
}
