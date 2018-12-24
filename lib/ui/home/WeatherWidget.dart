import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather.dart';
import 'package:flutter_weather/api/service.dart';
import 'package:flutter_weather/model/weather_condition.dart';

import 'package:intl/intl.dart';

class WeatherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _WeatherWidgetState();
  }
}

class _WeatherWidgetState extends State<WeatherWidget> {
  static final String loading = "Loading...";
  static final String error =
      "Error: could not fetch the weather data from the server";
  var _weather = new Weather("", new WeatherCondition(0, loading), "");

  @override
  void initState() {
    super.initState();
    Api.getInstance()
        .getWeather()
        .then((content) => this.setState(() {
              print("weather: ${content.condition.description}");
              this._weather = content;
            }))
        .catchError((e) => this.setState(() {
              this._weather = new Weather("", new WeatherCondition(0, error), "");
            }));
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Material(
        color: Colors.cyan,
        textStyle: TextStyle(color: Colors.white),
        child: new Row(
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(this._weather.location,
                    style: new TextStyle(fontSize: 15.0, color: Colors.white70)),
                const SizedBox(height: 20.0,),
                new Text("Today, ${DateFormat('MMMM d').format(DateTime.now())}",
                    style: new TextStyle(fontSize: 15.0)),
                new Text(this._weather.temperature,
                    style: new TextStyle(fontSize: 35.0)),
                new Text(this._weather.condition.description),
              ],
            )
          ],
        ),
      ),
    );
  }
}
