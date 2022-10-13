import 'dart:convert';

import 'package:coincap/pages/details_page.dart';
import 'package:coincap/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  HttpService? _httpService;

  final List<String> _coins = [
    "bitcoin",
    "ethereum",
    "tether",
    "cardano",
    "ripple",
  ];

  late String _selectedCoin;

  @override
  void initState() {
    super.initState();
    print("initState");
    _httpService = GetIt.instance.get<HttpService>();
    _selectedCoin = _coins.first;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectedCoinDropdown(),
              _dataWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectedCoinDropdown() {
    var dropdownItems = _coins.map((coin) {
      return DropdownMenuItem(
        value: coin,
        child: Text(
          coin,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }).toList();

    return DropdownButton(
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
      ),
      underline: Container(),
      value: _selectedCoin,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          _selectedCoin = value!;
        });
      },
    );
  }

  Widget _descriptionCardWidget(String desc) {
    return Container(
      height: _deviceHeight! * 0.45,
      width: _deviceWidth! * 0.90,
      margin: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: _deviceHeight! * 0.01,
        horizontal: _deviceHeight! * 0.01,
      ),
      color: Color.fromRGBO(83, 88, 206, 0.5),
      child: Text(
        desc,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
      future: _httpService!.get("/coins/$_selectedCoin"),
      builder:
          (BuildContext context, AsyncSnapshot<Response<String>?> snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data?.data ?? "");
          num usdPrice = data['market_data']['current_price']['usd'];
          Map<String, dynamic> allPrices = data['market_data']['current_price'];
          num change24h = data['market_data']['price_change_percentage_24h'];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(allPrices),
                  ),
                ),
                child: _coinImageWidget(data["image"]["large"]),
              ),
              _currentPriceWidget(usdPrice),
              _percentageChangeWidget(change24h),
              _descriptionCardWidget(data['description']['en']),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _coinImageWidget(String imgUrl) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imgUrl)),
      ),
    );
  }

  Widget _currentPriceWidget(num rate) {
    return Text(
      "${rate.toStringAsFixed(2)} USD",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _percentageChangeWidget(num change) {
    return Text(
      "${change.toString()} %",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
