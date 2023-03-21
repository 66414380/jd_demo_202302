import 'package:flutter/cupertino.dart';

keyboardUnFocus(context) {
  // 收起键盘
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus &&
      currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}