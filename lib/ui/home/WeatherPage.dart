import 'package:flutter/material.dart';
import 'package:flutter_weather/ui/home/WeatherWidget.dart';
import 'ForecastList.dart';

import 'package:flutter_weather/ui/settings/SettingsPage.dart';

class WeatherPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weather Forecast"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.settings),
            color: Colors.white,
            onPressed: () { _launchSettingsPage(context); }
          )
        ]
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

  void _launchSettingsPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }
}