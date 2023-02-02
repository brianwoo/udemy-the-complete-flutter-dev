import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  late double _deviceHeight, _deviceWidth;
  int _age = 25;
  int _weight = 160;
  int _height = 70;
  int _gender = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: Center(
        child: Container(
          height: _deviceHeight * 0.9,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ageSelectContainer(),
                  _weightSelectContainer(),
                ],
              ),
              _heightSelectContainer(),
              _genderSelectContainer(),
              _calculateBMIButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ageSelectContainer() {
    return InfoCard(
      height: _deviceHeight * 0.20,
      width: _deviceWidth * 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Yr age",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            _age.toString(),
            style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _age--;
                    });
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _age++;
                    });
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _weightSelectContainer() {
    return InfoCard(
      height: _deviceHeight * 0.20,
      width: _deviceWidth * 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Weight lbs",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            _weight.toString(),
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _weight--;
                    });
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _weight++;
                    });
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _heightSelectContainer() {
    return InfoCard(
      width: _deviceWidth * 0.90,
      height: _deviceHeight * 0.20,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Height in",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          Text(
            _height.toString(),
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: _deviceWidth * 0.8,
            child: CupertinoSlider(
              max: 96,
              min: 10,
              divisions: 86,
              value: _height.toDouble(),
              onChanged: (value) {
                setState(() {
                  _height = value.toInt();
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _genderSelectContainer() {
    return InfoCard(
      width: _deviceWidth * 0.9,
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Gender",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: _gender,
            children: {
              0: Text("Male"),
              1: Text("Female"),
            },
            onValueChanged: (value) {
              setState(() {
                _gender = value!;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _calculateBMIButton() {
    return CupertinoButton.filled(
      child: Text("Calculate BMI"),
      onPressed: () {
        if (_height > 0 && _weight > 0 && _age > 0) {
          double bmi = (_weight / pow(_height, 2)) * 703;
          print(bmi);
          _showResultDialog(bmi);
        }
      },
    );
  }

  void _showResultDialog(double bmi) {
    String status;
    if (bmi < 18.5) {
      status = "Underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      status = "Normal";
    } else if (bmi >= 25 && bmi < 30) {
      status = "Overweight";
    } else {
      status = "Obese";
    }
    final bmiString = bmi.toStringAsFixed(2);
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(status),
        content: Text(bmiString),
        actions: [
          CupertinoDialogAction(
            child: Text("OK"),
            onPressed: () {
              _saveResult(bmiString, status);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _saveResult(String bmi, String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bmi_date', DateTime.now().toString());
    await prefs.setStringList('bmi_data', [bmi, status]);
    print("BMI Result Saved!");
  }
}
