import 'package:flutter/material.dart';

class StatisticChart extends StatelessWidget {
  const StatisticChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of linear gradients
    final List<LinearGradient> gradientColors = [
      const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 173, 247, 242),
          Color.fromARGB(255, 21, 170, 255),
        ],
        stops: <double>[0.1, 1.0],
      ),
      const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 173, 247, 242),
          Color.fromARGB(255, 21, 170, 255),
        ],
        stops: <double>[0.1, 1.0],
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: gradientColors.length,
        itemBuilder: (context, index) {
          // Create a BoxDecoration with a gradient
          final BoxDecoration decoration = BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: gradientColors[index], // Use the gradient from the list
          );

          return Container(
            width: 20,
            height: 100, // Adjust the height as needed
            margin: const EdgeInsets.all(8.0),
            decoration: decoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'StatisticChart $index',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
