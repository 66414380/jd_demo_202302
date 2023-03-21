import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/accountv2.dart';
import 'package:jd_demo_202302/cart.dart';
import 'package:jd_demo_202302/components/countryPicker.dart';
import 'package:jd_demo_202302/login.dart';
import 'package:jd_demo_202302/me.dart';
import 'package:jd_demo_202302/model/bottomBarListModel.dart';
import 'package:jd_demo_202302/model/cartModel.dart';
import 'package:jd_demo_202302/productsList.dart';
import 'package:provider/provider.dart';
import 'cateGoryPage.dart';
import 'app.dart';
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
customTwoTransitionPage({state, originPage, toPage}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: toPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        Stack(
      children: <Widget>[
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.0),
            end: const Offset(-0.1, 0.0),
          ).animate(animation),
          child: originPage,
        ),
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        )
      ],
    ),
  );
}
customOneTransitionPage({state, page}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0), //-1左向右，1右向左
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}


GoRouter router() {
  return GoRouter(
    //
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const App(), routes: [
        GoRoute(
            name: 'cateGoryPage',
            path: 'cateGoryPage',
            builder: (context, state) => const CateGoryPage(),
            routes: [
              GoRoute(
                  name: 'productsList',
                  path: 'productsList/:id', // params的参数需要传参, 而且:id要必写
                  pageBuilder: (context, state) {
                    String? id = state.params['id']; //只能是String
                    String? keyword = state.queryParams['keyword']; //只能是String
                    Map? obj = state.extra as Map?;
                    return customOneTransitionPage(state: state,page: ProductsList( id: id, obj: obj, keyword: keyword,));
                  }),
            ]),
        GoRoute(
            name: 'cart',
            path: 'cart',
            builder: (context, state) => const Cart()),
        GoRoute(name: 'me', path: 'me', builder: (context, state) => const Me())
      ]),

      GoRoute(
          name: 'login',
          path: '/login',
          // builder: (context, state) => const Login(),
          pageBuilder: (context, state) => customOneTransitionPage(
              state: state, page: const Login()),
          routes: [
            GoRoute(
                name: 'accountV2',
                path: 'accountV2',
                // builder: (context, state) => const AccountV2(),
                pageBuilder: (context, state) => customOneTransitionPage(
                    state: state,
                    page: const AccountV2())),
            GoRoute(
                name: 'countryPicker',
                path: 'countryPicker',
                // builder: (context, state) => const CountryPicker(),
                pageBuilder: (context, state) => customOneTransitionPage(
                    state: state,
                    page: const CountryPicker())),
          ]),

    ],
  );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CartModel>(
              create: (BuildContext context) => CartModel()),
          ChangeNotifierProvider<BottomBarList>(
              create: (BuildContext context) => BottomBarList()),
        ],
        child: MaterialApp.router(
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              navigatorKey: navigatorKey, // 使用fToast需要设置navigatorKey FToastBuilder()
              builder: FToastBuilder(),
              home: child,
            );
          },
          title: 'Jd Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerConfig: router(),
        ));
  }
}
