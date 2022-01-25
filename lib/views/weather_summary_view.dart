import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isdayTime;

  WeatherSummary(
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
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${_formatTemperature(feelsLike)}°ᶜ',
              style: TextStyle(
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
    Widget svgIcon;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        svgIcon = SvgPicture.asset('assets/images/thunder.svg');
        break;
      case WeatherCondition.heavyCloud:
        svgIcon = SvgPicture.asset('assets/images/cloudy.svg');
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? svgIcon = SvgPicture.asset('assets/images/cloudy-day-2.svg')
            : svgIcon = SvgPicture.asset('assets/images/cloudy-night-2.svg');
        break;
      case WeatherCondition.drizzle:
        svgIcon = SvgPicture.asset('assets/images/rainy-4.svg');
        break;
      case WeatherCondition.mist:
        svgIcon = SvgPicture.asset('assets/images/cloudy.svg');
        break;
      case WeatherCondition.clear:
        isDayTime
            ? svgIcon = SvgPicture.asset('assets/images/day.svg')
            : svgIcon = SvgPicture.asset('assets/images/night.svg');
        break;
      case WeatherCondition.fog:
        svgIcon = SvgPicture.asset('assets/images/cloudy.svg');
        break;
      case WeatherCondition.snow:
        svgIcon = SvgPicture.asset('assets/images/snowy-6.svg');
        break;
      case WeatherCondition.rain:
        svgIcon = SvgPicture.asset('assets/images/rainy-7.svg');
        break;
      case WeatherCondition.atmosphere:
        svgIcon = SvgPicture.asset('assets/images/cloudy.svg');
        break;

      default:
        svgIcon = SvgPicture.asset('assets/images/weather.svg');
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: svgIcon);
  }
}
