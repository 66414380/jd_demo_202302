import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/components/cartItem.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:jd_demo_202302/components/goodsItem.dart';
import 'package:jd_demo_202302/components/headerNav.dart';
import 'package:jd_demo_202302/model/cartModel.dart';
import 'package:provider/provider.dart';

int i = 4;
List<int> list = List.filled(i, 1);

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  late double allPrice = 0.00, opacity = .3;
  late int total = 0;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();

    void setPrice() {

      cart.setAllChecked();
      cart.setIsChecked(cart.allChecked);
      if (cart.allChecked) {
        allPrice = 52.90;
        opacity = 1;
        total = 1;
      } else {
        allPrice = 0.00;
        opacity = .3;
        total = 0;
      }
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            CustomAppBar(
              height: 44,
              child: Row(
                children: [
                  SizedBox(
                      width: 44,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        ),
                      )),
                  const Expanded(
                    child: Center(
                      child: Text(
                        '购物车',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      ),
                    ),
                  ),
                  const RightHeader()
                ],
              ),
            ),
            CartItem(
              callback: (v) {
                setState(() {
                  setPrice();
                });
              },
            ),
            Container(
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
                  Expanded(
                      child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: const Text(
                      '可能你还想要',
                      style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                    ),
                  )),
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
      bottomNavigationBar: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                    visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    value: cart.allChecked,
                    checkColor: Colors.white,
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Colors.red),
                    side:
                        const BorderSide(color: Color(0xff8c8c8c), width: 1.5),
                    shape: const CircleBorder(),
                    onChanged: (bool? v) {
                      setState(() {
                        setPrice();
                      });
                    }),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        setPrice();
                      });
                    },
                    child: const Text('全选',
                        style:
                            TextStyle(color: Color(0xff262626), fontSize: 12),
                        strutStyle: StrutStyle(height: 1, leading: .1)))
              ],
            ),
            Row(
              children: [
                const Text('总计:',
                    style: TextStyle(color: Color(0xff262626), fontSize: 15),
                    strutStyle: StrutStyle(height: 1, leading: .5)),
                const Text(
                  '¥',
                  style: TextStyle(color: Color(0xff000000), fontSize: 16),
                ),
                Text(
                  allPrice.toString(),
                  style:
                      const TextStyle(color: Color(0xff000000), fontSize: 16),
                ),
                Opacity(
                    opacity: opacity,
                    child: Container(
                      width: 113,
                      height: 38,
                      margin: const EdgeInsets.only(left: 12),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xfff2140c),
                              Color(0xfff2270c),
                              Color(0xfff24d0c)
                            ],
                            stops: [
                              0,
                              0.7,
                              1
                            ],
                            begin: FractionalOffset(0.5, 0.5),
                            // Alignment.topCenter
                            end: FractionalOffset(1.0, 1.0)),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text.rich(
                          TextSpan(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                              children: [
                                const TextSpan(text: '去结算('),
                                TextSpan(text: total.toString()),
                                const TextSpan(text: ')件'),
                              ]),
                          strutStyle: const StrutStyle(height: 1, leading: .5)),
                    ))
              ],
            )
          ],
        ),
      ),
    );


  }


}
