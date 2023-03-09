import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/components/confirmDialog.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:jd_demo_202302/components/headerNav.dart';
import 'package:jd_demo_202302/components/productItem.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  GlobalKey globalKey1 = GlobalKey();
  final LayerLink layerLink1 = LayerLink(), layerLink2 = LayerLink();
  // 用late会报316行 _overlayEntry?.remove();_overlayEntry未初始化，所以这里可以用static修释，或者不加static，都会有一个null默认值
  OverlayEntry? _overlayEntry;
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
    {'id': 0, 'name': '京东物流', 'image': '', 'layerLink': LayerLink()},
    {'id': 1, 'name': '新品', 'image': '', 'layerLink': LayerLink()},
    {
      'id': 2,
      'name': '品牌',
      'image': 'images/productsList/icon_tri_1.png',
      'layerLink': LayerLink()
    },
    {
      'id': 3,
      'name': '运行内存',
      'image': 'images/productsList/icon_tri_1.png',
      'layerLink': LayerLink()
    },
    {
      'id': 4,
      'name': '机身内存',
      'image': 'images/productsList/icon_tri_1.png',
      'layerLink': LayerLink()
    },
    {
      'id': 5,
      'name': '屏幕尺寸',
      'image': 'images/productsList/icon_tri_1.png',
      'layerLink': LayerLink()
    },
    {
      'id': 6,
      'name': 'CPU型号',
      'image': 'images/productsList/icon_tri_1.png',
      'layerLink': LayerLink()
    },
    {
      'id': 7,
      'name': '电池容量',
      'image': 'images/productsList/icon_tri_1.png',
      'layerLink': LayerLink()
    },
  ];
  late int selectedId2 = -1;

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
              CompositedTransformTarget(
                link: layerLink2,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < list2.length; i++)
                          GestureDetector(
                              onTap: () {
                                if (list2[i]['image'] == '') return;
                                if (selectedId2 == list2[i]['id']) {
                                  selectedId2 = -1;
                                } else {
                                  selectedId2 = list2[i]['id'];
                                  ConfirmDialog.close();
                                  _overlayEntry?.remove();
                                  _overlayEntry = null;
                                }
                                if (ConfirmDialog.overlayEntry == null) {
                                  ConfirmDialog.showProductPop(
                                      context,
                                      UnconstrainedBox(
                                          child: CompositedTransformFollower(
                                              link: layerLink2,
                                              offset: const Offset(0, 50),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: MediaQuery.of(context).size.height,
                                                      color: const Color.fromRGBO(0, 0, 0, .3),
                                                    ),
                                                  Material(
                                                      child: Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 300),
                                                        decoration: const BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border(
                                                                top: BorderSide(
                                                                    width: 1,
                                                                    color: Color(
                                                                        0xffe5e5e5)))),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Expanded(child: Text(list2[i]['name'],
                                                            )),

                                                            // Text(list2[i]['name']),
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
                                                                                // for (var element in widget.list) {
                                                                                //   element['selected'] = false;
                                                                                // }
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
                                                                                selectedId2 = -1;
                                                                                ConfirmDialog.close();
                                                                                _overlayEntry?.remove();
                                                                                _overlayEntry = null;
                                                                                setState(() {});
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

                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              )



                                          )));
                                } else {
                                  ConfirmDialog.close();
                                }
                                if (_overlayEntry == null) {
                                  _overlayEntry =
                                      OverlayEntry(builder: (context) {
                                    return UnconstrainedBox(
                                        child: CompositedTransformFollower(
                                            link: list2[i]['layerLink'],
                                            offset: const Offset(1, 39),
                                            child: Container(
                                              width: 78,
                                              height: 3,
                                              color: Colors.white,
                                            )));
                                  });
                                  Overlay.of(context).insert(_overlayEntry!);
                                } else {
                                  _overlayEntry?.remove();
                                  _overlayEntry = null;
                                }

                                setState(() {});
                              },
                              child: CompositedTransformTarget(
                                  link: list2[i]['layerLink'],
                                  child: Container(
                                      width: 80,
                                      height: selectedId2 == list2[i]['id']
                                          ? 41
                                          : 30,
                                      margin: EdgeInsets.only(
                                          right: i != list2.length - 1 ? 6 : 0),
                                      decoration: BoxDecoration(
                                          color: selectedId2 == list2[i]['id']
                                              ? Colors.white
                                              : const Color(0xfff2f2f7),
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  selectedId2 == list2[i]['id']
                                                      ? const Color(0xffe5e5e5)
                                                      : Colors.transparent)),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Positioned(
                                            top: 5,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  list2[i]['name'],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xff666666)),
                                                ),
                                                list2[i]['image'] != ''
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 4),
                                                        child: RotatedBox(
                                                            quarterTurns:
                                                                selectedId2 ==
                                                                        list2[i]
                                                                            [
                                                                            'id']
                                                                    ? 90
                                                                    : 0,
                                                            child: Image.asset(
                                                                list2[i]
                                                                    ['image'],
                                                                width: 8,
                                                                height: 5)))
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))))
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),

      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
        return const ProductItem();
      }),
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
    selectedId2 = -1;
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {});
  }
}
