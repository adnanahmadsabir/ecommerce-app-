import 'package:clothes_app/core/my_future_builder.dart';
import 'package:clothes_app/core/utils.dart';
import 'package:clothes_app/domain/entities/user.dart';
import 'package:clothes_app/ui/providers/auth_provider.dart';
import 'package:clothes_app/ui/providers/nav_bar_provider.dart';
import 'package:clothes_app/ui/screens/dashboard/fragments/favourites_fragment.dart';
import 'package:clothes_app/ui/screens/dashboard/fragments/home_fragment.dart';
import 'package:clothes_app/ui/screens/dashboard/fragments/order_fragment.dart';
import 'package:clothes_app/ui/screens/dashboard/fragments/profile_fragment.dart';
import 'package:clothes_app/ui/screens/login_screen.dart';
import 'package:clothes_app/ui/screens/setting_screen.dart';
import 'package:clothes_app/ui/widgets/my_appbar.dart';
import 'package:clothes_app/ui/widgets/my_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _fragmentScreenList = [
    HomeFragment(),
    OrderFragment(),
    FavouritesFragment(),
    ProfileFragment(),
  ];

  List<AppBar> _appBarList(BuildContext context) {
    return [
      myAppbar(toolBarHeight: 10, context: context, title: ''),
      myAppbar(
        context: context,
        title: "Order",
        centerTitle: true,
      ),
      myAppbar(
        context: context,
        title: "Favourite",
        centerTitle: true,
      ),
      myAppbar(
        context: context,
        title: "Profile",
        centerTitle: true,
        actions: [
          MyIconButton(
            icon: Icons.more_vert,
            onPressed: () => Utils.getPage(context, SettingScreen()),
          )
        ],
      ),
    ];
  }

  static const _navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.boxOpen), label: "Order"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile")
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();
    debugPrint('Widget Build Context!');
    return MyFutureBuilder<User?>(
        future: provider.getUser(),
        onNoData: LoginScreen(),
        onData: (snapShot) {
          return Selector<NavBarProvider, int>(
              selector: (_, provider) => provider.currentIndex,
              builder: (ctx, index, __) => Scaffold(
                    appBar: _appBarList(context)[index],
                    body: SingleChildScrollView(
                      child: SizedBox(
                          width: double.infinity,
                          child: _fragmentScreenList[index]),
                    ),
                    bottomNavigationBar: _bottomNavigationBar(context, index),
                  ));
        });
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context, int index) {
    return BottomNavigationBar(
      items: _navBarItems,
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      onTap: (int index) {
        context.read<NavBarProvider>().changeIndex(index);
        debugPrint('Index is: $index');
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
