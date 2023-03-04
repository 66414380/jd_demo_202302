import 'dart:math';

import 'package:flutter/cupertino.dart';

class CustomDivide extends StatefulWidget {
  const CustomDivide({Key? key, this.name = ''}) : super(key: key);
  final String name;

  @override
  State<CustomDivide> createState() => _State();
}

class _State extends State<CustomDivide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: 1,
                color: const Color(0xffcccccc),
              ),
              Positioned(
                  right: -2,
                  child: Transform.rotate(
                      angle: pi / 4,
                      child: Container(
                        width: 4,
                        height: 4,
                        color: const Color(0xffcccccc),
                      )))
            ],
          )),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Text(
              widget.name,
              style: const TextStyle(fontSize: 12, color: Color(0xff999999)),
            ),
          ),
          Expanded(
              child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 1,
                color: const Color(0xffcccccc),
              ),
              Positioned(
                  left: -2,
                  child: Transform.rotate(
                      angle: pi / 4,
                      child: Container(
                        width: 4,
                        height: 4,
                        color: const Color(0xffcccccc),
                      )))
            ],
          )),
        ],
      ),
    );
  }
}
