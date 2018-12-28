import 'package:flutter/material.dart';
import 'package:flutter_weather/utils/preferences.dart';

/// Widget that displays the settings page to let the user change the location
/// desired to get the weather.
class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _radioValue;
  var textCityController = new TextEditingController();
  var textLatitudeController = new TextEditingController();
  var textLongitudeController = new TextEditingController();
  String _city = "";
  String _latitude = "";
  String _longitude = "";

  @override
  void initState() {

    super.initState();
    Preferences.getInstance().getLocationPreference()
        .then((value) => this.setState(() {
          _switchLocationPreference(value != null? value: 0);
          if (value == null) {
            _storeLatitude("");
            _storeLongitude("");
          } else {
            Preferences.getInstance().getLocationQuery()
                .then((query) => this.setState(() {
                  if (value == 0) {
                    _setLatitudeLongitude(query);
                    textLatitudeController.text = Preferences.getInstance().parseLatitude(query);
                    textLongitudeController.text = Preferences.getInstance().parseLongitude(query);
                  } else {
                    _setCity(query);
                    textCityController.text = Preferences.getInstance().parseCity(query);;
                  }
            }));
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: new Material(
          child: new Container(
              padding: new EdgeInsets.all(20.0),
              child: new SingleChildScrollView(
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(),
                  child: Column(
                    children: <Widget>[
                      new Text('Select your preferred location by:',
                          style: new TextStyle(fontSize: 17.0)),
                      new Row(children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _switchLocationPreference,
                        ),
                        new Text('Geo location')
                      ]),
                      new Row(children: <Widget>[
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _switchLocationPreference,
                        ),
                        new Text('City')
                      ]),
                      (_radioValue == 1)? new TextField(
                          controller: textCityController,
                          onChanged: _storeCity,
                          decoration: InputDecoration(
                              labelText: 'City',
                              hintText: 'Please enter the city name')): Container(),
                      (_radioValue == 0)? new TextField(
                          controller: textLatitudeController,
                          onChanged: _storeLatitude,
                          decoration: InputDecoration(
                              labelText: 'Latitude',
                              hintText: 'Please enter the location latitude')): Container(),
                      (_radioValue == 0)? new TextField(
                          controller: textLongitudeController,
                          onChanged: _storeLongitude,
                          decoration: InputDecoration(
                              labelText: 'Longitude',
                              hintText: 'Please enter the location longitude')): Container()
                    ],
                  ),
                ),
              ))),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the Widget is removed from the Widget tree
    textCityController.dispose();
    textLongitudeController.dispose();
    textLatitudeController.dispose();
    super.dispose();
  }

  void _switchLocationPreference(int value) async {
    setState(() {
      _radioValue = value;
      Preferences.getInstance().setLocationPreference(value);
    });
  }

  void _setLatitudeLongitude(String query) async {
    setState(() {
      Preferences.getInstance().setLocationQuery(query).then((bool success) {
        _latitude = Preferences.getInstance().parseLatitude(query);
        _longitude = Preferences.getInstance().parseLatitude(query);
      });
    });
  }

  void _setCity(String query) async {
    setState(() {
      Preferences.getInstance().setLocationQuery(query).then((bool success) {
        _city = Preferences.getInstance().parseCity(query);
      });
    });
  }

  void _storeCity(String city) => _setCity("q=$city");

  void _storeLatitude(String latitude) => _setLatitudeLongitude("lat=$latitude&lon=$_longitude");

  void _storeLongitude(String longitude) => _setLatitudeLongitude("lat=$_latitude&lon=$longitude");
}
