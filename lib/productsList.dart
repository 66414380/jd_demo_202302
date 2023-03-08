import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/components/confirmDialog.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:jd_demo_202302/components/headerNav.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  GlobalKey globalKey1 = GlobalKey();
  final LayerLink layerLink1 = LayerLink();
  late double top0H = 0;
  late int quarterTurns0 = 0, quarterTurns1 = 0;
  late int selectedId = 0;
  List<Map<String, dynamic>> list1 = [
    {'id': 0, 'name': '211限时达', 'selected': true},
    {'id': 1, 'name': '有货优先', 'selected': false},
    {'id': 2, 'name': '货到付款', 'selected': false},
    {'id': 3, 'name': '国际', 'selected': false},
    {'id': 4, 'name': '促销', 'selected': false},
  ];
  List<Map<String, dynamic>> list2 = [
    {'id': 0, 'name': '京东物流', 'image': ''},
    {'id': 1, 'name': '新品', 'image': ''},
    {'id': 2, 'name': '品牌', 'image': 'images/productsList/icon_tri_1.png'},
    {'id': 3, 'name': '运行内存', 'image': 'images/productsList/icon_tri_1.png'},
    {'id': 4, 'name': '机身内存', 'image': 'images/productsList/icon_tri_1.png'},
    {'id': 5, 'name': '屏幕尺寸', 'image': 'images/productsList/icon_tri_1.png'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      top0H = globalKey1.currentContext?.size?.height ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: 139,
          backgroundColor: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 44,
                child: Row(
                  children: [
                    SizedBox(
                        width: 40,
                        child: GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: Color(0xff5D5F6A),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          width: 273,
                          height: 30,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: const BoxDecoration(
                              color: Color(0xfff7f7f7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                size: 18,
                                color: Color(0xffdddddd),
                              ),
                              Flexible(
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: const Text("'手机'分类",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff757575),
                                                textBaseline:
                                                    TextBaseline.alphabetic)),
                                      )))
                            ],
                          ),
                        )),
                    const RightHeader()
                  ],
                ),
              ),
              CompositedTransformTarget(
                link: layerLink1,
                child: Container(
                  key: globalKey1,
                  height: 45,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xfff7f7f7)))),
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setSelected('综合');
                          if (ConfirmDialog.overlayEntry == null) {
                            ConfirmDialog.showProductPop(
                                context,
                                SynthesizeWidget(
                                  h: top0H,
                                  id: selectedId,
                                  layerLink: layerLink1,
                                  callback: (v) {
                                    if (v is bool) {
                                      quarterTurns0 = 0;
                                    } else {
                                      selectedId = v;
                                    }
                                  },
                                ));

                            quarterTurns0 = 90;
                          } else {
                            ConfirmDialog.close();
                            quarterTurns0 = 0;
                          }
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '综合',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffff4142)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            RotatedBox(
                                quarterTurns: quarterTurns0,
                                child: Image.asset(
                                  'images/productsList/icon_tri_0.png',
                                  width: 8,
                                  height: 5,
                                ))
                          ],
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '销量',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff333333)),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setSelected('有货优先');
                          if (ConfirmDialog.overlayEntry == null) {
                            ConfirmDialog.showProductPop(
                                context,
                                InStockWidget(
                                  h: top0H,
                                  list: list1, // 直接值引用
                                  layerLink: layerLink1,
                                  callback: (v) {
                                    if (v is bool) {
                                      quarterTurns1 = 0;
                                    } else {
                                      selectedId = v;
                                    }
                                  },
                                ));
                            quarterTurns1 = 90;
                          } else {
                            ConfirmDialog.close();
                            quarterTurns1 = 0;
                          }
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '有货优先',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffff4142)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            RotatedBox(
                                quarterTurns: quarterTurns1,
                                child: Image.asset(
                                  'images/productsList/icon_tri_0.png',
                                  width: 8,
                                  height: 5,
                                ))
                          ],
                        ),
                      )),
                      Builder(builder: (BuildContext context) {
                        return GestureDetector(
                            onTap: () {
                              setSelected('筛选');
                              //打开侧栏 需要Builder(builder: (BuildContext context)
                              Scaffold.of(context).openEndDrawer();
                            },
                            child: SizedBox(
                              width: 78,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '筛选',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xff333333)),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Image.asset(
                                    'images/productsList/filter.png',
                                    width: 13,
                                    height: 13,
                                  )
                                ],
                              ),
                            ));
                      })
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < list2.length; i++)
                        GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 80,
                              height: 30,
                              margin: EdgeInsets.only(
                                  right: i != list2.length - 1 ? 6 : 0),
                              decoration:
                                  const BoxDecoration(color: Color(0xfff2f2f7)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    list2[i]['name'],
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0xff666666)),
                                  ),
                                  list2[i]['image'] != ''
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(left: 4),
                                          child: Image.asset(list2[i]['image'],
                                              width: 8, height: 5))
                                      : Container()
                                ],
                              ),
                            ))
                    ],
                  ),
                ),
              )
            ],
          )),
      endDrawer: Drawer(
          width: 319,
          // backgroundColor: Colors.amber,
          //   shadowColor: Colors.lightBlue,
          //   surfaceTintColor: Colors.lightBlue,
          child: Column(
            children: [
              const Expanded(child: Text('侧栏')),
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
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: const Text(
                                      '取消',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffe4393c)),
                                    ))))),
                    Expanded(
                        child: Material(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    color: const Color(0xffe4393c),
                                    child: const Text(
                                      '确认',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ))))),
                  ],
                ),
              )
            ],
          )),
    );
  }

  void setSelected(String s) {
    if (s == '综合') {
      quarterTurns1 = 0;
      if (quarterTurns0 == 0) {
        ConfirmDialog.close();
      }
    } else if (s == '有货优先') {
      quarterTurns0 = 0;
      if (quarterTurns1 == 0) {
        ConfirmDialog.close();
      }
    } else if (s == '筛选') {
      quarterTurns0 = 0;
      quarterTurns1 = 0;
      ConfirmDialog.close();
    }
    setState(() {});
  }
}
