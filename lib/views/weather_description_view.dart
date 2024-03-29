import 'package:flutter/material.dart';

class WeatherDescriptionView extends StatelessWidget {
  final String weatherDescription;

  const WeatherDescriptionView({required this.weatherDescription});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(weatherDescription,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          )),
    );
  }
}
