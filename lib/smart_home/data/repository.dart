import 'web_services.dart';

import '../../core/models/news_model.dart';
import '../../core/models/weather_model.dart';

class HomeRepository {
  final HomeWebServices homeWebServices;

  HomeRepository(this.homeWebServices);

  Future<WeatherModel> getCurrentWeather() async {
    return WeatherModel.fromJson(await homeWebServices.getCurrentWeather());
  }

  Future<NewsModel> getNews() async {
    return NewsModel.fromJson(await homeWebServices.getNews());
  }
}
