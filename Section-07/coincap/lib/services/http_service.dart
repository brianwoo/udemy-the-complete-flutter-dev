import 'dart:convert';

import 'package:coincap/models/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _baseUrl;

  HttpService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _baseUrl = _appConfig!.coinApiBaseUrl;
    print(_baseUrl);
  }

  Future<Response<String>?> get(String path) async {
    try {
      String url = "$_baseUrl$path";
      Future<Response<String>> response = dio.get<String>(url);
      // TODO: remove
      // response.then((value) => print(value));
      return response;
    } catch (e) {
      print("HttpService: Unable to perform get request. $e");
    }
  }
}
