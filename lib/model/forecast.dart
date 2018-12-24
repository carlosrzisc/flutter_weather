import 'dart:convert';
import 'weather_condition.dart';

class ForecastData {
  List<ForecastWeather> forecastList;
  Map<String, List<ForecastWeather>> dailyForecast;

  ForecastData(this.forecastList, this.dailyForecast);

  static ForecastData deserialize(String json) {
    JsonDecoder decoder = new JsonDecoder();
    var map = decoder.convert(json);

    var list = map["list"];
    List<ForecastWeather> forecast = [];
    Map<String, List<ForecastWeather>> forecastMap = Map();

    for (var weatherMap in list) {
      String date = weatherMap["dt_txt"].split(" ")[0];
      String time = weatherMap["dt_txt"].split(" ")[1];

      if (time == "00:00:00") {
        forecast.add(ForecastWeather._deserialize(weatherMap));
      }
      if (forecastMap.containsKey(date)){
        forecastMap[date].add(ForecastWeather._deserialize(weatherMap));
      } else {
        List<ForecastWeather> newForecast = [];
        newForecast.add(ForecastWeather._deserialize(weatherMap));
        forecastMap.putIfAbsent(date, () => newForecast);
      }
    }
    return new ForecastData(forecast, forecastMap);
  }
}

class ForecastWeather {
  String temperature;
  DateTime dateTime;
  String dateTimeStr;
  double pressure;
  double humidity;
  double wind;
  WeatherCondition condition;


  ForecastWeather(this.temperature,
                  this.condition,
                  this.dateTime,
                  this.dateTimeStr,
                  this.pressure,
                  this.humidity,
                  this.wind);

  static ForecastWeather _deserialize(Map<String, dynamic> map) {
    String description  = map["weather"][0]["description"];
    int id = map["weather"][0]["id"];
    WeatherCondition condition = new WeatherCondition(id, description);
    int temperature = map["main"]["temp"].toInt();
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(map["dt"] * 1000);
    String dateTimeStr = map["dt_txt"];
    double humidity = map["main"]["humidity"].toDouble();
    double pressure = map["main"]["pressure"].toDouble();
    double wind = map["wind"]["speed"].toDouble();

    return new ForecastWeather("$temperature°C", condition, dateTime, dateTimeStr, pressure, humidity, wind);
  }
}