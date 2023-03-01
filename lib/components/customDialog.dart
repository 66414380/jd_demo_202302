import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<Map> list = [
  {'name': '测试1111111', 'id': 0},
  {'name': '测试2222222', 'id': 1},
  {'name': '测试3333333', 'id': 2},
  {'name': '测试4444444', 'id': 3},
];

class CustomDialog {
  static showBottom(BuildContext context, [function]) {
    showModalBottomSheet(
        context: context,
        // 是否时全屏还是半屏,设置全屏可以增加窗口高度
        isScrollControlled: true,
        //点击外面是否可以关闭
        isDismissible: true,
        // 窗口外颜色
        barrierColor: const Color.fromRGBO(0, 0, 0, .5),
        // 弹窗颜色
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return AlertBottomWidget(
            items: list,
            chooseCallback: function,
          );
        });
  }
}

class AlertBottomWidget extends StatefulWidget {
  final List<Map> items;

  final Function? chooseCallback;

  const AlertBottomWidget(
      {super.key, required this.items, this.chooseCallback});

  @override
  AlertBottomWidgetState createState() => AlertBottomWidgetState();
}

class AlertBottomWidgetState extends State<AlertBottomWidget> {
  late int selected = 0;

  List<Widget> itemsWidget(BuildContext context) {
    List<Widget> list = [];
    list.add(Container(
      width: double.infinity,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xfff2f2f2)
            ),
            child:  const Icon(
              Icons.close,
              size: 16,
            ),
          ),
        )));
    list.add(Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            widget.items.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: Container(
                    height: 30,
                    margin: const EdgeInsets.only(left: 12, top: 12, bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.6,
                          color: selected == index
                              ? Colors.red
                              : Colors.transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      color: selected == index
                          ? const Color(0xfffcedeb)
                          : const Color(0xfff2f2f2),
                    ),
                    child: Text(
                      widget.items[index]['name'],
                      style: TextStyle(
                        fontSize: 13,
                        color: selected == index
                            ? const Color(0xfff2270c)
                            : const Color(0xff262626),
                      ),
                      strutStyle: const StrutStyle(height: 1, leading: 1),
                    ),
                  ),
                )),
      ),
    ));

    // 按键
    list.add(Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
      child: GestureDetector(
        onTap: () {
          widget.chooseCallback is Function ? widget.chooseCallback!(selected) : null;
          context.pop();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfff2140c),
                  Color(0xFFf2270c),
                  Color(0xFFf24d0c)
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: const Text(
            '确认',
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
        ),
      ),
    ));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white, // 会覆盖showModalBottomSheet的backgroundColor
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)), // 需要同时设置圆角才会生效
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: itemsWidget(context),
      ),
    );
  }
}
