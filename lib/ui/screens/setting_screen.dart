import 'package:clothes_app/ui/providers/theme_provider.dart';
import 'package:clothes_app/ui/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: myAppbar(
            context: context,
            title: "Settings",
            isLeading: true,
            actions: [
              Selector<ThemeProvider, bool>(
                  selector: (_, provider) => provider.isDarkMode,
                  builder: (ctx, isDarkMode, __) => Switch.adaptive(
                      value: isDarkMode,
                      onChanged: (_) =>
                          ctx.read<ThemeProvider>().toggleDarkMode()))
            ]),
      );
}
