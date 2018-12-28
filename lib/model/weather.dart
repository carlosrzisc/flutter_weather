import 'dart:convert';
import 'weather_condition.dart';

class Weather {
  String temperature;
  String location;
  DateTime dateTime;
  WeatherCondition condition;

  Weather(this.temperature, this.condition, this.location, this.dateTime);

  static Weather deserialize(String json) {
    JsonDecoder decoder = new JsonDecoder();
    var map = decoder.convert(json);

    String description = map["weather"][0]["description"];
    int id = map["weather"][0]["id"];
    WeatherCondition condition = WeatherCondition(id, description);
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(map["dt"] * 1000);
    int temperature = map["main"]["temp"].toInt();
    String location = "${map["name"]},  ${map["sys"]["country"]}";

    return new Weather("$temperature°C", condition, location, dateTime);
  }
}