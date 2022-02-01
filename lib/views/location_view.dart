import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final double longitude;
  final double latitude;
  final String city;

  const LocationView(
      {required this.longitude, required this.latitude, required this.city});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(city.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 15),
            const SizedBox(width: 10),
            Text(longitude.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
            const Text(' , ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
            Text(latitude.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
          ],
        )
      ]),
    );
  }
}
