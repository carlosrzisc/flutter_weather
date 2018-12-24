
import 'package:flutter/material.dart';
import 'package:flutter_weather/model/forecast.dart';

class DetailsPage extends StatelessWidget {
  final ForecastWeather weather;
  DetailsPage(this.weather);

  @override
  Widget build(BuildContext context) {
    print("Weather: $weather");
    return Scaffold(
        appBar: AppBar(title: Text("Weather Details")),
        body: Column(
          children: <Widget>[
          ],
        ));
  }
}