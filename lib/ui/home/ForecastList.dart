import 'package:flutter/material.dart';
import 'package:flutter_weather/api/service.dart';
import 'package:flutter_weather/model/forecast.dart';
import 'package:flutter_weather/ui/details/ForecastDetails.dart';

import 'package:intl/intl.dart';

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
    Api.getInstance()
        .getForecast()
        .then((content) => this.setState(() {
              this._forecastData = content;
            }))
        .catchError((e) => this.setState(() {
              print(e);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            new _ForecastListItem(_forecastData.forecastList[index]),
        itemCount:
            _forecastData == null ? 0 : _forecastData.forecastList.length);
  }
}

class _ForecastListItem extends StatelessWidget {
  final ForecastWeather weather;

  _ForecastListItem(this.weather);

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new InkWell(
      onTap: () => _launchDetailsPage(context, weather),
      child: new Container(
          padding: new EdgeInsets.all(12.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Container(
                        child: new Image.asset(
                          weather.condition.getAssetString(),
                          height: 42.0,
                          width: 42.0,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                  new Text(DateFormat('EEEE, MMM d').format(weather.dateTime)),
                  new Text(weather.temperature,
                      style: new TextStyle(fontSize: 18.0)),
                ],
              )
            ],
          )),
    ));
  }

  void _launchDetailsPage(BuildContext context, ForecastWeather weather) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailsPage(weather)));
  }
}
