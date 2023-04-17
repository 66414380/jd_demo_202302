/**
 *  // 一定要使用这个buildContext上下文，否则会退出整个页面
    Navigator.pop(buildContext);
 */
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:jd_demo_202302/components/customToast.dart';
import 'package:jd_demo_202302/components/headerNav.dart';
import 'package:jd_demo_202302/model/bottomBarListModel.dart';
import 'package:jd_demo_202302/model/versionModel.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountV2 extends StatefulWidget {
  const AccountV2({Key? key}) : super(key: key);

  @override
  State<AccountV2> createState() => _AccountV2State();
}

class _AccountV2State extends State<AccountV2> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  OtaEvent? currentEvent;
  late VersionModel serviceVersion;
  late String version = '';
  Future<void> tryOtaUpdate() async {
    try {
      OtaUpdate()
          .execute(serviceVersion.androidAddress,
              destinationFilename: 'app-release.apk')
          .listen(
        (OtaEvent event) {
          setState(() => currentEvent = event);
        },
      );
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
    }
  }

  ///检测当前app版本
  _getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo);
    var currentVersion = packageInfo.version;
    return currentVersion;
  }

  ///版本校验
  _checkVersion() async {
    /// 获得服务器版本
    //这写上获取json的url，json格式按照定义的versionModel
    // 不能使用127.0.0.1，否则会出现(OS Error: Connection refused, errno = 111
    String url = 'http://192.168.0.105/version.json';
    Response<Map<String, dynamic>> json = await Dio().get(url);
    print(json.data);
    if (json.data == null) {
      //获取版本失败 网络或者其他原因 退出App
      //ToastUtil.showToast('获取版本失败');
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    serviceVersion = VersionModel.fromJson(json.data ?? {});
    var currentVersion = await _getCurrentVersion();
    if (currentVersion == serviceVersion.version) {
      //不更新
      CustomToast().showToast('已经是最新版本');
    } else {
      //版本不符弹出对话框
      setState(() {
        version = currentVersion;
      });
      _showUpdateDialog();
    }
  }

  _showUpdateDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (buildContext) {
          List<Widget> contentList = [];
          TextStyle style = const TextStyle(
            fontSize: 15,
          );
          contentList.addAll(serviceVersion.updateContent.map((item) {
            return Text(
              item,
              style: style,
            );
          }).toList());
          contentList.insert(
              0,
              Container(
                height: 0.5,
                color: Colors.black,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
              ));
          return CupertinoAlertDialog(
            title: const Text('版本更新',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contentList),
            actions: <Widget>[
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.grey),
                  // textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.grey))
                ),
                onPressed: serviceVersion.mandatory
                    ? null
                    : () {
                        // 一定要使用这个buildContext上下文，否则会退出整个页面
                        Navigator.pop(buildContext);
                      },
                child: const Text('取消'),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),// 背景色
                    foregroundColor: MaterialStatePropertyAll(Colors.lightGreenAccent),// 字体颜色
                    textStyle:
                        MaterialStatePropertyAll(TextStyle(fontSize: 20))),//字体大小
                onPressed: () async {
                  if (Platform.isAndroid) {
                    //安卓应用内下载
                    // Navigator.pop(context);
                    tryOtaUpdate();
                  } else {
                    //ios 跳转商店
                    if (await canLaunchUrl(serviceVersion.iosAddress)) {
                      await launchUrl(serviceVersion.iosAddress);
                    } else {
                      throw 'Could not launch ';
                    }
                  }
                },
                child: const Text('更新'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
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
                        '账户设置',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      ),
                    ),
                  ),
                  const RightHeader()
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      _prefs.then((value) {
                        value.remove('token');
                        setState(() {
                          context
                              .read<BottomBarList>()
                              .setNoLoginBottomBarList();
                          context.pop('loginOut');
                        });
                      });
                    },
                    child: const SizedBox(
                      height: 32,
                      child: Text(
                        '退出登录',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff666666)),
                      ),
                    ))
              ],
            ),
            const Divider(
              color: Color(0xff666666),
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      _checkVersion();
                    },
                    child: const SizedBox(
                      height: 32,
                      child: Text(
                        '更新版本',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff666666)),
                      ),
                    ))
              ],
            ),
            const Divider(
              color: Color(0xff666666),
            ),
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Text(
                      '下载显示： ${currentEvent?.status == OtaStatus.DOWNLOADING
                          ? '下载中'
                          : (currentEvent?.status == OtaStatus.INSTALLING
                          ? '安装中...'
                          : '')} ${(currentEvent?.status == OtaStatus.DOWNLOADING
                          ? ':'
                          : '')} ${currentEvent?.value ?? ''}${currentEvent?.status ==
                          OtaStatus.DOWNLOADING ? '%' : ''} '),
                ),
                Text('版本----$version')
          ]))
        ],
      ),
    );
  }
}
