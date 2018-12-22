import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather.dart';
import 'package:flutter_weather/api/service.dart';

class WeatherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _WeatherWidgetState();
  }
}

class _WeatherWidgetState extends State<WeatherWidget> {
  static final String loading = "Loading...";
  static final String error = "Error: could not fetch the weather data from the server";
  var _weather = new Weather("", loading);

  @override
  void initState() {
    super.initState();
    Api.getInstance().getWeather()
        .then((content) => this.setState((){ this._weather = content; }))
        .catchError((e) => this.setState(() { this._weather = new Weather("", error); }));
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(this._weather.temperature, style: new TextStyle(fontSize: 25.0)),
          new Text(this._weather.weather),
        ],
      ),
    );
  }
}