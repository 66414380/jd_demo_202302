import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, bottom: 0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'https://img10.360buyimg.com/n2/s240x240_jfs/t1/118519/7/32529/61103/640855caF74cae113/1d7b4ea5d27dced0.jpg!q70.jpg.webp',
            width: 120,
            height: 120,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(right: 10, bottom: 8, left: 10),
            constraints: const BoxConstraints(minHeight: 125),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: [
                    WidgetSpan(
                        child: Container(
                          height: 14.0,
                          margin: const EdgeInsets.only(right: 5),
                          child: Image.network(
                            'https://m.360buyimg.com/umm/jfs/t1/156719/6/34246/2111/63d76922Fee5c4918/e47baa02e01067c7.png',
                          ),
                        ),
                        alignment: PlaceholderAlignment.middle),
                    const TextSpan(
                      text: 'OPPO 一加 Ace 2 满血版骁龙®8+旗舰平台 1.5K灵犀触控屏',
                    )
                  ]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 9),
                  child: const Text.rich(
                    TextSpan(children: [
                      TextSpan(text: '¥', style: TextStyle(fontSize: 12)),
                      TextSpan(text: '3099', style: TextStyle(fontSize: 18)),
                    ], style: TextStyle(color: Color(0xFFff4142))),
                    strutStyle: StrutStyle(
                        forceStrutHeight: true, height: 1.5, leading: 0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 2),
                  child: Text.rich(
                    TextSpan(children: [
                      WidgetSpan(
                          child: Container(
                            height: 14.0,
                            margin: const EdgeInsets.only(right: 5),
                            child: Image.network(
                              'https://img12.360buyimg.com/img/s48x28_jfs/t1/97136/38/13269/546/5e587d31E40b01f2b/9f2f670a546fbd7c.png',
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle),
                      const TextSpan(
                          text: '5万+条评价好评率98%',
                          style: TextStyle(color: Color(0xff666666)))
                    ]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            '一加手机京东自营官方旗舰店',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff999999)),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 12, color: Color(0xff999999))
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        height: 13,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                            color: Color(0xffcccccc)),
                        child: const Text(
                          '广告',
                          strutStyle: StrutStyle(
                            forceStrutHeight: true,
                            height: 0.6,
                            leading: 0.5
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
