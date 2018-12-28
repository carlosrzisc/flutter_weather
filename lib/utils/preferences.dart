import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_weather/model/weather.dart';
import 'package:flutter_weather/model/forecast.dart';

/// Utility class to manage the Shared preferences.
class Preferences {
  static final String _kLocation = "location_key";
  static final String _kLocationQuery = "location_query_key";
  static final String _kCacheWeatherData = "cache_weather_key";
  static final String _kCacheForecastData = "cache_forecast_key";
  static final String _kExpiration = "exp_key";

  static final int twelveHours = 3600 * 1000 * 12;

  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  // Create a singleton for the SharedPreferences
  static Preferences _instance;
  static Preferences getInstance() {
    if (_instance == null) {
      _instance = new Preferences();
    }
    return _instance;
  }

  /// Gets the location preference from the shared preferences
  Future<int> getLocationPreference() async {
    final SharedPreferences preferences = await _preferences;
    return preferences.get(_kLocation);
  }

  /// Sets the location preference and store it in the shared preferences
  Future<bool> setLocationPreference(int value) async {
    final SharedPreferences preferences = await _preferences;
    return preferences.setInt(_kLocation, value);
  }

  /// Gets the location query preference from the shared preferences to be passed
  /// to the openweathermap.org API
  Future<String> getLocationQuery() async {
    final SharedPreferences preferences = await _preferences;
    return preferences.get(_kLocationQuery);
  }

  /// Sets the location query preference and store it in the shared preferences
  Future<bool> setLocationQuery(String value) async {
    final SharedPreferences preferences = await _preferences;
    return preferences.setString(_kLocationQuery, value);
  }

  /// Parses the latitude value from the query parameter passed to the API
  /// [query] parameter has a value like "lat=21.879610&lon=-102.295227"
  String parseLatitude(String query) {
    final int endIndex = query.indexOf("&");
    if (endIndex != -1) {
      return query.substring(4, endIndex);
    }
    return "";
  }

  /// Parses the longitude value from the query parameter passed to the API
  /// [query] parameter has a value like "lat=21.879610&lon=-102.295227"
  String parseLongitude(String query) {
    final int startIndex = query.indexOf("lon=") + 4;
    if (startIndex != -1) {
      return query.substring(startIndex);
    }
    return "";
  }

  /// Parses the location name value from the query parameter passed to the API
  /// [query] parameter has a value like "q=Aguascalientes"
  String parseCity(String query) {
    final int startIndex = query.indexOf("q=") + 2;
    if (startIndex != -1) {
      return query.substring(startIndex);
    }
    return "";
  }

  /// Caches the server response from the API and store it in a shared preference
  /// as well as the expiration time which is 12 hours from the current timestamp.
  Future<bool> cacheWeatherData(String data) async {
    final SharedPreferences preferences = await _preferences;
    preferences.setInt(_kExpiration, DateTime.now().millisecondsSinceEpoch + twelveHours);
    return preferences.setString(_kCacheWeatherData, data);
  }

  /// Returns the weather json data stored in the shared preference, or *null*
  /// if the cache has expired.
  Future<Weather> getWeatherFromCache() async {
    final SharedPreferences preferences = await _preferences;
    final int expiration = preferences.get(_kExpiration) ?? null;
    if (expiration == null || expiration < DateTime.now().millisecondsSinceEpoch) {
      preferences.remove(_kExpiration);
      preferences.remove(_kCacheWeatherData);
    }
    return Weather.deserialize(preferences.get(_kCacheWeatherData));
  }

  /// Caches the server response from the API and store it in a shared preference
  /// as well as the expiration time which is 12 hours from the current timestamp.
  Future<bool> cacheForecastData(String data) async {
    final SharedPreferences preferences = await _preferences;
    preferences.setInt(_kExpiration, DateTime.now().millisecondsSinceEpoch + twelveHours);
    return preferences.setString(_kCacheForecastData, data);
  }

  /// Returns the forecast json data stored in the shared preference, or *null*
  /// if the cache has expired.
  Future<ForecastData> getForecastFromCache() async {
    final SharedPreferences preferences = await _preferences;
    final int expiration = preferences.get(_kExpiration) ?? null;
    if (expiration == null || expiration < DateTime.now().millisecondsSinceEpoch) {
      preferences.remove(_kExpiration);
      preferences.remove(_kCacheForecastData);
    }
    return ForecastData.deserialize(preferences.get(_kCacheForecastData));
  }
}