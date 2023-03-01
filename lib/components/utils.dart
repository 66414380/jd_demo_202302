import 'package:flutter/material.dart';
class Utils {
  /// 计算小点
  static Widget buildIndicator ({required List imgs, required int i, double bottom = 10}){
    var length = imgs.length;
    return Positioned(
      bottom: bottom,
      child: Row(
        children: imgs.map((s) {
          // print('--------$i');
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: ClipOval(
              child: Container(
                width: 5,
                height: 5,
                color: s == imgs[i % length]
                    ? const Color(0xfffa2c19)
                    : const Color.fromRGBO(204, 204, 204, 0.6),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}