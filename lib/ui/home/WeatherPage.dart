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
      body: new Material(
          color: Colors.cyan,
          child: new Column(
            children: <Widget>[
              new Container(child: new WeatherWidget(), height: 200,),
              new Expanded(child: new ForecastList()),
            ],
          )
      ),
    );
  }
}