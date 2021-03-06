import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather.dart';
import 'package:flutter_weather/api/service.dart';
import 'package:flutter_weather/model/weather_condition.dart';
import 'package:flutter_weather/utils/preferences.dart';
import 'package:intl/intl.dart';

/// Widget that displays the current weather.
class WeatherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _WeatherWidgetState();
  }
}

class _WeatherWidgetState extends State<WeatherWidget> {
  static final String _error =
      "Error: could not fetch the weather data from the server";
  var _weather = new Weather(
      "", new WeatherCondition(0, "Loading..."), "", DateTime.now());
  final snackBar = SnackBar(content: Text(_error));

  @override
  void initState() {
    super.initState();
    Preferences.getInstance().getWeatherFromCache()
        .then((content) => this.setState(() { this._weather = content; }));
    Api.getInstance().getWeather()
        .then((content) => this.setState(() { this._weather = content; }))
        .catchError((e) => this.setState(() { Scaffold.of(context).showSnackBar(snackBar); }));
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Material(
          color: Colors.cyan,
          textStyle: TextStyle(color: Colors.white),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(this._weather.location,
                  style: new TextStyle(fontSize: 13.0, color: Colors.white70)),
              const SizedBox(
                height: 20.0,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      Text("${DateFormat('MMMM d').format(this._weather.dateTime)}",
                          style: new TextStyle(fontSize: 15.0)),
                      new Text(this._weather.temperature,
                          style: new TextStyle(fontSize: 35.0)),
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Container(
                        child: new Image.asset(
                          _weather.condition.getAssetString(),
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      new Text(this._weather.condition.description,
                          style: new TextStyle(fontSize: 12.0)),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
