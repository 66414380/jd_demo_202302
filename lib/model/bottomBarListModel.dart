import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBarList extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late List<Map<String, dynamic>> list = [
    {
      'id': 0,
      'selected': 'images/app/home_selected.png',
      'noSelected': 'images/app/home_no_selected.png'
    },
    {
      'id': 1,
      'selected': 'images/app/classification_selected.png',
      'noSelected': 'images/app/classification_no_selected.png'
    },
    {
      'id': 2,
      'selected': 'images/app/buy_selected.png',
      'noSelected': 'images/app/buy_no_selected.png'
    },
    {
      'id': 3,
      'selected': 'images/app/login_selected.png',
      'noSelected': 'images/app/login_no_selected.png'
    }
  ];

  BottomBarList() {
    _prefs.then((value) {
      var loginName = value.getString('token') ?? '';
      if (loginName.isNotEmpty) {
        setHasLoginBottomBarList();
      } else {
        setNoLoginBottomBarList();
      }
    });
  }
  void setHasLoginBottomBarList() {
    list[3]['noSelected'] = 'images/app/me_no_selected.png';
    notifyListeners(); // 通知 context.watch
  }

  void setNoLoginBottomBarList() {
    list[3]['noSelected'] = 'images/app/login_no_selected.png';
    notifyListeners();
  }
}
