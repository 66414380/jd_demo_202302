/*
使用 WidgetSpan 进行缩进
 */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_demo_202302/components/confirmDialog.dart';
import 'package:jd_demo_202302/components/customDialog.dart';
import 'package:jd_demo_202302/model/cartModel.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, this.callback}) : super(key: key);
  final Function? callback;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  TextEditingController textEditingController =
      TextEditingController(text: '1');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          // 第一行
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 50,
                    height: 10,
                    child: Transform.scale(
                      scale: 1,
                      child: Checkbox(
                          value: cart.isChecked,
                          checkColor: Colors.white,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.red),
                          side: const BorderSide(
                              color: Color(0xff8c8c8c), width: 1.5),
                          shape: const CircleBorder(),
                          onChanged: (bool? v) {
                            setState(() {
                              cart.setIsChecked(v!);
                              widget.callback is Function ? widget.callback!(v): null;
                            });
                          }),
                    )),
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  child: Image.network(
                    'https://jstatic.3.cn/static/icon_pop_jd@2x.1874077a.png',
                    width: 14,
                    height: 14,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 6, bottom: 6),
                    child: const Text(
                      '满2件总价9折',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w700),
                      strutStyle: StrutStyle(height: 1, leading: .1),
                    )),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xff333333),
                  size: 12,
                )
              ],
            ),
          ),

          // 第二行
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.only(right: 18),
            child: Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  color: Colors.red),
                              child: const Text(
                                '跨自营/店铺满折',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                strutStyle: StrutStyle(height: 1, leading: .1),
                              )),
                          const Text(
                            '满2件总价9折',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w700),
                            strutStyle: StrutStyle(height: 1, leading: .1),
                          )
                        ],
                      ),
                      Row(
                        children:  const [
                          Text(
                            '去凑单',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff333333)),
                            strutStyle: StrutStyle(height: 1, leading: .1),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xff333333),
                            size: 12,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // 第三行
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.only(right: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 50,
                        height: 10,
                        child: Transform.scale(
                          scale: 1,
                          child: Checkbox(
                              value: cart.isChecked,
                              checkColor: Colors.white,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.red),
                              side: const BorderSide(
                                  color: Color(0xff8c8c8c), width: 1.5),
                              shape: const CircleBorder(),
                              onChanged: (bool? v) {
                                setState(() {
                                  cart.setIsChecked(v!);
                                  widget.callback is Function ? widget.callback!(v): null;
                                });
                              }),
                        )),
                    ClipRRect(
                      // 剪切圆角
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: Image.network(
                        'https://img10.360buyimg.com/mobilecms/s234x234_jfs/t1/207671/9/28508/110781/63d76d5fF59218d97/ec639b662719d862.jpg!q70.dpg.webp',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  // height: 100,
                  constraints: const BoxConstraints(minHeight: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: Text.rich(
                            TextSpan(children: [
                              WidgetSpan(
                                  child: Container(
                                    height: 14.0,
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Image.network(
                                      'https://img12.360buyimg.com/imagetools/jfs/t1/130821/23/30011/1850/62fc68c8Ee4de6940/a35b97d85d3feef5.png',
                                    ),
                                  ),
                                  alignment: PlaceholderAlignment.middle),
                              const TextSpan(
                                text:
                                    '江中 益生菌冻干粉乳酸菌2g*20袋4000亿活性菌株胃肠道益生菌成人儿童孕妇中老年人通用复合益生元双歧杆活菌',
                              )
                            ]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xfff2f2f2),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                CustomDialog.showBottom(context, (data) {
                                  print(data);
                                });
                              },
                              child: const Text('【呵护肠道】4000亿活性菌益生菌',
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                            )),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 12,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          '秒杀中，4小时后结束',
                          style:
                              TextStyle(color: Color(0xfff2270c), fontSize: 12),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: '¥',
                                      style: TextStyle(fontSize: 12)),
                                  TextSpan(
                                      text: '52',
                                      style: TextStyle(fontSize: 18)),
                                  TextSpan(
                                      text: '.90',
                                      style: TextStyle(fontSize: 12))
                                ], style: TextStyle(color: Color(0xFFff4142))),
                                strutStyle: StrutStyle(
                                    forceStrutHeight: true,
                                    height: 1.5,
                                    leading: 0),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        if (textEditingController.text == '') {
                                          textEditingController.text = '1';
                                        } else {
                                          int num = int.parse(
                                              textEditingController.text);
                                          if (num > 1) {
                                            num--;
                                            textEditingController.text =
                                                num.toString();
                                          }
                                        }
                                      },
                                      child:
                                          const Icon(Icons.remove, size: 15)),
                                  Container(
                                    width: 36,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff2f2f2)),
                                    child: TextField(
                                      controller: textEditingController,
                                      inputFormatters: [NumberFormat()],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                      style: const TextStyle(fontSize: 12),
                                      strutStyle: const StrutStyle(
                                          height: .5, leading: .5),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        if (textEditingController.text == '') {
                                          textEditingController.text = '1';
                                        } else {
                                          int num = int.parse(
                                              textEditingController.text);
                                          num++;
                                          textEditingController.text =
                                              num.toString();
                                        }
                                      },
                                      child: const Icon(Icons.add, size: 15))
                                ],
                              )
                            ],
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {
                                ConfirmDialog.show(context, '1111111');

                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: const Text(
                                    '删除',
                                    style: TextStyle(
                                        fontSize: 10, color: Color(0xff262626)),
                                  ))))
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NumberFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String nValue = newValue.text;
    TextSelection nSelection = newValue.selection;
    nValue = nValue.replaceAll(RegExp(r"[^0-9]"), ''); //replaceAll相当于js的replace
//使光标定位到最后一个字符后面
    nSelection = newValue.selection.copyWith(
        baseOffset: min(nValue.length, nValue.length + 1),
        extentOffset: min(nValue.length, nValue.length + 1));

// TODO: implement formatEditUpdate
    return TextEditingValue(text: nValue, selection: nSelection);
  }
}
