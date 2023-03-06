import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:jd_demo_202302/components/headerNav.dart';
import 'package:jd_demo_202302/model/bottomBarListModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountV2 extends StatefulWidget {
  const AccountV2({Key? key}) : super(key: key);

  @override
  State<AccountV2> createState() => _AccountV2State();
}

class _AccountV2State extends State<AccountV2> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
                        context.read<BottomBarList>().setNoLoginBottomBarList();
                        context.pop('loginOut');
                      });
                    });
                  },
                  child: const Text(
                    '退出登录',
                    style: TextStyle(fontSize: 12, color: Color(0xff666666)),
                  ),
                )
              ],
            ),
          ]))
        ],
      ),
    );
  }
}
