import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/location.dart';

class ForecastService {
  final WeatherApi weatherApi;
  ForecastService(this.weatherApi);

  Future<Forecast> getWeatherfromCity(String city) async {
    final location = await weatherApi.getLocation(city);
    return await weatherApi.getWeather(location);
  }

  Future<Forecast> getWeatherFromLocation(Location location) async {
    return await weatherApi.getWeather(location);
  }
}
