import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_demo_202302/cart.dart';
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
          path: 'cateGoryPage',
          builder: (context, state) => const CateGoryPage(),
        ),
        GoRoute(path: 'cart', builder: (context, state) => const Cart())
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
              create: (BuildContext context) => CartModel())
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
