import 'package:flutter/material.dart';

class ConfirmDialog {
  static OverlayEntry? overlayEntry;

  static void show(BuildContext context, item) {
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Positioned.fill(
              child: GestureDetector(
                  onTap: () {
                    // close();
                  },
                  child: Container(
                    color: Colors.black54,
                  ))),
          Positioned(
              left: (MediaQuery.of(context).size.width - 270) / 2,
              top: MediaQuery.of(context).size.height * 30 / 100,
              child: Container(
                  width: 270,
                  height: 174,
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, .3),
                            offset: Offset(0, 1),
                            blurRadius: 10)
                      ]),
                  child: Material(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 5, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              border: Border.all(
                                  width: 2, color: const Color(0xffE93B3D))),
                          child: const Text(
                            '!',
                            style: TextStyle(
                                fontSize: 30, color: Color(0xffE93B3D)),
                          ),
                        ),
                        const Text(
                          '确认要删除此商品？',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff333333)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    close();
                                  },
                                  child: Container(
                                    width: 115,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xffcccccc)),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: const [
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, .05),
                                              offset: Offset(0, 3),
                                              blurRadius: 6)
                                        ]),
                                    child: const Text(
                                      '取消',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff333333)),
                                    ),
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    print(item);
                                    close();
                                  },
                                  child: Container(
                                    width: 115,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff2270c),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, .05),
                                              offset: Offset(0, 3),
                                              blurRadius: 10,
                                              spreadRadius: 11)
                                        ]),
                                    child: const Text(
                                      '删除',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      );
    });
    Overlay.of(context).insert(overlayEntry!);
  }

  static void close() {
    overlayEntry?.remove();
  }

  static void showLoading(BuildContext context) {
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(children: [
        Positioned.fill(
          child: Container(
            color: Colors.transparent,
          ),
        ),
        const Center(
            child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.amber,
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                )))
      ]);
    });
    Overlay.of(context).insert(overlayEntry!);
  }
}
