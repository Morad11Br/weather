import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:weather/service/Networking.dart';
import '../service/Location.dart';

const String _APIKey = "34eedfac4a8584f4cfcf98fe20bc744a";
const openweatherMapURL = "http://api.openweathermap.org/data/2.5/forecast";

class WeatherModel {
  Future<dynamic> getCityWeather(String tapedName) async {
    var url = '$openweatherMapURL?q=$tapedName&appid=$_APIKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        "$openweatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$_APIKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  IconData getWeatherIcon(int condition) {
    if (condition <= 200) {
      return WeatherIcons.wiThunderstorm;
    } else if (condition <= 300) {
      return WeatherIcons.wiRainWind;
    } else if (condition <= 500) {
      return WeatherIcons.wiRain;
    } else if (condition <= 600) {
      return WeatherIcons.wiSnow;
    } else if (condition <= 700) {
      return WeatherIcons.wiSmoke;
    } else if (condition == 800) {
      return WeatherIcons.wiDaySunny;
    } else if (condition <= 801) {
      return WeatherIcons.wiCloudy;
    } else
      return null;
  }
}
