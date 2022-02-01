import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isdayTime;

  const WeatherSummary(
      {required this.condition,
      required this.temp,
      required this.feelsLike,
      required this.isdayTime});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Text(
              '${_formatTemperature(temp)}°ᶜ',
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${_formatTemperature(feelsLike)}°ᶜ',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        _mapWeatherConditionToImage(condition, isdayTime),
      ]),
    );
  }

  String _formatTemperature(double? t) {
    var temp = (t == null ? '' : t.round().toString());
    return temp;
  }

  Widget _mapWeatherConditionToImage(
      WeatherCondition condition, bool isDayTime) {
    String asset;
    Widget svgIcon;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        asset = 'assets/images/thunder.svg';
        break;
      case WeatherCondition.heavyCloud:
        asset = 'assets/images/cloudy.svg';
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? asset = 'assets/images/cloudy-day-2.svg'
            : asset = 'assets/images/cloudy-night-2.svg';
        break;
      case WeatherCondition.drizzle:
        asset = 'assets/images/rainy-4.svg';
        break;
      case WeatherCondition.mist:
        asset = 'assets/images/cloudy.svg';
        break;
      case WeatherCondition.clear:
        isDayTime
            ? asset = 'assets/images/day.svg'
            : asset = 'assets/images/night.svg';
        break;
      case WeatherCondition.fog:
        asset = 'assets/images/cloudy.svg';
        break;
      case WeatherCondition.snow:
        asset = 'assets/images/snowy-6.svg';
        break;
      case WeatherCondition.rain:
        asset = 'assets/images/rainy-7.svg';
        break;
      case WeatherCondition.atmosphere:
        asset = 'assets/images/cloudy.svg';
        break;

      default:
        asset = 'assets/images/weather.svg';
    }
    svgIcon = SvgPicture.asset(
      asset,
      fit: BoxFit.contain,
      width: 125,
    );
    return Padding(padding: const EdgeInsets.only(top: 5), child: svgIcon);
  }
}
