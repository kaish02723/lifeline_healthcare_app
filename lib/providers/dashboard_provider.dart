import 'package:flutter/material.dart';

class DashBoardProvider with ChangeNotifier {
  int _currentPage = 0;
  final PageController offerController = PageController();


  int get currentPage => _currentPage;

  void updatePage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
