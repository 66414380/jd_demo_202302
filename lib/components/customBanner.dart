import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jd_demo_202302/components/utils.dart';
import 'package:preload_page_view/preload_page_view.dart';

class CustomBanner extends StatefulWidget {
  final double height;
  final ValueChanged<int>? onTap;

  const CustomBanner({super.key, this.height = 140, this.onTap});

  @override
  CustomBannerState createState() => CustomBannerState();
}

class CustomBannerState extends State<CustomBanner> {
  late PreloadPageController pageController;
  late int curIndex;
  late Timer? timer;
  final List<String> images = [
    'images/banner/banner_1.jpg',
    'images/banner/banner_2.jpg',
    'images/banner/banner_3.jpg',
    'images/banner/banner_4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    timer = null;
    curIndex = images.length * 5;
    pageController = PreloadPageController(initialPage: curIndex);
    initTimer();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none, // 可以超出外面
      children: <Widget>[
        buildPageView(),
        Utils.buildIndicator(imgs: images, i: curIndex, bottom: 10)
      ],
    );
  }

  Widget buildPageView() {
    var length = images.length;
    return SizedBox(
      height: widget.height,
      child: PreloadPageView.builder(
        // preloadPagesCount: length,
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            curIndex = index;
            if (index == 0) {
              curIndex = length;
              changePage();
            }
          });
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onPanDown: (details) {
              cancelTimer();
            },
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('当前 page 为 $index'),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.5),
              alignment: Alignment.center,
              child: Container(
                  // width: 350,
                  child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(images[index % length], fit: BoxFit.contain),
              )),
            ),
          );
        },
      ),
    );
  }

  /// 点击到图片的时候取消定时任务
  cancelTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
      // initTimer();
    }
  }

  /// 初始化定时任务
  initTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 3), (t) {
      curIndex++;
      // 加上判断 否则切换页面时会报 '_positions.isNotEmpty': ScrollController not attached to any scroll views.
      if(pageController.hasClients) {
        pageController.animateToPage(
          curIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    });
  }

  /// 切换页面，并刷新小圆点
  changePage() {
    Timer(const Duration(milliseconds: 350), () {
      pageController.jumpToPage(curIndex);
    });
  }
}
