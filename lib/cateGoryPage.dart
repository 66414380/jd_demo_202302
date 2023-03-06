/*
WebView 获取 jsonp
Container 嵌套 Container
ListView.builder 嵌套 GridView.builder
  shrinkWrap: true, // 要点
  physics: const NeverScrollableScrollPhysics(), // 要点
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'model//category.dart';

class CateGoryPage extends StatelessWidget {
  const CateGoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const String html = '''
<!DOCTYPE html>
<html lang="en">
<script type="text/javascript">
function pj1715(result){channel && channel.postMessage(JSON.stringify(result));}
</script>
<script type="text/javascript" src="https://wq.360buyimg.com/data/coss/keyword/project/mpj1715.jsonp?callback=pj1715"></script>
</html>
''';

class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin {
  late List<Map<String, dynamic>> listJson = [];
  late List<Category> listClass = [];
  late List<Level1words> level1wordsList = [];
  late WebViewController controller = WebViewController();
  late int selected = 0;
  ScrollController scrollLeftController = ScrollController(),
      scrollRightController = ScrollController();

  @override
  initState() {
    super.initState();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(html)
      ..addJavaScriptChannel('channel',
          onMessageReceived: (JavaScriptMessage message) {
            //Unhandled Exception: type 'List<dynamic>' is not a subtype of type 'List<Map<String, dynamic>>'
            // cast为List类中的方法，它可以传入一个泛型，是该泛型的类型正常返回，不是的会抛出异常。
            listJson = json
                .decode(message.message)['keywordAreas']
                .cast<Map<String, dynamic>>();
            setState(() {
              listClass = List.generate(
                  listJson.length, (index) => Category.fromJson(listJson[index]));
              level1wordsList = listClass[0].level1words;
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeJavaScriptChannel('channel');
    scrollLeftController.dispose();
    scrollRightController.dispose();
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Widget gridWidget(List<Level2words> list) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 10, childAspectRatio: 1 // 宽高比
          // crossAxisSpacing: 10
        ),
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              onTap: () {
                print(list[i].url);
              },
              child: Column(
                children: [
                  FadeInImage.assetNetwork(
                      width: 70,
                      height: 70,
                      fit: BoxFit.fitHeight,
                      fadeInDuration: const Duration(milliseconds: 250),
                      placeholder: 'images/categorydef.png',
                      image: 'https:${list[i].imageUrl}'),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Text(
                      list[i].keyword,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xff333333)),
                    ),
                  )
                ],
              ));
        },
        itemCount: list.length);
  }

  Widget showRightWidget(List<Level1words> list) {
    return ListView.builder(
      controller: scrollRightController,
      itemBuilder: (BuildContext context, int i) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(list[i].keyword,
              style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w700)),
          Container(
              margin: const EdgeInsets.only(top: 9),
              padding:
              const EdgeInsets.only(top: 7, left: 10, right: 10, bottom: 0),
              child: gridWidget(list[i].level2words))
        ]);
      },
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Row(
            children: [
              Container(
                width: 86,
                color: const Color(0xfff8f8f8),
                child: ListView.builder(
                    controller: scrollLeftController,
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = i;
                              scrollLeftController.animateTo(i * 46,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.linear);
                              level1wordsList = listClass[i].level1words;
                              scrollRightController.jumpTo(0);
                            });
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 85,
                                height: 46,
                                alignment: Alignment.center,
                                color: selected == i
                                    ? Colors.white
                                    : const Color(0xfff8f8f8),
                                child: Text(
                                  listClass[i].areaName,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: selected == i
                                          ? const Color(0xffe93b3d)
                                          : const Color(0xff333333)),
                                ),
                              )));
                    },
                    itemCount: listClass.length),
              ),
              Expanded(
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 19, left: 7, right: 7, bottom: 0),
                    // 判断是否有值，否则是报 List.[] (dart:core-patch/growable_array.dart:264:36)
                    child: listClass.isNotEmpty
                        ? showRightWidget(level1wordsList)
                        : null,
                  ))
            ],
          ),
        ));
  }
}
