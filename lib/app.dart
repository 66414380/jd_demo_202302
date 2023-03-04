import 'package:flutter/material.dart';
import 'package:jd_demo_202302/cart.dart';
import 'package:jd_demo_202302/cateGoryPage.dart';
import 'package:jd_demo_202302/me.dart';
import 'package:jd_demo_202302/model/bottomBarListModel.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late PageController pageController;
  late int bottomBarId = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: bottomBarId);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bottomBarList = context.watch<BottomBarList>().list;
    // print('+++++++++$bottomBarList');
    final List<Widget> listBottomApp = List.generate(
        4,
        (i) => Expanded(
                child: GestureDetector(
              onTap: () {
                clickBottom(i);
              },
              child: Image.asset(
                (i == bottomBarId)
                    ? bottomBarList[i]['selected']
                    : bottomBarList[i]['noSelected'],
                width: 60,
                height: 46,
              ),
            )));

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [Home(), CateGoryPage(), Cart(), Me()],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xfff6f6f6), boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(154, 141, 141, .6),
              offset: Offset(0, 0),
              blurRadius: 10)
        ]),
        child: Row(
          children: listBottomApp,
        ),
      ),
    );
  }

  void clickBottom(int i) {
    // animateToPage 切换页面时图标会有跳闪
    // pageController.animateToPage(
    //     i, duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeInOut);
    pageController.jumpToPage(i);
  }

  void onPageChanged(int value) {
    setState(() {
      bottomBarId = value;
    });
  }
}
