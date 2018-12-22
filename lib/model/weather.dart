import 'dart:convert';

class Weather {
  String temperature;
  String weather;

  Weather(this.temperature, this.weather);

  static Weather deserialize(String json) {
    JsonDecoder decoder = new JsonDecoder();
    var map = decoder.convert(json);

    String description = map["weather"][0]["description"];
    int temperature = map["main"]["temp"].toInt();

    return new Weather("$temperature°C", description);
  }
}