import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  bool isDark = false;

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
