import 'package:flutter/material.dart';
import 'package:frivia/pages/start_page.dart';
import 'package:frivia/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // @override
  // Widget build2(BuildContext context) {
  //   return ChangeNotifierProvider<GamePageProvider>(
  //     create: (context) => GamePageProvider(context: context),
  //     child: MaterialApp(
  //       title: 'Frivia',
  //       theme: ThemeData(
  //         fontFamily: 'ArchitectsDaughter',
  //         primarySwatch: Colors.blue,
  //         scaffoldBackgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
  //       ),
  //       home: StartPage(),
  //     ),
  //   );
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Frivia",
      theme: ThemeData(
        fontFamily: 'ArchitectsDaughter',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
      ),
      home: StartPage(),
      // builder: (context, child) => ChangeNotifierProvider<GamePageProvider>(
      //   create: (context) => GamePageProvider(context: context),
      //   child: StartPage(),
      // ),
    );
  }

  // This widget is the root of your application.
  // @override
  // Widget build1(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => GamePageProvider(context: context),
  //     child: MaterialApp(
  //       title: 'Frivia',
  //       theme: ThemeData(
  //         fontFamily: 'ArchitectsDaughter',
  //         primarySwatch: Colors.blue,
  //         scaffoldBackgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
  //       ),
  //       home: StartPage(),
  //     ),
  //   );
  // }
}
