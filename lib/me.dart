/**
 * 使用 Container > Stack > Positioned > Image.asset 实现 background-position 效果
 */
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/accountv2.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:jd_demo_202302/components/customDivide.dart';
import 'package:jd_demo_202302/components/customPageRoute.dart';
import 'package:jd_demo_202302/components/goodsItem.dart';
import 'package:jd_demo_202302/components/headerNav.dart';
import 'package:jd_demo_202302/login.dart';
import 'package:jd_demo_202302/model/bottomBarListModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> with AutomaticKeepAliveClientMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String loginName = '';

  @override
  void initState() {
    super.initState();
    _prefs.then((value) {
      setState(() {
        loginName = value.getString('token') ?? '';
      });
    });
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget noLogin = Container(
      margin: const EdgeInsets.only(left: 4),
      child: GestureDetector(
        onTap: () async {
          // context.pushNamed('login');
          final res = await Navigator.of(context).push(EnterExitRoute(exitPage: widget, enterPage: const Login()));
          if(res != null) {
            setState(() {
              loginName = res;
            });
          }
        },
        child: Row(
          children: const [
            Text(
              '注册/登录',
              style: TextStyle(fontSize: 14),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
            )
          ],
        ),
      ),
    );
    Widget hasLogin = Container(
        padding: const EdgeInsets.only(left: 8, top: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                 Text(
                  loginName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xff1a1a1a)),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 4),
                    width: 15,
                    height: 15,
                    child: Stack(
                      // left: 0,
                      children: [
                        Positioned(
                          left: -60,
                          child: Image.asset(
                            'images/me/bi.png',
                            height: 15,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      ],
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 17.6,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 14, left: 6),
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border:
                              Border.all(width: 1, color: const Color(0xfff8cfce)),
                          color: const Color.fromRGBO(255, 255, 255, 0.68)),
                      child: const Text(
                        '京享值',
                        strutStyle: StrutStyle(
                            forceStrutHeight: true, height: 1, leading: 0),
                        style:
                            TextStyle(fontSize: 10, color: Color(0xff1a1a1a)),
                      ),
                    ),
                    Container(
                        height: 17.6,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 14, left: 6),
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                                width: 1, color: const Color(0xfff8cfce)),
                            color: const Color.fromRGBO(255, 255, 255, 0.68)),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: const [
                            Text(
                              '小白守约847分',
                              strutStyle: StrutStyle(
                                  forceStrutHeight: true,
                                  height: 1,
                                  leading: 0),
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xff1a1a1a)),
                            ),
                            Positioned(
                                right: -10,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 8,
                                  color: Color(0xff888888),
                                ))
                          ],
                        ))
                  ],
                ),
                GestureDetector(
                    onTap: () async {
                      final res = await Navigator.of(context).push(EnterExitRoute(exitPage: widget, enterPage: const AccountV2()));
                      if(res != null) {
                        setState(() {
                          loginName = '';
                        });
                      }},
                    child: Image.asset(
                      'images/me/account-icon.png',
                      width: 20,
                      height: 20,
                    ))
              ],
            )
          ],
        ));

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            CustomAppBar(
              height: 44,
              child: Row(
                children: const [
                  SizedBox(
                      width: 44,
                      // child: GestureDetector(
                      //   onTap: () {
                      //     context.pop();
                      //   },
                      //   child: const Icon(
                      //     Icons.arrow_back_ios,
                      //     size: 18,
                      //   ),
                      // )
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '我的',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      ),
                    ),
                  ),
                  RightHeader()
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage('images/me/bg.png'))),
              child: Column(
                children: [
                  // 个人头像
                  Container(
                    padding: const EdgeInsets.only(
                        top: 19, right: 18, bottom: 10, left: 18),
                    height: 85,
                    child: Row(
                      children: [
                        Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(250, 44, 25, .08),
                                      offset: Offset(0, 4),
                                      blurRadius: 8)
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(60)),
                                border: Border.all(
                                    width: 1, color: const Color(0xffffffff))),
                            child: Image.asset('images/me/me.png')),
                        Expanded(
                            child: loginName.isNotEmpty ? hasLogin : noLogin),
                      ],
                    ),
                  ),
                  // 开通plus
                  Stack(
                    // clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 6, right: 10, left: 10),
                        height: 56,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment.center,
                                fit: BoxFit.fill,
                                image: AssetImage('images/me/plus.png'))),
                      ),
                      Positioned(
                          left: 20,
                          child: Image.asset(
                            'images/me/plus_title.png',
                            width: 28,
                            height: 28,
                          )),
                      const Positioned(
                          bottom: 10,
                          left: 50,
                          child: Text(
                            '10倍返京豆',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff996300)),
                          )),
                      Positioned(
                          bottom: 10,
                          left: 170,
                          child: Row(
                            children: [
                              Image.network(
                                'https://m.360buyimg.com/babel/jfs/t1/206672/2/18660/18198/621f679fE3d3e255a/8408567fd4ed3495.png',
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text('营养保健',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff8c5c25),
                                              fontWeight: FontWeight.w700)),
                                      Icon(Icons.arrow_forward_ios,
                                          size: 9, color: Color(0xff945914))
                                    ],
                                  ),
                                  const Text('赠PLUS',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff8c5c25))),
                                  // Text.rich(TextSpan(
                                  //   children: [
                                  //     TextSpan(text: '营养保健', style: TextStyle(fontSize: 12, color: Color(0xff8c5c25), fontWeight: FontWeight.w700)),
                                  //     WidgetSpan(child: Icon(Icons.arrow_forward_ios, size: 9,color: Color(0xff945914)))
                                  //   ]
                                  // ), textAlign: TextAlign.center,)
                                ],
                              )
                            ],
                          )),
                      Positioned(
                          bottom: 10,
                          right: 40,
                          child: Row(
                            children: [
                              Image.network(
                                'https://m.360buyimg.com/babel/jfs/t1/169138/27/34228/3390/63be4d76Fe28345ab/7a3ba2add124b45f.png',
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text('续费惊喜',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff8c5c25),
                                              fontWeight: FontWeight.w700)),
                                      Icon(Icons.arrow_forward_ios,
                                          size: 9, color: Color(0xff945914))
                                    ],
                                  ),
                                  const Text('PLUS福利',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff8c5c25))),
                                  // Text.rich(TextSpan(
                                  //   children: [
                                  //     TextSpan(text: '营养保健', style: TextStyle(fontSize: 12, color: Color(0xff8c5c25), fontWeight: FontWeight.w700)),
                                  //     WidgetSpan(child: Icon(Icons.arrow_forward_ios, size: 9,color: Color(0xff945914)))
                                  //   ]
                                  // ), textAlign: TextAlign.center,)
                                ],
                              )
                            ],
                          )),
                    ],
                  ),

                  Container(
                    height: 34,
                    margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: const BoxDecoration(
                      // color: Color(0xfffbfbfb),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(242, 242, 242, 0.5),
                            Color.fromRGBO(250, 250, 250, 0.6),
                            Colors.white
                          ],
                          begin: FractionalOffset(0.0, 0.5),
                          // Alignment.topCenter
                          end: FractionalOffset(1.0, 0.5)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '商品收藏',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                              strutStyle: StrutStyle(
                                  forceStrutHeight: true,
                                  height: 1,
                                  leading: 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '5',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff1a1a1a),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '商品收藏',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                              strutStyle: StrutStyle(
                                  forceStrutHeight: true,
                                  height: 1,
                                  leading: 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '5',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff1a1a1a),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '商品收藏',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                              strutStyle: StrutStyle(
                                  forceStrutHeight: true,
                                  height: 1,
                                  leading: 0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '5',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff1a1a1a),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    margin:
                        const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                    padding: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              width: 81.8,
                              height: 42,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/me/order1.png',
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const Text(
                              '待付款',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              width: 81.8,
                              height: 42,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/me/order2.png',
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const Text(
                              '待收货',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              width: 81.8,
                              height: 42,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/me/order3.png',
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const Text(
                              '退换/售后',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 5,
                              left: -5,
                              child: Image.asset(
                                'images/me/order.png',
                                width: 10,
                                height: 44,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 81.8,
                                  height: 42,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'images/me/order4.png',
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                const Text(
                                  '全部订单',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff1a1a1a)),
                                )
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),

                  Container(
                    margin:
                        const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    constraints: const BoxConstraints(minHeight: 72),
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              width: 65,
                              height: 30,
                              margin: const EdgeInsets.only(bottom: 6),
                              alignment: Alignment.center,
                              child: const Text('0',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1a1a1a))),
                            ),
                            const Text(
                              '优惠券',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              width: 65,
                              height: 30,
                              margin: const EdgeInsets.only(bottom: 6),
                              alignment: Alignment.center,
                              child: const Text('3万',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1a1a1a))),
                            ),
                            const Text(
                              '白条额度',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              width: 65,
                              height: 30,
                              margin: const EdgeInsets.only(bottom: 6),
                              alignment: Alignment.center,
                              child: const Text('10',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1a1a1a))),
                            ),
                            const Text(
                              '京豆',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              width: 65,
                              height: 30,
                              margin: const EdgeInsets.only(bottom: 6),
                              alignment: Alignment.center,
                              child: const Text('0',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1a1a1a))),
                            ),
                            const Text(
                              '红包',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 5,
                              left: -5,
                              child: Image.asset(
                                'images/me/order.png',
                                width: 10,
                                height: 44,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 65,
                                  height: 30,
                                  margin: const EdgeInsets.only(bottom: 6),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'images/me/my_asset.png',
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                const Text(
                                  '全部资产',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff1a1a1a)),
                                )
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),

                  Container(
                    margin:
                        const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                    padding: const EdgeInsets.only(bottom: 20),
                    constraints: const BoxConstraints(minHeight: 85),
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 12),
                              margin: const EdgeInsets.only(bottom: 6),
                              width: 81.8,
                              height: 42,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/me/tools1.webp',
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const Text(
                              '客户服务',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 12),
                              margin: const EdgeInsets.only(bottom: 6),
                              width: 81.8,
                              height: 42,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/me/tools2.webp',
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const Text(
                              '我的预约',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 12),
                              margin: const EdgeInsets.only(bottom: 6),
                              width: 81.8,
                              height: 42,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/me/tools3.webp',
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const Text(
                              '我的问答',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 12),
                              margin: const EdgeInsets.only(bottom: 6),
                              width: 81.8,
                              height: 42,
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/me/tools4.webp',
                                width: 35,
                                height: 35,
                              ),
                            ),
                            const Text(
                              '闲置换钱',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff1a1a1a)),
                            )
                          ],
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const CustomDivide(
              name: '为您推荐',
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
          ]))
        ],
      ),
    );
  }
}
