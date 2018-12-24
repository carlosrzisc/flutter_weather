import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_weather/model/weather.dart';
import 'package:flutter_weather/model/forecast.dart';

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
  static final String _weatherEndpoint = "$_baseUrl/weather?APPID=$_apiKey&${getLocation()}&units=metric";
  static final String _forecastEndpoint = "$_baseUrl/forecast?APPID=$_apiKey&${getLocation()}&units=metric";

  /// Gets the user selected location query
  static String getLocation() {
    // Temporarily hardcoding location
    // "q=Aguascalientes,MX"
    // "lat=21.879610&lon=-102.295227"
    return "lat=21.879610&lon=-102.295227";
  }

  /// Make a request to the "weather" endpoint
  Future<Weather> getWeather() async {
    http.Response response = await http.get(
        Uri.encodeFull(_weatherEndpoint), headers: { "Accept" : "application/json" }
    );
    return Weather.deserialize(response.body);
  }

  /// Make a request to the "forecast" endpoint
  Future<ForecastData> getForecast() async {
    http.Response response = await http.get(
        Uri.encodeFull(_forecastEndpoint), headers: { "Accept": "application/json" }
    );
    return ForecastData.deserialize(response.body);
  }
}