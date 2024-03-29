import 'package:flutter/material.dart';
import 'package:weather_app/api/openweathermap_weather_api.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/forecast_service.dart';
import 'package:weather_app/viewmodels/city_entry_viewmodel.dart';

import 'package:weather_app/viewmodels/forecast_viewmodel.dart';
import 'package:weather_app/views/weather_description_view.dart';
import 'package:weather_app/views/weather_summary_view.dart';
import 'package:weather_app/views/gradient_container.dart';
import 'package:geolocator/geolocator.dart';

import 'city_entry_view.dart';
import 'daily_summary_view.dart';
import 'last_updated_view.dart';
import 'location_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> setCurrentLocationWeather(BuildContext context) async {
    // any init in here ?
    try {
      final position = await _determinePosition();
      final location =
          Location(longitude: position.longitude, latitude: position.latitude);
      Provider.of<ForecastViewModel>(context, listen: false)
          .getLatestWeatherFromLocation(location);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      setCurrentLocationWeather(context);
      return Consumer<ForecastViewModel>(builder: (context, model, child) {
        return Scaffold(
          body: _buildGradientContainer(
              model.condition, model.isDaytime, buildHomeView(context)),
        );
      });
    });
  }

  Widget buildHomeView(BuildContext context) {
    return Consumer<ForecastViewModel>(
        builder: (context, weatherViewModel, child) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
                color: Colors.transparent,
                backgroundColor: Colors.transparent,
                onRefresh: () => refreshWeather(weatherViewModel, context),
                child: ListView(
                  children: <Widget>[
                    CityEntryView(),
                    weatherViewModel.isRequestPending
                        ? buildBusyIndicator()
                        : weatherViewModel.isRequestError
                            ? const Center(
                                child: Text('Ooops...something went wrong',
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.white)))
                            : Column(children: [
                                LocationView(
                                  longitude: weatherViewModel.longitude,
                                  latitude: weatherViewModel.latitide,
                                  city: weatherViewModel.city,
                                ),
                                const SizedBox(height: 50),
                                WeatherSummary(
                                    condition: weatherViewModel.condition,
                                    temp: weatherViewModel.temp,
                                    feelsLike: weatherViewModel.feelsLike,
                                    isdayTime: weatherViewModel.isDaytime),
                                const SizedBox(height: 20),
                                WeatherDescriptionView(
                                    weatherDescription:
                                        weatherViewModel.description),
                                const SizedBox(height: 140),
                                buildDailySummary(weatherViewModel.daily),
                                LastUpdatedView(
                                    lastUpdatedOn:
                                        weatherViewModel.lastUpdated),
                              ]),
                  ],
                ))));
  }

  Widget buildBusyIndicator() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white)),
      const SizedBox(
        height: 20,
      ),
      const Text('Please Wait...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ))
    ]);
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dailyForecast
            .map((item) => DailySummaryView(
                  weather: item,
                ))
            .toList());
  }

  Future<void> refreshWeather(
      ForecastViewModel weatherVM, BuildContext context) {
    // get the current city
    String city = Provider.of<CityEntryViewModel>(context, listen: false).city;
    if (city != '') {
      return weatherVM.getLatestWeatherFromCity(city);
    }
    return setCurrentLocationWeather(context);
  }

  GradientContainer _buildGradientContainer(
      WeatherCondition condition, bool isDayTime, Widget child) {
    GradientContainer container;

    // if night time then just default to a blue/grey
    if (!isDayTime) {
      container = GradientContainer(color: Colors.blueGrey, child: child);
    } else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container = GradientContainer(color: Colors.yellow, child: child);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.atmosphere:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = GradientContainer(color: Colors.indigo, child: child);
          break;
        case WeatherCondition.snow:
          container = GradientContainer(color: Colors.lightBlue, child: child);
          break;
        case WeatherCondition.thunderstorm:
          container = GradientContainer(color: Colors.deepPurple, child: child);
          break;
        default:
          container = GradientContainer(color: Colors.lightBlue, child: child);
      }
    }

    return container;
  }
}
