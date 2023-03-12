import 'package:flutter/material.dart';
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

customTransitionPage({state, originPage, toPage}) {
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

GoRouter router() {
  return GoRouter(
    // /cateGoryPage/productsList
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
                  path: 'productsList',
                  pageBuilder: (context, state) => customTransitionPage(
                      state: state,
                      originPage: const CateGoryPage(),
                      toPage: const ProductsList())),
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
          pageBuilder: (context, state) => customTransitionPage(
              state: state, originPage: const Me(), toPage: const Login()),
          routes: [
            GoRoute(
                name: 'accountV2',
                path: 'accountV2',
                // builder: (context, state) => const AccountV2(),
                pageBuilder: (context, state) => customTransitionPage(
                    state: state,
                    originPage: const Login(),
                    toPage: const AccountV2())),
            GoRoute(
                name: 'countryPicker',
                path: 'countryPicker',
                // builder: (context, state) => const CountryPicker(),
                pageBuilder: (context, state) => customTransitionPage(
                    state: state,
                    originPage: const Login(),
                    toPage: const CountryPicker())),
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
          title: 'Jd Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerConfig: router(),
        ));
  }
}
