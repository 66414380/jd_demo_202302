import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class CountryPicker extends StatefulWidget {
  const CountryPicker({Key? key}) : super(key: key);

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  final ScrollController scrollController = ScrollController();
  Map<String, List<Map<String, String>>> countryCodes = {
    "*": [
      {"中国": "86"},
      {"中国香港": "852"},
      {"中国澳门": "853"},
      {"中国台湾": "886"},
      {"新加坡": "65"},
      {"马来西亚": "60"},
      {"美国": "1"},
      {"澳大利亚": "61"},
      {"加拿大": "1"},
      {"新西兰": "64"},
      {"日本": "81"},
      {"韩国": "82"}
    ],
    "A": [
      {"阿联酋": "971"},
      {"澳大利亚": "61"}
    ],
    "F": [
      {"菲律宾": "63"}
    ],
    "H": [
      {"韩国": "82"}
    ],
    "J": [
      {"加拿大": "1"}
    ],
    "L": [
      {"老挝": "856"}
    ],
    "M": [
      {"马来西亚": "60"},
      {"美国": "1"},
      {"墨西哥": "52"}
    ],
    "R": [
      {"日本": "81"}
    ],
    "S": [
      {"沙特阿拉伯": "966"}
    ],
    "T": [
      {"泰国": "66"}
    ],
    "W": [
      {"文莱": "673"}
    ],
    "X": [
      {"新加坡": "65"},
      {"新西兰": "64"}
    ],
    "Y": [
      {"印度尼西亚": "62"},
      {"英国": "44"},
      {"越南": "84"}
    ],
    "Z": [
      {"中国": "86"},
      {"中国澳门": "853"},
      {"中国台湾": "886"},
      {"中国香港": "852"}
    ]
  };
  List<Map<String, dynamic>> rightList = [];
  late String rightName = '*';

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // print(scrollController.offset.toInt());
      Map obj = rightList.firstWhere(
          (element) => element['scrollInt'] > scrollController.offset.toInt());
      setState(() {
        rightName = obj['name'];
      });
    });
    int i = 0;
    countryCodes.forEach((key, value) {
      rightList.add({
        'name': key,
        'length': (value.length + 1) * 43,
        'totalInt': 0,
        'scrollInt': 0
      });
    });

    rightList.fold({'length': 0}, (value, element) {
      rightList[i]['totalInt'] = value['length'];
      rightList[i]['scrollInt'] = element['length'] + value['length'];
      i++;
      return ({
        'length': element['length'] + value['length']
      }); // element['length']在加号前面,否则会报错
    });

    print(rightList);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
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
                    '选择国家或地区',
                    style: TextStyle(fontSize: 18, color: Color(0xff333333)),
                  ),
                ),
              ),
              const SizedBox(
                width: 44,
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            ListView(controller: scrollController, children: [
              for (var item in countryCodes.keys)
                StickyHeader(
                    callback: (d) {
                      // print(d.floor());
                    },
                    header: Container(
                      height: 43,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 15, right: 23),
                      color: const Color(0xfff5f5f5),
                      child: Text(item,
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xff999999))),
                    ),
                    content: Column(
                      children: [
                        for (var item1 in countryCodes[item]!)
                          GestureDetector(
                              onTap: () {
                                // print(item1.values.first);
                                context.pop(item1.values.first);
                              },
                              child: Container(
                                  height: 43,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 23),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1,
                                              color: Color(0xffdbdbdb)))),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (var item2 in item1.keys)
                                          Text(item2,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff000000))),
                                        for (var item2 in item1.values)
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: Text('+$item2',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          Color(0xff999999))))
                                      ])))
                      ],
                    ))
            ]),
            Positioned(
                top: 50,
                right: 15,
                child: Column(
                    children: List.generate(
                        rightList.length,
                        (i) => GestureDetector(
                              onTap: () {
                                scrollController.jumpTo(double.parse(
                                    '${rightList[i]['totalInt']}'));
                              },
                              child: Text(
                                rightList[i]['name'],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: rightName == rightList[i]['name']
                                        ? const Color(0xff000000)
                                        : const Color(0xff2d90ff)),
                              ),
                            ))))
          ],
        ));
  }
}
