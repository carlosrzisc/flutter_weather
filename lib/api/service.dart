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
  static final String apiKey = "<set-your-own-api-key>";
  static final String baseUrl = "http://api.openweathermap.org/data/2.5";
  static final String weatherEndpoint = "$baseUrl/weather?APPID=$apiKey&${getLocation()}&units=metric&cnt=7";
  static final String forecastEndpoint = "$baseUrl/forecast?APPID=$apiKey&${getLocation()}&units=metric&cnt=7";

  /// Gets the user selected location query
  static String getLocation() {
    // Temporarily hardcoding location
    // "q=Aguascalientes,MX"
    // "lat=9.846130&lon=-83.921799"
    return "lat=9.846130&lon=-83.921799";
  }

  /// Make a request to the "weather" endpoint
  Future<Weather> getWeather() async {
    http.Response response = await http.get(
        Uri.encodeFull(weatherEndpoint), headers: { "Accept" : "application/json" }
    );
    return Weather.deserialize(response.body);
  }

  /// Make a request to the "forecast" endpoint
  Future<ForecastData> getForecast() async {
    http.Response response = await http.get(
        Uri.encodeFull(forecastEndpoint), headers: { "Accept": "application/json" }
    );
    return ForecastData.deserialize(response.body);
  }
}