import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/components/confirmDialog.dart';
import 'package:jd_demo_202302/components/customAppBar.dart';
import 'package:jd_demo_202302/model/bottomBarListModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  late bool isChecked = false;
  late bool checkSubmit = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      setState(() {}); // 需要更新才能动态改变Icon
    });
    codeController.addListener(() {
      setState(() {}); // 需要更新才能动态改变Icon
    });
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    codeController.dispose();
  }

  get checkColor  {
    var phoneCheck = RegExp(r"^1[3-9]\d{9}$").hasMatch(phoneController.text);
    if(isChecked && phoneCheck && codeController.text.length == 6) {
      checkSubmit = true;
      return [
        const Color(0xfff10000),
        const Color(0xffff2000),
        const Color(0xffff4f18)
      ];
    } else {
      checkSubmit = false;
      return [
        const Color(0xfffab3b3),
        const Color(0xffffbcb3),
        const Color(0xffffcaba)
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
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
                        '登录注册',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff333333)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 44,
                  )
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xffefefef)))),
                              child: Row(
                                children: [
                                  const Text(
                                    '+86',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    strutStyle: const StrutStyle(
                                      // height: .5,
                                      leading: 0.5,
                                    ),
                                    decoration: InputDecoration(
                                        suffixIcon:
                                            phoneController.text.isNotEmpty
                                                ? GestureDetector(
                                                    onTap: () {
                                                      phoneController.text = '';
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 18,
                                                    ),
                                                  )
                                                : null,
                                        isCollapsed: true,
                                        hintText: '请输入手机号',
                                        hintStyle: const TextStyle(
                                            fontSize: 16,
                                            // height: 1, //1倍行高 ,需要与fontSize配合调试TextFormField的居中效果
                                            color: Color(0xff999999)),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(11)
                                      //限制长度
                                    ],
                                    onChanged: (v) {},
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xffefefef)))),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                    controller: codeController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    strutStyle: const StrutStyle(
                                      // height: .5,
                                      leading: 0.5,
                                    ),
                                    decoration: InputDecoration(
                                        suffixIcon:
                                            codeController.text.isNotEmpty
                                                ? GestureDetector(
                                                    onTap: () {
                                                      codeController.text = '';
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 18,
                                                    ),
                                                  )
                                                : null,
                                        isCollapsed: true,
                                        hintText: '请输入收到的验证码',
                                        hintStyle: const TextStyle(
                                            fontSize: 16,
                                            // height: 1, //1倍行高 ,需要与fontSize配合调试TextFormField的居中效果
                                            color: Color(0xff999999)),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(6)
                                      //限制长度
                                    ],
                                    onChanged: (v) {},
                                  )),
                                  Container(
                                    width: 110,
                                    height: 23,
                                    padding: const EdgeInsets.only(left: 20),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 1,
                                                color: Color(0xffcccccc)))),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: GestureDetector(onTap: () {
                                        if(!isChecked) {
                                          Fluttertoast.showToast(
                                            msg: "请阅读并勾选协议",
                                            gravity: ToastGravity.CENTER
                                          );
                                        }

                                      }, child: const Text(
                                        '获取验证码',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xffe2231a)),
                                      ),)
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),

                    const SizedBox(
                      height: 30,
                    ),
                    // 登录
                    GestureDetector(
                        onTap: () async {
                          if(checkSubmit) {
                            ConfirmDialog.showLoading(context);
                            final SharedPreferences prefs = await _prefs;
                            await Future.delayed(const Duration(seconds: 1));
                            ConfirmDialog.close();
                            prefs.setString('token', phoneController.text);
                            context.read<BottomBarList>().setHasLoginBottomBarList();
                            context.pop(phoneController.text);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          alignment: Alignment.center,
                          decoration:  BoxDecoration(
                              gradient: LinearGradient(
                                  colors: checkColor,
                                  stops: const [
                                    0,
                                    0.73,
                                    1
                                  ],
                                  begin: const FractionalOffset(0.0, 0.5),
                                  // Alignment.topCenter
                                  end: const FractionalOffset(1.0, 0.5)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: const Text(
                            '登录',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '账号密码登录',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, .4)),
                          ),
                          Text(
                            '手机快速注册',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(0, 0, 0, .4)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 70,
                    ),
                    // 分格线
                    SizedBox(
                      height: 30,
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
                            ],
                          )),
                          Expanded(
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              child: const Text(
                                '其它登录方式',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff999999)),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                height: 1,
                                color: const Color(0xffcccccc),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/login/qq.png',
                            width: 48,
                            height: 48,
                          ),
                          Image.asset(
                            'images/login/wx.png',
                            width: 48,
                            height: 48,
                          ),
                          Image.asset(
                            'images/login/apple.png',
                            width: 48,
                            height: 48,
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Checkbox(
                            value: isChecked,
                            checkColor: Colors.white,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => const Color(0xff8c8c8c)),
                            side: const BorderSide(
                                color: Color(0xff8c8c8c), width: 1.5),
                            onChanged: (bool? v) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            }),
                        const Text(
                          '协议',
                          style:
                              TextStyle(fontSize: 13, color: Color(0xff4a90e2)),
                        )
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}
