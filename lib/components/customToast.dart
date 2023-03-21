import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_demo_202302/main.dart';

/*
MaterialApp.router(
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              navigatorKey: navigatorKey, // 使用fToast需要设置navigatorKey FToastBuilder()
              builder: FToastBuilder(),
              home: child,
            );
          },
          title: 'Jd Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerConfig: router(),
        )
需要先在根页面初始化  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); 或者 CustomToast(context);
再在需要的地方调用 CustomToast().showToast('再次返回退出');
 */
class CustomToast {
  static CustomToast? instance;
  factory CustomToast() => instance ??= CustomToast.init();
  FToast fToast = FToast();

  CustomToast.init() {
    // context不能为null，否则将会卡住代码（不会报错!），不能调用CustomToast().showToast('123')
    // print('111111${navigatorKey.currentContext}');
    fToast.init(navigatorKey.currentContext!);
  }

  showToast(name) {
    fToast.showToast(
      child: toastWidget(name),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
    );
  }

  closeToast() {
    fToast.removeCustomToast();
  }

  Widget toastWidget(name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black87,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
