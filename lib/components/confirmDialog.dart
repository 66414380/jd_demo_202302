import 'package:flutter/material.dart';

class AnimatedConfirmDialog extends StatefulWidget {
  const AnimatedConfirmDialog({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  State<AnimatedConfirmDialog> createState() => _AnimatedConfirmDialogState();
}

class _AnimatedConfirmDialogState extends State<AnimatedConfirmDialog> {
  late double opacity = 0.0;
  final int time = 200;

  @override
  void initState() {
    super.initState();
    // 需要排除等OverlayEntry渲染
    Future.delayed(const Duration(microseconds: 0)).then((value) {
      setState(() {
        opacity = opacity == 1.0 ? 0.0 : 1.0;
      });
    });
  }

  void close() {
    setState(() {
      opacity = opacity == 1.0 ? 0.0 : 1.0;
    });
    Future.delayed(Duration(milliseconds: time)).then((value) {
      setState(() {
        ConfirmDialog.close();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: opacity,
        duration: Duration(milliseconds: time),
        child: Stack(
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
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
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff333333)),
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
                                                color: Color.fromRGBO(
                                                    0, 0, 0, .05),
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
                                      print(widget.id);
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
                                                color: Color.fromRGBO(
                                                    0, 0, 0, .05),
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
        ));
  }
}

class ConfirmDialog {
  static OverlayEntry? overlayEntry;

  static void show(BuildContext context, String item) {
    overlayEntry = OverlayEntry(builder: (context) {
      return AnimatedConfirmDialog(id: item);
    });
    Overlay.of(context).insert(overlayEntry!);
  }

  static void showProductPop(context, widget) {
    overlayEntry = OverlayEntry(builder: (context) {
      return widget;
    });
    Overlay.of(context).insert(overlayEntry!);
  }

  static void close() {
    overlayEntry?.remove();
    overlayEntry = null;
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

class SynthesizeWidget extends StatefulWidget {
  const SynthesizeWidget(
      {Key? key,
        this.h = 0,
        required this.id,
        required this.callback,
        required this.layerLink})
      : super(key: key);
  final double h;
  final int id;
  final LayerLink layerLink;
  final Function callback;

  @override
  State<SynthesizeWidget> createState() => _SynthesizeWidgetState();
}

class _SynthesizeWidgetState extends State<SynthesizeWidget> {
  List<Map<String, dynamic>> list0 = [
    {'id': 0, 'name': '综合'},
    {'id': 1, 'name': '最新上架'},
    {'id': 2, 'name': '价格最低'},
    {'id': 3, 'name': '价格最高'},
    {'id': 4, 'name': '评价最多'},
  ];
  late int _selectedId = 0;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.id; // 原始数值，需要赋值
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      offset: Offset(0, widget.h),
      link: widget.layerLink,
      child: GestureDetector(
        onTap: () {
          widget.callback(false);
          ConfirmDialog.close();
        },
        child: Container(
            alignment: Alignment.topCenter,
            color: const Color.fromRGBO(0, 0, 0, .3),
            child: Column(
              children: List.generate(
                  list0.length,
                      (i) => Material(
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedId = list0[i]['id'];
                              widget.callback(list0[i]['id']);
                            });
                          },
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    top: BorderSide(
                                        width: 1, color: Color(0xfff7f7f7)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                      list0[i]['name'],
                                      style: TextStyle(
                                        // decoration: TextDecoration.none,
                                          fontSize: 14,
                                          color: list0[i]['id'] == _selectedId
                                              ? const Color(0xffe4393c)
                                              : const Color(0xff333333)),
                                    )),
                                list0[i]['id'] == _selectedId
                                    ? Image.asset(
                                  'images/productsList/selected.png',
                                  // width: 13,
                                  height: 12,
                                )
                                    : Container()
                              ],
                            ),
                          )))),
            )),
      ),
    );
  }
}

class InStockWidget extends StatefulWidget {
  const InStockWidget({
    Key? key,
    this.h = 0,
    required this.list,
    required this.callback,
    required this.layerLink,
  }) : super(key: key);
  final double h;
  final List list;
  final LayerLink layerLink;
  final Function callback;

  @override
  State<InStockWidget> createState() => _InStockWidgetState();
}

class _InStockWidgetState extends State<InStockWidget> {
  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      offset: Offset(0, widget.h),
      link: widget.layerLink,
      child: GestureDetector(
        onTap: () {
          widget.callback(false);
          ConfirmDialog.close();
        },
        child: Container(
            alignment: Alignment.topCenter,
            color: const Color.fromRGBO(0, 0, 0, .3),
            child: Column(children: [
              for (var item in widget.list)
                Material(
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            item['selected'] = !item['selected'];
                          });
                        },
                        child: Container(
                          height: 45,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  top: BorderSide(
                                      width: 1, color: Color(0xfff7f7f7)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                  value: item['selected'],
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.red),
                                  side: const BorderSide(
                                      color: Color(0xff8c8c8c), width: 1.5),
                                  shape: const CircleBorder(),
                                  onChanged: (bool? v) {
                                    setState(() {
                                      item['selected'] = !item['selected'];
                                    });
                                  }),
                              Expanded(
                                  child: Text(
                                    item['name'],
                                    style: TextStyle(
                                      // decoration: TextDecoration.none,
                                        fontSize: 14,
                                        color: item['selected']
                                            ? const Color(0xffe4393c)
                                            : const Color(0xff333333)),
                                  )),
                            ],
                          ),
                        ))),
              Container(
                height: 45,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xfff1f1f1),
                          offset: Offset(0, -1),
                          blurRadius: 3)
                    ]),
                child: Row(
                  children: [
                    Expanded(
                        child: Material(
                            child: GestureDetector(
                                onTap: () {
                                  for (var element in widget.list) {
                                    element['selected'] = false;
                                  }
                                  setState(() {

                                  });
                                },
                                child: Container(
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: const Text(
                                      '重置',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffe4393c)),
                                    ))))),
                    Expanded(
                        child: Material(
                            child: GestureDetector(
                                onTap: () {
                                  print(widget.list);
                                  ConfirmDialog.close();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    color: const Color(0xffe4393c),
                                    child: const Text(
                                      '确认',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white),
                                    ))))),
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
