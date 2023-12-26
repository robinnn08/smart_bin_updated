import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as g;
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:smart_bin/listfolder/list_n_request.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// dashboard
class DbThree extends StatefulWidget {
  const DbThree({super.key});

  @override
  State<DbThree> createState() => _DbThreeState();
}

class _DbThreeState extends State<DbThree> {
  final databaseReference = FirebaseDatabase.instance.ref();
  String pickData = '';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize notification settings
  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Function to show a local notification
  Future<void> showNotification() async {
    print('Showing notification...');
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '2',
      'bin3',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: '@mipmap/frieren',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/trashlogo'),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Show the notification
    await flutterLocalNotificationsPlugin.show(
      2,
      'Bin Alert',
      'Bin 3 is almost full. Please check it out!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  void pickupStatus() async {
    try {
      final pickSnapshot =
          await databaseReference.child('Read/Tong3/pick').once();

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

    setState(() {
      chart3Data.clear();
      for (Map<String, dynamic> i in jsonResponse) {
        chart3Data.add(Chart3Data.fromJson(i));
      }
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      loadChart3Data();
      pickupStatus();
    });
  }

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    pickupStatus();
    loadChart3Data();
  }

  @override
  Widget build(BuildContext context) {
    // capacityRef untuk mengambil data kapasitas dari database
    final capacityRef = databaseReference.child('Read/Tong3/capacity3').onValue;
    // weightRef untuk mengambil data berat dari database
    final weightRef = databaseReference.child('Read/Tong3/weight3').onValue;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(
          Icons.auto_graph_sharp,
          color: Colors.white,
        ),
        title: const Text(
          'Bin 3 Dashboard',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Work',
              fontSize: 20,
              fontWeight: FontWeight.w700),
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
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SafeArea(
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
                            width: 155,
                            height: 160,
                            child: StreamBuilder<DatabaseEvent>(
                              stream: capacityRef,
                              builder: (context, snapshot) {
                                //Jika data sudah didapat maka akan ditampilkan sebuah gauge
                                if (snapshot.hasData) {
                                  final cap3 =
                                      snapshot.data!.snapshot.value as int;
                                  final val = cap3.toDouble();
                                  if (cap3 >= 95) {
                                    showNotification();
                                  }
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
                                            cornerStyle:
                                                g.CornerStyle.startCurve,
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
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                                  ),
                                                  Text(
                                                    ' $cap3%',
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
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
                            width: 155,
                            height: 160,
                            child: StreamBuilder<DatabaseEvent>(
                              stream: weightRef,
                              builder: (context, snapshot) {
                                //Jika data sudah didapat maka akan ditampilkan sebuah gauge
                                if (snapshot.hasData) {
                                  final weight3 =
                                      snapshot.data!.snapshot.value as dynamic;
                                  final w3 = weight3.toDouble();
                                  return g.SfRadialGauge(
                                    enableLoadingAnimation: true,
                                    animationDuration: 2000,
                                    axes: <g.RadialAxis>[
                                      g.RadialAxis(
                                          showLabels: false,
                                          showTicks: false,
                                          maximum: 15.00,
                                          radiusFactor: 0.75,
                                          interval: 1,
                                          axisLineStyle: const g.AxisLineStyle(
                                            thickness: 5,
                                            cornerStyle:
                                                g.CornerStyle.startCurve,
                                          ),
                                          pointers: <g.GaugePointer>[
                                            g.RangePointer(
                                                value: w3,
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
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                                  ),
                                                  Text(
                                                    '$w3 kg',
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
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
                                                '15',
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
                      'Bin Capacity Hourly Statistics',
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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 250,
                      width: 350,
                      // futurebuilder akan menampilkan chart SfCartesianChart apabila data sudah selesai diambil dari json
                      child: FutureBuilder(
                          future: getJsonForChart3(),
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              return SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  tooltipBehavior: TooltipBehavior(
                                    borderColor: Colors.white,
                                    borderWidth: 1,
                                    color:
                                        const Color.fromARGB(255, 40, 40, 40),
                                    enable: true,
                                    builder: (dynamic data,
                                        dynamic point,
                                        dynamic series,
                                        int pointIndex,
                                        int seriesIndex) {
                                      String xValue =
                                          chart3Data[pointIndex].timestamp;
                                      String yValue = chart3Data[pointIndex]
                                          .percentage
                                          .toString();
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('$xValue, $yValue%',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Work',
                                                fontSize: 13)),
                                      );
                                    },
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: 'Nunito',
                                    ),
                                    labelAlignment: LabelAlignment.center,
                                    interval: 1,
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
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
                                        xValueMapper: (Chart3Data cap, _) =>
                                            cap.timestamp.substring(18, 23),
                                        yValueMapper: (Chart3Data cap, _) =>
                                            cap.percentage,
                                        color: const Color.fromARGB(
                                            255, 21, 170, 255),
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
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Bin Weight Hourly Statistics',
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
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 250,
                      width: 350,
                      // futurebuilder akan menampilkan chart SfCartesianChart apabila data sudah selesai diambil dari json
                      child: FutureBuilder(
                          future: getJsonForChart3(),
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              return SfCartesianChart(
                                  plotAreaBorderWidth: 0,
                                  tooltipBehavior: TooltipBehavior(
                                    borderColor: Colors.white,
                                    borderWidth: 1,
                                    color:
                                        const Color.fromARGB(255, 40, 40, 40),
                                    enable: true,
                                    builder: (dynamic data,
                                        dynamic point,
                                        dynamic series,
                                        int pointIndex,
                                        int seriesIndex) {
                                      String xValue =
                                          chart3Data[pointIndex].timestamp;
                                      String yValue = chart3Data[pointIndex]
                                          .weight
                                          .toString();
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('$xValue, $yValue kg',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Work',
                                                fontSize: 13)),
                                      );
                                    },
                                  ),
                                  primaryXAxis: CategoryAxis(
                                    labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: 'Nunito',
                                    ),
                                    labelAlignment: LabelAlignment.center,
                                    interval: 1,
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                  ),
                                  primaryYAxis: NumericAxis(
                                    axisLine: const AxisLine(width: 0),
                                    labelFormat: '{value}kg',
                                    labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: 'Nunito',
                                    ),
                                    minimum: 0,
                                    maximum: 15,
                                    interval: 3,
                                    majorTickLines: const MajorTickLines(
                                        color: Colors.transparent),
                                  ),
                                  series: <ChartSeries<Chart3Data, String>>[
                                    LineSeries<Chart3Data, String>(
                                        name: 'Weight',
                                        animationDuration: 2500,
                                        dataSource: chart3Data,
                                        xValueMapper: (Chart3Data cap, _) =>
                                            cap.timestamp.substring(18, 23),
                                        yValueMapper: (Chart3Data cap, _) =>
                                            cap.weight,
                                        color: const Color.fromARGB(
                                            255, 173, 247, 242),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
