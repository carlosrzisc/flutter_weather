import 'dart:convert';

class ForecastData {
  List<ForecastWeather> forecastList;
  ForecastData(this.forecastList);

  static ForecastData deserialize(String json) {
    JsonDecoder decoder = new JsonDecoder();
    var map = decoder.convert(json);

    var list = map["list"];
    List<ForecastWeather> forecast = [];

    for (var weatherMap in list) {
      forecast.add(ForecastWeather._deserialize(weatherMap));
    }
    return new ForecastData(forecast);
  }
}

class ForecastWeather {
  String temperature;
  String description;
  DateTime dateTime;

  ForecastWeather(this.temperature, this.description, this.dateTime);

  static ForecastWeather _deserialize(Map<String, dynamic> map) {
    String description = map["weather"][0]["description"];
    int temperature = map["main"]["temp"].toInt();
    DateTime dateTime = new DateTime.fromMicrosecondsSinceEpoch(map["dt"]);

    return new ForecastWeather("$temperature°C", description, dateTime);
  }
}