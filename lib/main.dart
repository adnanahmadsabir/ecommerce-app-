import 'dart:async';

import 'package:clothes_app/injection.dart';
import 'package:clothes_app/ui/providers/theme_provider.dart';
import 'package:clothes_app/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final inj = Injection();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => inj.authProvider),
      ChangeNotifierProvider(create: (_) => inj.themeProvider),
      ChangeNotifierProvider(create: (_) => inj.adminUsersProvider),
      ChangeNotifierProvider(create: (_) => inj.uploadItemProvider),
      ChangeNotifierProvider(create: (_) => inj.searchBarProvider),
      ChangeNotifierProvider(create: (_) => inj.itemProvider),
      ChangeNotifierProvider(create: (_) => inj.navBarProvider),
      ChangeNotifierProvider(create: (_) => inj.fileProvider)
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  StreamSubscription<Positioned>? _streamSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        _streamSubscription?.pause();
        break;
      case AppLifecycleState.resumed:
        _streamSubscription?.resume();
        break;
      default:
        _streamSubscription?.resume();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    _streamSubscription?.cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shopping App',
        darkTheme: ThemeData.light(),
        theme: ThemeData.dark(),
        themeMode: Provider.of<ThemeProvider>(context).isDarkMode
            ? ThemeMode.light
            : ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: DashboardScreen());
  }
}
