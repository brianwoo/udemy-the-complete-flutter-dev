import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_question/providers/points_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  late double _deviceWidth, _deviceHeight;

  StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<PointsProvider>(
      create: (context) => PointsProvider(),
      builder: (context, child) => _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _headingAndResult(context),
                _pointSlider(context),
                _startButton(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _headingAndResult(BuildContext context) {
    return Column(
      children: [
        Text(
          "Points",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          Provider.of<PointsProvider>(context, listen: true).getResult(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _pointSlider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.1),
      child: Slider(
        value: Provider.of<PointsProvider>(context, listen: true).getPoints(),
        onChanged: (newPoints) {
          Provider.of<PointsProvider>(context, listen: false)
              .setPoints(newPoints);
        },
        min: 0,
        max: 2,
        divisions: 2,
        label: "Points",
      ),
    );
  }

  Widget _startButton(BuildContext context) {
    return MaterialButton(
      color: Colors.blue.shade500,
      minWidth: _deviceWidth * 0.8,
      height: _deviceHeight * 0.1,
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PointsPage()));
      },
      child: Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Text(
          Provider.of<PointsProvider>(context, listen: false).getResult(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        )),
      ),
    );
  }
}
