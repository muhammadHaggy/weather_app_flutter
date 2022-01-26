import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/api/openweathermap_weather_api.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/forecast_service.dart';
import 'package:weather_app/utils/strings.dart';
import 'package:weather_app/utils/temperature_convert.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = true;
  bool isWeatherLoaded = false;
  bool isRequestError = false;

  WeatherCondition _condition = WeatherCondition.atmosphere;
  late String _description;
  late double _minTemp;
  late double _temp;
  late double _maxTemp;
  late double _feelsLike;
  late int _locationId;
  late DateTime _lastUpdated;
  late String _city;
  late double _latitude;
  late double _longitude;
  late List<Weather> _daily;
  bool _isDayTime = true;

  WeatherCondition get condition => _condition;
  String get description => _description;
  double get minTemp => _minTemp;
  double get maxTemp => _maxTemp;
  double get temp => _temp;
  double get feelsLike => _feelsLike;
  int get locationId => _locationId;
  DateTime get lastUpdated => _lastUpdated;
  String get city => _city;
  double get longitude => _longitude;
  double get latitide => _latitude;
  bool get isDaytime => _isDayTime;
  List<Weather> get daily => _daily;

  late ForecastService forecastService;

  ForecastViewModel() {
    forecastService = ForecastService(OpenWeatherMapWeatherApi());
  }

  Future<Forecast?> getLatestWeather(String city) async {
    setRequestPendingState(true);
    isRequestError = false;

    late Forecast latest;
    try {
      await Future.delayed(Duration(seconds: 1), () => {});

      latest = await forecastService
          .getWeather(city)
          .catchError((onError) => isRequestError = true);
    } catch (e) {
      isRequestError = true;
    }
    if (!isRequestError) {
      isWeatherLoaded = true;
      updateModel(latest, city);

      setRequestPendingState(false);
      notifyListeners();
      return latest;
    }
    notifyListeners();
  }

  void setRequestPendingState(bool isPending) {
    isRequestPending = isPending;
    notifyListeners();
  }

  void updateModel(Forecast forecast, String city) {
    if (isRequestError) return;

    _condition = forecast.current.condition;
    _city = Strings.toTitleCase(forecast.city);
    _description = Strings.toTitleCase(forecast.current.description);
    _lastUpdated = forecast.lastUpdated;
    _temp = TemperatureConvert.kelvinToCelsius(forecast.current.temp);
    _feelsLike =
        TemperatureConvert.kelvinToCelsius(forecast.current.feelLikeTemp);
    _longitude = forecast.longitude;
    _latitude = forecast.latitude;
    _daily = forecast.daily;
    _isDayTime = forecast.isDayTime;
  }
}
