import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as g;
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:smart_bin/listfolder/lists.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// dashboard
class DbThree extends StatefulWidget {
  const DbThree({super.key});

  @override
  State<DbThree> createState() => _DbThreeState();
}

class _DbThreeState extends State<DbThree> {
  final databaseReference = FirebaseDatabase.instance.ref();
  String pickData = '';

  void pickupStatus() async {
    try {
      final pickSnapshot = await databaseReference
          .child('Read')
          .child('Tong3')
          .child('pick')
          .once();

      if (pickSnapshot.snapshot.value != null) {
        setState(() {
          pickData = pickSnapshot.snapshot.value.toString();
        });
      } else {
        setState(() {
          pickData =
              'Data not available'; // Or any other suitable default value
        });
      }
    } catch (e) {
      setState(() {
        pickData = 'Failed to fetch data';
      });
    }
  }

  Future<void> loadChart3Data() async {
    String jsonString = await getJsonForChart3();
    final jsonResponse = json.decode(jsonString);

    // Ensure there are at least 5 data points before truncating
    if (jsonResponse.length >= 5) {
      chart3Data.clear(); // Clear the existing chart data
      for (int i = jsonResponse.length - 5; i < jsonResponse.length; i++) {
        chart3Data.add(Chart3Data.fromJson(jsonResponse[i]));
      }
    } else {
      // If there are less than 5 data points, load all available data
      setState(() {
        chart3Data.clear();
        for (Map<String, dynamic> i in jsonResponse) {
          chart3Data.add(Chart3Data.fromJson(i));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pickupStatus();
    loadChart3Data();
  }

  @override
  Widget build(BuildContext context) {
    // capacityRef untuk mengambil data kapasitas dari database
    final capacityRef = databaseReference
        .child('Read')
        .child('Tong3')
        .child('capacity3')
        .onValue;
    // weightRef untuk mengambil data berat dari database
    final weightRef =
        databaseReference.child('Read').child('Tong3').child('weight3').onValue;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset(
          'image/trashlogo.png',
        ),
        title: const Text(
          'Bin 3 Dashboard',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 66, 66, 66).withOpacity(0.2),
      ),
      backgroundColor: Colors.black.withOpacity(0.9),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Pickup Status: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Work',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    pickData,
                    style: TextStyle(
                      fontSize: 18,
                      color: pickData == 'Ready for pickup'
                          ? const Color.fromARGB(255, 105, 190, 108)
                          : const Color.fromARGB(255, 206, 107, 107),
                      fontFamily: 'Work',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Realtime monitoring:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Work',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                    height: 200,
                    // StreamBuilder untuk mengambil data kapasitas dari database melalui stream capacityRef secara realtime
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 160,
                          child: StreamBuilder<DatabaseEvent>(
                            stream: capacityRef,
                            builder: (context, snapshot) {
                              //Jika data sudah didapat maka akan ditampilkan sebuah gauge
                              if (snapshot.hasData) {
                                final capacity =
                                    snapshot.data!.snapshot.value as int;
                                final val = capacity.toDouble();
                                return g.SfRadialGauge(
                                  enableLoadingAnimation: true,
                                  animationDuration: 2000,
                                  axes: <g.RadialAxis>[
                                    g.RadialAxis(
                                        showLabels: false,
                                        showTicks: false,
                                        maximum: 100,
                                        radiusFactor: 0.75,
                                        interval: 1,
                                        axisLineStyle: const g.AxisLineStyle(
                                          thickness: 5,
                                          cornerStyle: g.CornerStyle.startCurve,
                                        ),
                                        pointers: <g.GaugePointer>[
                                          g.RangePointer(
                                              value: val,
                                              width: 12,
                                              pointerOffset: -8,
                                              cornerStyle:
                                                  g.CornerStyle.bothCurve,
                                              gradient: const SweepGradient(
                                                  colors: <Color>[
                                                    Color.fromARGB(
                                                        255, 173, 247, 242),
                                                    Color.fromARGB(
                                                        255, 21, 170, 255),
                                                  ],
                                                  stops: <double>[
                                                    0.10,
                                                    0.75
                                                  ])),
                                        ],
                                        annotations: <g.GaugeAnnotation>[
                                          g.GaugeAnnotation(
                                            angle: 90,
                                            widget: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Capacity',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                                Text(
                                                  ' $capacity%',
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const g.GaugeAnnotation(
                                            angle: 120,
                                            positionFactor: 1.19,
                                            widget: Text(
                                              '0',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 249, 248, 248),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                          const g.GaugeAnnotation(
                                            angle: 68,
                                            positionFactor: 1.1,
                                            widget: Text(
                                              '100',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 249, 248, 248),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ])
                                  ],
                                );
                              }
                              // jika error saat mengambil data dari database maka akan ditampilkan text error
                              else if (snapshot.hasError) {
                                return const Text('Error');
                              }
                              // jika data belum didapat maka akan ditampilkan sebuah loading indicator
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          height: 160,
                          child: StreamBuilder<DatabaseEvent>(
                            stream: weightRef,
                            builder: (context, snapshot) {
                              //Jika data sudah didapat maka akan ditampilkan sebuah gauge
                              if (snapshot.hasData) {
                                final weight =
                                    snapshot.data!.snapshot.value as int;
                                final val1 = weight.toDouble();
                                return g.SfRadialGauge(
                                  enableLoadingAnimation: true,
                                  animationDuration: 2000,
                                  axes: <g.RadialAxis>[
                                    g.RadialAxis(
                                        showLabels: false,
                                        showTicks: false,
                                        maximum: 2000,
                                        radiusFactor: 0.75,
                                        interval: 1,
                                        axisLineStyle: const g.AxisLineStyle(
                                          thickness: 5,
                                          cornerStyle: g.CornerStyle.startCurve,
                                        ),
                                        pointers: <g.GaugePointer>[
                                          g.RangePointer(
                                              value: val1,
                                              width: 12,
                                              pointerOffset: -8,
                                              cornerStyle:
                                                  g.CornerStyle.bothCurve,
                                              gradient: const SweepGradient(
                                                  colors: <Color>[
                                                    Color.fromARGB(
                                                        255, 173, 247, 242),
                                                    Color.fromARGB(
                                                        255, 21, 170, 255),
                                                  ],
                                                  stops: <double>[
                                                    0.10,
                                                    0.75
                                                  ])),
                                        ],
                                        annotations: <g.GaugeAnnotation>[
                                          g.GaugeAnnotation(
                                            angle: 90,
                                            widget: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Weight',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                                Text(
                                                  '$weight g',
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const g.GaugeAnnotation(
                                            angle: 120,
                                            positionFactor: 1.19,
                                            widget: Text(
                                              '0',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 249, 248, 248),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                          const g.GaugeAnnotation(
                                            angle: 68,
                                            positionFactor: 1.1,
                                            widget: Text(
                                              '2000',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 249, 248, 248),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ])
                                  ],
                                );
                              }
                              // jika error saat mengambil data dari database maka akan ditampilkan text error
                              else if (snapshot.hasError) {
                                return const Text('Error');
                              }
                              // jika data belum didapat maka akan ditampilkan sebuah loading indicator
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                            },
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Bin capacity in last 5 days:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Work',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 250,
                width: 350,
                // futurebuilder akan menampilkan chart SfCartesianChart apabila data sudah selesai diambil dari json
                child: FutureBuilder(
                    future: getJsonForChart3(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            tooltipBehavior: TooltipBehavior(enable: true),
                            primaryXAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Nunito',
                              ),
                              labelAlignment: LabelAlignment.center,
                              interval: 1,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              labelFormat: '{value}%',
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Nunito',
                              ),
                              minimum: 0,
                              maximum: 100,
                              interval: 25,
                              majorTickLines: const MajorTickLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries<Chart3Data, String>>[
                              LineSeries<Chart3Data, String>(
                                  name: 'Capacity',
                                  animationDuration: 2500,
                                  dataSource: chart3Data,
                                  xValueMapper: (Chart3Data cap, _) => cap.day,
                                  yValueMapper: (Chart3Data cap, _) =>
                                      cap.fullness,
                                  color:
                                      const Color.fromARGB(255, 21, 170, 255),
                                  markerSettings: const MarkerSettings(
                                    isVisible: true,
                                    color: Colors.white,
                                  ))
                            ]);
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                    }),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Bin Weight in last 5 days:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Work',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 250,
                width: 350,
                // futurebuilder akan menampilkan chart SfCartesianChart apabila data sudah selesai diambil dari json
                child: FutureBuilder(
                    future: getJsonForChart3(),
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        return SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            tooltipBehavior: TooltipBehavior(enable: true),
                            primaryXAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Nunito',
                              ),
                              labelAlignment: LabelAlignment.center,
                              interval: 1,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              labelFormat: '{value}g',
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: 'Nunito',
                              ),
                              minimum: 0,
                              maximum: 5000,
                              interval: 1000,
                              majorTickLines: const MajorTickLines(
                                  color: Colors.transparent),
                            ),
                            series: <ChartSeries<Chart3Data, String>>[
                              LineSeries<Chart3Data, String>(
                                  name: 'Weight',
                                  animationDuration: 2500,
                                  dataSource: chart3Data,
                                  xValueMapper: (Chart3Data cap, _) => cap.day,
                                  yValueMapper: (Chart3Data cap, _) =>
                                      cap.weight,
                                  color:
                                      const Color.fromARGB(255, 173, 247, 242),
                                  markerSettings: const MarkerSettings(
                                    isVisible: true,
                                    color: Colors.white,
                                  ))
                            ]);
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
