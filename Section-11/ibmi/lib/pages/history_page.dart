import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: _dataCard(),
      ),
    );
  }

  Widget _dataCard() {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            final sharedPrefs = snapshot.data as SharedPreferences;
            final date = sharedPrefs.getString('bmi_date');
            final data = sharedPrefs.getStringList('bmi_data');
            return Center(
              child: InfoCard(
                width: _deviceWidth * 0.75,
                height: _deviceHeight * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _statusText(data![1]),
                    _dateText(date!),
                    _bmiText(data[0])
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.blue,
              ),
            );
          }
        });
  }

  Widget _statusText(String status) {
    return Text(
      status,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget _dateText(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return Text(
      '${parsedDate.month} / ${parsedDate.day} / ${parsedDate.year}',
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget _bmiText(String bmi) {
    return Text(
      bmi,
      style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
    );
  }
}
