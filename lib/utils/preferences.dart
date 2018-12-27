import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  // Create a singleton for the SharedPreferences
  static Preferences _instance;
  static Preferences getInstance() {
    if (_instance == null) {
      _instance = new Preferences();
    }
    return _instance;
  }

  static final String _kLocation = "location_key";
  /// Get the location preference from the shared preferences
  Future<int> getLocationPreference() async {
    final SharedPreferences preferences = await _preferences;
    return preferences.get(_kLocation);
  }

  /// Set the location preference and store it in the shared preferences
  Future<bool> setLocationPreference(int value) async {
    final SharedPreferences preferences = await _preferences;
    return preferences.setInt(_kLocation, value);
  }

  static final String _kLocationQuery = "location_query_key";
  /// Get the location query preference from the shared preferences to be passed
  /// to the openweathermap.org API
  Future<String> getLocationQuery() async {
    final SharedPreferences preferences = await _preferences;
    return preferences.get(_kLocationQuery);
  }
  /// Set the location query preference and store it in the shared preferences
  Future<bool> setLocationQuery(String value) async {
    final SharedPreferences preferences = await _preferences;
    return preferences.setString(_kLocationQuery, value);
  }

  String parseLatitude(String query) {
    // "lat=21.879610&lon=-102.295227"
    final int endIndex = query.indexOf("&");
    if (endIndex != -1) {
      return query.substring(4, endIndex);
    }
    return "";
  }

  String parseLongitude(String query) {
    final int startIndex = query.indexOf("lon=") + 4;
    if (startIndex != -1) {
      return query.substring(startIndex);
    }
    return "";
  }

  String parseCity(String query) {
    final int startIndex = query.indexOf("q=") + 2;
    if (startIndex != -1) {
      return query.substring(startIndex);
    }
    return "";
  }
}