import 'package:flutter/material.dart';

class NoWeatherBody extends StatelessWidget {
  const NoWeatherBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'There is no weather 😔 start',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'searching now 🔎',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
