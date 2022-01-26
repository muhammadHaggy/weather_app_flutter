import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/temperature_convert.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailySummaryView extends StatelessWidget {
  final Weather weather;

  DailySummaryView({required this.weather});

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
        toBeginningOfSentenceCase(DateFormat('EEE').format(weather.date));
    final screenwidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(dayOfWeek ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
              Text(
                  "${TemperatureConvert.kelvinToCelsius(weather.temp).round().toString()}°",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                    alignment: Alignment.center,
                    child: _mapWeatherConditionToImage(weather.condition)))
          ],
        ));
  }

  Widget _mapWeatherConditionToImage(WeatherCondition condition) {
    Widget svgIcon;
    String asset;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        asset = 'assets/images/thunder.svg';
        break;
      case WeatherCondition.heavyCloud:
        asset = 'assets/images/cloudy.svg';
        break;
      case WeatherCondition.lightCloud:
        asset = 'assets/images/cloudy.svg';
        break;
      case WeatherCondition.drizzle:
        asset = 'assets/images/rainy-4.svg';
        break;
      case WeatherCondition.mist:
        asset = 'assets/images/cloudy.svg';
        break;
      case WeatherCondition.clear:
        asset = 'assets/images/day.svg';
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
      fit: BoxFit.scaleDown,
      width: 50,
    );

    return Padding(padding: const EdgeInsets.only(top: 5), child: svgIcon);
  }
}
