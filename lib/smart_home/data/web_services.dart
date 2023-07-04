// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:dio/dio.dart';
import '../../core/util/app_constance.dart';

class HomeWebServices {
  Dio? dio;
  HomeWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: "",
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    dio = Dio(options);
  }

  Future<dynamic> getCurrentWeather() async {
    try {
      Response response = await dio!.get(AppConstance.wetherAppApi);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        log(e.response!.data);
      }
    }
  }

  Future<dynamic> getNews() async {
    try {
      Response response = await dio!.get(AppConstance.newsAppApi);
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        log(e.response!.data);
      }
    }
  }
}
