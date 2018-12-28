class WeatherCondition {
  int id;
  String description;

  WeatherCondition(this.id, this.description);

  // Based on weather code data found at:
  // https://openweathermap.org/weather-conditions
  String getAssetString() {
    if (id >= 200 && id <= 232)
      return "assets/img/storm.png";
    else if (id >= 300 && id <= 321)
      return "assets/img/light_rain.png";
    else if (id >= 500 && id <= 531)
      return "assets/img/rain.png";
    else if (id >= 600 && id <= 622)
      return "assets/img/snow.png";
    else if (id >= 701 && id <= 781)
      return "assets/img/fog.png";
    else if (id == 800)
      return "assets/img/clear.png";
    else if (id == 801)
      return "assets/img/light_clouds.png";
    else if (id >= 802 && id <= 804)
      return "assets/img/cloudy.png";
    return "assets/img/unknown.png";
  }
}