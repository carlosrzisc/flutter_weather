import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/home/WeatherPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Weather Forecast',
      theme: new ThemeData(
          primarySwatch: Colors.cyan,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white))),
      home: new WeatherPage(),
    );
  }
}