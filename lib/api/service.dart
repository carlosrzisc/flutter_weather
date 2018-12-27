import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_weather/model/weather.dart';
import 'package:flutter_weather/model/forecast.dart';
import 'package:flutter_weather/utils/preferences.dart';

class Api {
  // Create a singleton for the API client service
  static Api _instance;
  static Api getInstance() {
    if (_instance == null) {
      _instance = new Api();
    }
    return _instance;
  }

  // Endpoints definition from the openweathermap API
  static final String _apiKey = "<set-your-own-api-key>";
  static final String _baseUrl = "http://api.openweathermap.org/data/2.5";
  static final String _weatherEndpoint = "$_baseUrl/weather?units=metric&APPID=$_apiKey&";
  static final String _forecastEndpoint = "$_baseUrl/forecast?units=metric&APPID=$_apiKey&";

  /// Make a request to the "weather" endpoint
  Future<Weather> getWeather() async {
    final String location = await Preferences.getInstance().getLocationQuery();
    final String weatherEndpoint = _weatherEndpoint + location;
    http.Response response = await http.get(
        Uri.encodeFull(weatherEndpoint), headers: { "Accept" : "application/json" }
    );
    return Weather.deserialize(response.body);
  }

  /// Make a request to the "forecast" endpoint
  Future<ForecastData> getForecast() async {
    final String location = await Preferences.getInstance().getLocationQuery();
    final String forecastEndpoint = _forecastEndpoint + location;
    http.Response response = await http.get(
        Uri.encodeFull(forecastEndpoint), headers: { "Accept": "application/json" }
    );
    return ForecastData.deserialize(response.body);
  }
}