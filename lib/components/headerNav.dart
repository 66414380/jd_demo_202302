import 'package:flutter/material.dart';

List<Map<String, String>> list = [
  {'icon': 'images/type_index.png', 'name': '首页'},
  {'icon': 'images/type_search.png', 'name': '分类搜索'},
  {'icon': 'images/type_shopcart.png', 'name': '购物车'},
  {'icon': 'images/type_my.png', 'name': '我的京东'},
  {'icon': 'images/type_recently.png', 'name': '浏览记录'}
];


class RightHeader extends StatelessWidget {
  const RightHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 44,
        child: GestureDetector(
          onTap: () {
            HeaderNav.show(context, list);
          },
          child: const Icon(Icons.more_horiz, size: 26),
        ));
  }
}

class HeaderNav {
  static OverlayEntry? overlayEntry;

  static void show(BuildContext context, List<Map<String, String>> list) {
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Positioned.fill(
              child: GestureDetector(
                  onTap: () {
                    close();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ))),
          Positioned(
            right: 10,
            top: 53,
            child: Material(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.9),
                      width: 10,
                      height: 5,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.9),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(list.length, (index) {
                      return GestureDetector(
                          onTap: () {
                            print('------${list[index]}');
                            close();
                          },
                          child: SizedBox(
                            height: 40,
                            width: 125,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    list[index]['icon']!,
                                    scale: 2,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: list.length - 1 != index
                                              ? const BorderSide(
                                                  width: 1,
                                                  color: Color(0xff464646))
                                              : const BorderSide(
                                                  width: 1,
                                                  color: Colors.transparent))),
                                  child: Text(list[index]['name']!,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                )),
                              ],
                            ),
                          ));
                    }),
                  ),
                )
              ],
            )),
          )
        ],
      );
    });
    Overlay.of(context).insert(overlayEntry!);
  }

  static void close() {
    overlayEntry?.remove();
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
