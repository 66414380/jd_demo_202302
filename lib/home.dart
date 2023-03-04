import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:jd_demo_202302/components/customBanner.dart';
import 'package:jd_demo_202302/components/customRefreshFooter.dart';
import 'package:jd_demo_202302/components/goodsItem.dart';
import 'package:jd_demo_202302/components/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late EasyRefreshController easyRefreshController;
  late PageController pageController;
  final List<List<Map<String, dynamic>>> cateList = [
    [
      {'name': '超市', 'img': 'images/banner2/img1.png'},
      {'name': '数码电器', 'img': 'images/banner2/img2.png'},
      {'name': '新百货', 'img': 'images/banner2/img3.png'},
      {'name': '生鲜', 'img': 'images/banner2/img4.png'},
      {'name': '到家', 'img': 'images/banner2/img5.png'},
      {'name': '充值缴费', 'img': 'images/banner2/img6.png'},
      {'name': '附近好店', 'img': 'images/banner2/img7.png'},
      {'name': '领券', 'img': 'images/banner2/img8.png'},
      {'name': 'PLUS会员', 'img': 'images/banner2/img9.png'},
      {'name': '国际', 'img': 'images/banner2/img10.png'},
    ],
    [
      {'name': '拍卖', 'img': 'images/banner2/img11.png'},
      {'name': '玩3C', 'img': 'images/banner2/img12.png'},
      {'name': '沃尔玛', 'img': 'images/banner2/img13.png'},
      {'name': '美妆馆', 'img': 'images/banner2/img14.png'},
      {'name': '旅行', 'img': 'images/banner2/img15.png'},
      {'name': '拍拍二手', 'img': 'images/banner2/img16.png'},
      {'name': '全部', 'img': 'images/banner2/img17.png'}
    ]
  ];
  late int cateId = 0;
  final List<Map<String, dynamic>> msData = [
    {'img': 'images/banner3/img1.jpg', 'price': '2599'},
    {'img': 'images/banner3/img2.jpg', 'price': '119.9'},
    {'img': 'images/banner3/img3.jpg', 'price': '32.9'},
    {'img': 'images/banner3/img4.jpg', 'price': '50'},
    {'img': 'images/banner3/img5.jpg', 'price': '3449'},
    {'img': 'images/banner3/img6.jpg', 'price': '3379'},
    {'img': 'images/banner3/img7.jpg', 'price': '25.9'},
    {'img': 'images/banner3/img8.jpg', 'price': '9.9'},
    {'img': 'images/banner3/img9.jpg', 'price': '799'},
    {'img': 'images/banner3/img10.jpg', 'price': '9.8'},
    {'img': 'images/banner3/img11.jpg', 'price': '546'},
    {'img': 'images/banner3/img12.jpg', 'price': '9.5'},
    {'img': 'images/banner3/img13.jpg', 'price': '9.9'},
    {'img': 'images/banner3/img14.jpg', 'price': '298'},
    {'img': 'images/banner3/img15.jpg', 'price': '228'},
    {'img': 'images/banner3/img16.jpg', 'price': '496'},
    {'img': 'images/banner3/img17.jpg', 'price': '1609'},
  ];

  int listIndex = 4;

  @override
  void initState() {
    super.initState();
    easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    pageController = PageController();
  }

  @override
  void dispose() {
    easyRefreshController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> list = List.filled(listIndex, 1);
    return Scaffold(
        appBar: CustomAppBar(
          height: 44,
          backgroundColor: const Color(0xffC82519),
          child: Row(
            children: [
              SizedBox(
                  width: 40,
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'images/home/cate.png',
                      width: 20,
                      height: 18,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/home/jd.png',
                          width: 20,
                          height: 15,
                        ),
                        Container(
                          height: 16,
                          margin: const EdgeInsets.only(left: 6, right: 6),
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      width: 1, color: Color(0xffdddddd)))),
                        ),
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
                                  child: const Text('小米空气净化器',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff232326),
                                          textBaseline:
                                              TextBaseline.alphabetic)),
                                )))
                      ],
                    ),
                  )),
              SizedBox(
                  width: 40,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      '登录',
                      style: TextStyle(fontSize: 14, color: Color(0xffffffff)),
                    ),
                  )),
            ],
          ),
        ),
        body: EasyRefresh(
          footer: CustomRefreshFooter(
              iconTheme: const IconThemeData(color: Colors.red),
              processingText: ''),
          controller: easyRefreshController,
          onLoad: () async {
            await Future.delayed(const Duration(seconds: 1));
            if (!mounted) {
              return;
            }
            setState(() {
              listIndex += 5;
            });
            easyRefreshController.finishLoad(listIndex >= 10
                ? IndicatorResult.noMore
                : IndicatorResult.success);
          },
          child: ListView(
            children: [
              Stack(
                children: [
                  ClipPath(
                      clipper: BottomWaveClipper(),
                      child: Container(
                        height: 101,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xffc82519), Color(0xfff1503b)],
                                stops: [0.4, 1],
                                begin: FractionalOffset(0.5, 0),
                                // Alignment.topCenter
                                end: Alignment(
                                    0, 1) // FractionalOffset(0.5, 1.0)
                                )),
                      )),
                  const CustomBanner(height: 140)
                ],
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                      height: 162,
                      width: double.infinity,
                      constraints: const BoxConstraints(maxHeight: 162),
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (int i) {
                          setState(() {
                            cateId = i;
                          });
                        },
                        children: [
                          getCateList(0),
                          getCateList(1),
                        ],
                      )),
                  Utils.buildIndicator(imgs: cateList, i: cateId, bottom: 0),
                ],
              ),
              // 京东秒杀
              Container(
                margin: const EdgeInsets.all(10),
                height: 130,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xfff2f2f2),
                          offset: Offset(1, 1),
                          blurRadius: 1)
                    ]),
                child: Column(
                  children: [
                    Container(
                      height: 34,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.contain,
                              image: AssetImage('images/home/dot.png'))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 10, right: 5),
                                child: const Text(
                                  '秒杀',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(51, 51, 51, 1)),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: const Text(
                                  '14',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(255, 39, 39, 1)),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    'images/home/seckill-time.png',
                                    width: 20.5,
                                    height: 17.5,
                                  )),
                              showClock('00'),
                              Container(
                                width: 6,
                                alignment: Alignment.center,
                                child: const Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xfffa2c19),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              showClock('00'),
                              Container(
                                width: 6,
                                alignment: Alignment.center,
                                child: const Text(
                                  ':',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xfffa2c19),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              showClock('00'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('爆款轮番秒',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xfff23030))),
                              SizedBox(
                                  width: 22,
                                  child: Image.asset(
                                    'images/home/arrow_rt.png',
                                    width: 11,
                                    height: 11,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var item in msData)
                            SizedBox(
                                width: 57,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: Image.asset(
                                        item['img'],
                                        width: 55.16,
                                        height: 55.16,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '¥',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xfff2270c)),
                                        ),
                                        Text(
                                          item['price'],
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0xfff2270c)),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          Container(
                              width: 20,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 11),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              color: const Color(0xfff5f5f5),
                              child: Column(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        color: Color(0xffC51C2A)),
                                    child: const Icon(
                                      Icons.arrow_back_outlined,
                                      color: Colors.white,
                                      size: 11,
                                    ),
                                  ),
                                  const Text(
                                    '查看全部',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff666666)),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // 列表
              Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [for (var item in list) const GoodsItem()],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            for (var item in list)
                              const GoodsItem(
                                height: 350,
                              )
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget getCateList(int i) {
    return GridView.count(
        crossAxisCount: 5,
        children: cateList[i]
            .map((e) => Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Image.asset(
                        e["img"],
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(e['name'],
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xff666666))),
                    )
                  ],
                ))
            .toList());
  }

  Widget showClock(String name) {
    return Container(
      width: 15,
      height: 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xffc82519), Color(0xfff1503b)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
          color: const Color(0xfffa2c19),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        name,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0); // 可以注释掉
    path.lineTo(0, size.height - 20);

    var firstControlPoint = Offset(size.width / 2, size.height + 15);
    var firstEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
