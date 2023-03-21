import 'package:flutter/material.dart';
import 'package:jd_demo_202302/cart.dart';
import 'package:jd_demo_202302/cateGoryPage.dart';
import 'package:jd_demo_202302/components/customToast.dart';
import 'package:jd_demo_202302/me.dart';
import 'package:jd_demo_202302/model/bottomBarListModel.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  static PageController? pageController =
      PageController(initialPage: bottomBarId);
  static int bottomBarId = 0;

  static clickBottom(int i) {
    App.pageController?.jumpToPage(i);
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // late PageController pageController;
  // late int bottomBarId = 0;
  @override
  void initState() {
    super.initState();
    // App.pageController = PageController(initialPage: App.bottomBarId);
  }

  @override
  void dispose() {
    super.dispose();
    App.pageController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bottomBarList = context.watch<BottomBarList>().list;
    DateTime? lastPressedAt;
    // print('+++++++++$bottomBarList');
    final List<Widget> listBottomApp = List.generate(
        4,
        (i) => Expanded(
                child: GestureDetector(
              onTap: () {
                clickBottom(i);
              },
              child: Image.asset(
                (i == App.bottomBarId)
                    ? bottomBarList[i]['selected']
                    : bottomBarList[i]['noSelected'],
                width: 60,
                height: 46,
              ),
            )));

    return WillPopScope(
        child: Scaffold(
          body: PageView(
            controller: App.pageController,
            onPageChanged: onPageChanged,
            children: const [Home(), CateGoryPage(), Cart(), Me()],
          ),
          bottomNavigationBar: Container(
            height: 50,
            width: double.infinity,
            decoration:
                const BoxDecoration(color: Color(0xfff6f6f6), boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(154, 141, 141, .6),
                  offset: Offset(0, 0),
                  blurRadius: 10)
            ]),
            child: Row(
              children: listBottomApp,
            ),
          ),
        ),
        onWillPop: () async {
          if (lastPressedAt == null ||
              (DateTime.now().difference(lastPressedAt!) >
                  const Duration(seconds: 2))) {
            //两次点击间隔超过2秒，重新计时
            lastPressedAt = DateTime.now();
            // Fluttertoast.showToast(msg: "再次返回退出", gravity: ToastGravity.BOTTOM);
            CustomToast().showToast('再次返回退出');
            return false;
          }
          return true;
        });
  }

  void clickBottom(int i) {
    // animateToPage 切换页面时图标会有跳闪
    // pageController.animateToPage(
    //     i, duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeInOut);
    App.pageController?.jumpToPage(i);
  }

  void onPageChanged(int value) {
    setState(() {
      App.bottomBarId = value;
    });
  }
}
