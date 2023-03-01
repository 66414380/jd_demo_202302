

import 'package:flutter/cupertino.dart';

class GoodsItem extends StatefulWidget {
  const GoodsItem({Key? key, this.height}) : super(key: key);
  final double? height;
  @override
  State<GoodsItem> createState() => _GoodsItemState();
}

class _GoodsItemState extends State<GoodsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Column(
        children: [
          ClipRRect( // 剪切圆角
            borderRadius: const BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
            child: Image.network('https://img10.360buyimg.com/mobilecms/s360x360_jfs/t1/145895/27/30618/143183/632bececE2b615c1d/bb079706ccbb503a.jpg!q70.dpg.webp'),
          ),
          const SizedBox(
            height: 5.205,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.411,right: 10.411),
            child: Column(
              children: [
                const Text('ℂℂBKQU【好质量】 2022新款秋冬季男鞋一脚蹬懒人豆豆鞋韩版潮流百搭男士休闲皮鞋驾车乐福潮鞋 卡其 （棕色） 39',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14.5749, color: Color(0xFF434343)),
                  strutStyle: StrutStyle(forceStrutHeight: true, height: 1, leading: .5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 31.23,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('¥', style: TextStyle(fontSize: 14.5749, color: Color(0xFFff4142)), strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5, leading: 0)),
                      const Text('118', style: TextStyle(fontSize: 20.82, color: Color(0xFFff4142)), strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5, leading: 0),),
                      const Text('.00', style: TextStyle(fontSize: 14.5749, color: Color(0xFFff4142))),
                      Container(
                        height: 18,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 6.246,right: 0.521),
                        padding: const EdgeInsets.symmetric(horizontal: 2.603),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(3.2)),
                          border: Border.all(color: const Color(0xFFff4142), width: .5),
                        ),
                        child: const Text('满减', style: TextStyle(fontSize: 12, color: Color(0xFFff4142)),strutStyle: StrutStyle(forceStrutHeight: true, height: 1,leading: 0)),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('100%好评率', style: TextStyle(fontSize: 12.49, color: Color(0xFF999999))),

                    Container(
                      width: 52.05,
                      height: 20.81,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.4)),
                        color: Color(0xFFf2f2f2),
                      ),
                      child: const Text('看相似', style: TextStyle(fontSize: 12, color: Color(0xFF262626)), strutStyle: StrutStyle(forceStrutHeight: true, height: 1,leading: 0)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}







