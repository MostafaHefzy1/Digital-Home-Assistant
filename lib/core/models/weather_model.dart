class WeatherModel {
  List<Weather>? weather;

  WeatherModel({
    this.weather,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Weather {
  String? description;

  Weather({
    this.description,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['description'] = description;

    return data;
  }
}