import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_bin/dashboards/db1.dart';
import 'package:smart_bin/dashboards/db2.dart';
import 'package:smart_bin/dashboards/db3.dart';
import 'package:smart_bin/datalogs/dL1.dart';
import 'package:smart_bin/datalogs/dl2.dart';
import 'package:smart_bin/datalogs/dl3.dart';

// Lists for Dashboard
String capacity1 = '';
String capacity2 = '';
String capacity3 = '';
String weight1 = '';
String weight2 = '';
String weight3 = '';
String type1 = '';
String type2 = '';
String type3 = '';

final List<LinearGradient> gradientColors = [
  const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 140, 146, 172),
    ],
    stops: <double>[0.01, 1.0],
  ),
  const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 140, 146, 172),
    ],
    stops: <double>[0.1, 1.0],
  ),
  const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 140, 146, 172),
    ],
    stops: <double>[0.1, 1.0],
  ),
];

final List<String> dBbinNum = [
  'Dashboard - Bin 1',
  'Dashboard - Bin 2',
  'Dashboard - Bin 3',
];

Future<void> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/Read.json'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final tong1Data = jsonData['Tong1'];
    final tong2Data = jsonData['Tong2'];
    final tong3Data = jsonData['Tong3'];
    final capacity1Value = tong1Data['capacity1'] as int;
    final capacity2Value = tong2Data['capacity2'] as int;
    final capacity3Value = tong3Data['capacity3'] as int;
    final type1Value = tong1Data['type'] as String;
    final type2Value = tong2Data['type'] as String;
    final type3Value = tong3Data['type'] as String;
    final weight1Value = tong1Data['weight1'] as int;
    final weight2Value = tong2Data['weight2'] as int;
    final weight3Value = tong3Data['weight3'] as int;

    capacity1 = capacity1Value.toString();
    capacity2 = capacity2Value.toString();
    capacity3 = capacity3Value.toString();
    weight1 = weight1Value.toString();
    weight2 = weight2Value.toString();
    weight3 = weight3Value.toString();
    type1 = type1Value;
    type2 = type2Value;
    type3 = type3Value;
  } else {
    // Handle errors here, e.g., show an error message
    capacity1 = 'Error';
    capacity2 = 'Error';
    capacity3 = 'Error';
    weight1 = 'Error';
    weight2 = 'Error';
    weight3 = 'Error';
    type1 = 'Error';
    type2 = 'Error';
    type3 = 'Error';
  }
}

final List<Widget> dbPages = [
  const DbOne(),
  const DbTwo(),
  const DbThree(),
];

//Lists for datalog
final List<String> dLbinNum = [
  'Data Log - Bin 1',
  'Data Log - Bin 2',
  'Data Log - Bin 3',
];

final List<Widget> dlPages = [
  const LogOne(),
  const LogTwo(),
  const LogThree(),
];

//Bin 1 chart
class Chart1Data {
  Chart1Data(this.fullness, this.weight, this.day);

  final String day;
  final int fullness;
  final int weight;

  factory Chart1Data.fromJson(Map<String, dynamic> parsedJson) {
    return Chart1Data(
      parsedJson['fullness'],
      parsedJson['weight'],
      parsedJson['day'].toString(),
    );
  }
}

List<Chart1Data> chart1Data = [];

// fungsi untuk request http get ke url json firebase dan mengambil data json sebagai string
Future<String> getJsonForChart1() async {
  String url =
      "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/LogTest.json";
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

//Bin 2 chart
class Chart2Data {
  Chart2Data(this.fullness, this.weight, this.day);

  final String day;
  final int fullness;
  final int weight;

  factory Chart2Data.fromJson(Map<String, dynamic> parsedJson) {
    return Chart2Data(
      parsedJson['fullness'],
      parsedJson['weight'],
      parsedJson['day'].toString(),
    );
  }
}

List<Chart2Data> chart2Data = [];

// fungsi untuk request http get ke url json firebase dan mengambil data json sebagai string
Future<String> getJsonForChart2() async {
  String url =
      "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/LogTest2.json";
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

//Bin 3 chart
class Chart3Data {
  Chart3Data(this.fullness, this.weight, this.day);

  final String day;
  final int fullness;
  final int weight;

  factory Chart3Data.fromJson(Map<String, dynamic> parsedJson) {
    return Chart3Data(
      parsedJson['fullness'],
      parsedJson['weight'],
      parsedJson['day'].toString(),
    );
  }
}

List<Chart3Data> chart3Data = [];

// fungsi untuk request http get ke url json firebase dan mengambil data json sebagai string
Future<String> getJsonForChart3() async {
  String url =
      "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/LogTest3.json";
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}
