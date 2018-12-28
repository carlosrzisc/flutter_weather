import 'package:test/test.dart';
import 'package:flutter_weather/utils/preferences.dart';

void main() {
  test('Test the latitude is correctly parsed from query', () {
    final String query = "lat=21.879610&lon=-102.295227";
    final latitude = Preferences.getInstance().parseLatitude(query);
    expect(latitude, "21.879610");
  });

  test('Test the longitude is correctly parsed from query', () {
    final String query = "lat=21.879610&lon=-102.295227";
    final longitude = Preferences.getInstance().parseLongitude(query);
    expect(longitude, "-102.295227");
  });

  test('Test the city is correctly parsed from query', () {
    final String query = "q=Reykjavik";
    final locationName = Preferences.getInstance().parseCity(query);
    expect(locationName, "Reykjavik");
  });
}