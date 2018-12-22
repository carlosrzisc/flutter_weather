import 'package:flutter/material.dart';
import 'package:flutter_weather/api/service.dart';
import 'package:flutter_weather/model/forecast.dart';

class ForecastList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ForecastListState();
  }
}

class _ForecastListState extends State<ForecastList> {
  ForecastData _forecastData;

  @override
  void initState() {
    super.initState();
    Api.getInstance().getForecast()
        .then((content) => this.setState(() { this._forecastData = content; }))
        .catchError((e) => this.setState(() { print(e); }));
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          new _ForecastListItem(_forecastData.forecastList[index]),
      itemCount: _forecastData == null ? 0 : _forecastData.forecastList.length,
    );
  }
}

class _ForecastListItem extends StatelessWidget {
  final ForecastWeather weather;
  _ForecastListItem(this.weather);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new Text(weather.temperature),
              new Text(weather.description)
            ],
          )),
    );
  }
}
