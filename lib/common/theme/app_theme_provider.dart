import 'package:flutter/material.dart';
import 'package:jom_recycle/common/theme/app_theme.dart';

class AppThemeProvider extends ChangeNotifier {
  //Default set to light theme
  ThemeData _themeData = AppTheme.lightTheme;

  ThemeData get themeData => _themeData;

  bool get isLightTheme => _themeData == AppTheme.lightTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (isLightTheme) {
      themeData = AppTheme.darkTheme;
    } else {
      themeData = AppTheme.lightTheme;
    }
  }
}
