import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/home/WeatherWidget.dart';
import 'ForecastList.dart';

class WeatherPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weather Forecast"),
      ),
      body: new Container(
          child: new Column(
            children: <Widget>[
              new Expanded(child: new WeatherWidget()),
              new Expanded(child: new ForecastList()),
            ],
          )
      ),
    );
  }
}