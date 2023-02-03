import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/pages/main_page.dart';
import 'package:ibmi/utils/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "iBMI",
      routes: {
        '/': (ctx) => MainPage(),
      },
      initialRoute: '/',
    );
  }
}
