import 'package:demo/page/root/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:demo/page/root/app.dart';



void main() {

  FluroRouter router = FluroRouter();
  PageRoutes.configFluroRoutes(router);
  App.router = router;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      onGenerateRoute: App.router.generator,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: TabBarController(),
      ),
    );
  }
}