import 'package:clothes_app/data/services/pref_service.dart';
import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier {
  final PrefService prefService;
  ThemeProvider(this.prefService) {
    _loadTheme();
  }

  bool _isDarkMode = false;
  static const _key = "isDarkMode";
  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await prefService.setBool(_key, _isDarkMode);
  }

  void _loadTheme() async {
    _isDarkMode = await prefService.getBool(_key);
  }

}
