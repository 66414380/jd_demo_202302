import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/accountv2.dart';
import 'package:jd_demo_202302/cart.dart';
import 'package:jd_demo_202302/login.dart';
import 'package:jd_demo_202302/me.dart';
import 'package:jd_demo_202302/model/bottomBarListModel.dart';
import 'package:jd_demo_202302/model/cartModel.dart';
import 'package:provider/provider.dart';
import 'cateGoryPage.dart';
import 'app.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const App(), routes: [
        GoRoute(
          name: 'cateGoryPage',
          path: 'cateGoryPage',
          builder: (context, state) => const CateGoryPage(),
        ),
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
          pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const Login(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => Stack(
                  children: <Widget>[
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(-0.1, 0.0),
                      ).animate(animation),
                      child: const Me(),
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
              ),
          routes: [
            GoRoute(
              name: 'accountV2',
              path: 'accountV2',
              // builder: (context, state) => const AccountV2(),
              pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const AccountV2(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => Stack(
                  children: <Widget>[
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(-0.1, 0.0),
                      ).animate(animation),
                      child: const Login(),
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
              ),
            ),
          ]),

      // GoRoute(
      //   path: '/catalog',
      //   builder: (context, state) => const MyCatalog(),
      //   routes: [
      //     GoRoute(
      //       path: 'cart',
      //       builder: (context, state) => const MyCart(),
      //     ),
      //   ],
      // ),
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
