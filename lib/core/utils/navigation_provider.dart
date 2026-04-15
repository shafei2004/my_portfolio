import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void updateIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void scrollToSection(int index) {
    final Map<int, GlobalKey> keys = {
      0: homeKey,
      1: aboutKey,
      2: projectsKey,
      3: contactKey,
    };

    final key = keys[index];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutQuart,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
