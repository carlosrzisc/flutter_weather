import 'package:flutter/material.dart';
import 'package:flutter_weather/model/forecast.dart';

import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  final ForecastWeather weather;

  DetailsPage(this.weather);

  @override
  Widget build(BuildContext context) {
    print("Weather: $weather");
    return Scaffold(
        appBar: AppBar(title: Text("Weather Details")),
        body: new Material(
            color: Colors.cyan,
            textStyle: TextStyle(color: Colors.white),
            child: new Center(
                child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          new Text(
                              "${DateFormat('MMMM d').format(weather.dateTime)}",
                              style: new TextStyle(fontSize: 15.0)),
                          new Text(this.weather.temperature,
                              style: new TextStyle(fontSize: 35.0)),
                        ],
                      ),
                      new Column(
                        children: <Widget>[
                          new Container(
                            child: new Image.asset(
                              weather.condition.getAssetString(),
                              height: 80.0,
                              width: 80.0,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          new Text(this.weather.condition.description,
                              style: new TextStyle(fontSize: 12.0)),
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 60.0,
                ),
                new Divider(
                  color: Colors.white70,
                  height: 3,
                ),
                new Column(
                  children: <Widget>[
                    new Container(
                        padding: new EdgeInsets.all(15.0),
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("Humidity"),
                              new Text("${this.weather.humidity.toString()}%"),
                            ])),
                    new Divider(
                      color: Colors.white70,
                      height: 3,
                    ),
                    new Container(
                        padding: new EdgeInsets.all(15.0),
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("Pressure"),
                              new Text("${this.weather.pressure.toString()} hPa"),
                            ])),
                    new Divider(
                      color: Colors.white70,
                      height: 3,
                    ),
                    new Container(
                        padding: new EdgeInsets.all(15.0),
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("Wind"),
                              new Text("${this.weather.wind.toString()} mph"),
                            ])),
                    new Divider(
                      color: Colors.white70,
                      height: 3,
                    )
                  ],
                )
              ],
            ))));
  }
}
