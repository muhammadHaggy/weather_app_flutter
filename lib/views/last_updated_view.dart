import 'package:flutter/material.dart';

class LastUpdatedView extends StatelessWidget {
  final DateTime lastUpdatedOn;

  const LastUpdatedView({required this.lastUpdatedOn});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 00),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.access_time,
            color: Colors.black45,
            size: 15,
          ),
          const SizedBox(width: 10),
          Text(
              'Last updated on ${TimeOfDay.fromDateTime(lastUpdatedOn).format(context)}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black45,
              ))
        ]));
  }
}
