import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_bin/dashboards/db1.dart';
import 'package:smart_bin/dashboards/db2.dart';
import 'package:smart_bin/dashboards/db3.dart';
import 'package:smart_bin/datalogs/dL1.dart';
import 'package:smart_bin/datalogs/dl2.dart';
import 'package:smart_bin/datalogs/dl3.dart';
import 'package:firebase_database/firebase_database.dart';

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
String binCount = '';
String binFull = '';
String recycleCount = '';
String recycleFull = '';
String organicCount = '';
String organicFull = '';
String plasticCount = '';
String plasticFull = '';

final List<String> dBbinNum = [
  'Dashboard - Bin 1',
  'Dashboard - Bin 2',
  'Dashboard - Bin 3',
];

Future<void> fetchData() async {
  // User? user = FirebaseAuth.instance.currentUser;
  final rtdbref = FirebaseDatabase.instance.ref();
  final w1Ref = rtdbref.child('Read').child('Tong1').child('weight1');
  final w2Ref = rtdbref.child('Read').child('Tong2').child('weight2');
  final w3Ref = rtdbref.child('Read').child('Tong3').child('weight3');
  final c1Ref = rtdbref.child('Read').child('Tong1').child('capacity1');
  final c2Ref = rtdbref.child('Read').child('Tong2').child('capacity2');
  final c3Ref = rtdbref.child('Read').child('Tong3').child('capacity3');
  final t1Ref = rtdbref.child('Read').child('Tong1').child('type');
  final t2Ref = rtdbref.child('Read').child('Tong2').child('type');
  final t3Ref = rtdbref.child('Read').child('Tong3').child('type');
  final binCt = rtdbref.child('Counter').child('bins');
  final fullBin = rtdbref.child('Counter').child('full');
  final recycleCt = rtdbref.child('Counter').child('recycle');
  final fullRec = rtdbref.child('Counter').child('fullrec');
  final organicCt = rtdbref.child('Counter').child('organic');
  final fullOrg = rtdbref.child('Counter').child('fullorg');
  final plasticCt = rtdbref.child('Counter').child('plastic');
  final fullPls = rtdbref.child('Counter').child('fullpls');

  w1Ref.onValue.listen((DatabaseEvent event) {
    // Handle data updates here
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      weight1 = snapshot.value.toString();
    } else {
      weight1 = 'null';
    }
  });

  w2Ref.onValue.listen((DatabaseEvent event) {
    // Handle data updates here
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      weight2 = snapshot.value.toString();
    } else {
      weight2 = 'null';
    }
  });

  w3Ref.onValue.listen((DatabaseEvent event) {
    // Handle data updates here
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      weight3 = snapshot.value.toString();
    } else {
      weight3 = 'null';
    }
  });

  c1Ref.onValue.listen((DatabaseEvent event) {
    // Handle data updates here
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      capacity1 = snapshot.value.toString();
    } else {
      capacity1 = 'null';
    }
  });

  c2Ref.onValue.listen((DatabaseEvent event) {
    // Handle data updates here
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      capacity2 = snapshot.value.toString();
    } else {
      capacity2 = 'null';
    }
  });

  c3Ref.onValue.listen((DatabaseEvent event) {
    // Handle data updates here
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      capacity3 = snapshot.value.toString();
    } else {
      capacity3 = 'null';
    }
  });

  t1Ref.onValue.listen((DatabaseEvent event) {
    // Handle data updates here
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      type1 = snapshot.value.toString();
    } else {
      type1 = 'null';
    }
  });

  t2Ref.onValue.listen((DatabaseEvent event) {
    // Handle data updates here
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      type2 = snapshot.value.toString();
    } else {
      type2 = 'null';
    }
  });

  t3Ref.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      type3 = snapshot.value.toString();
    } else {
      type3 = 'null';
    }
  });

  binCt.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      binCount = snapshot.value.toString();
    } else {
      binCount = 'null';
    }
  });

  fullBin.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      binFull = snapshot.value.toString();
    } else {
      binFull = 'null';
    }
  });

  recycleCt.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      recycleCount = snapshot.value.toString();
    } else {
      recycleCount = 'null';
    }
  });

  fullRec.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      recycleFull = snapshot.value.toString();
    } else {
      recycleFull = 'null';
    }
  });

  organicCt.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      organicCount = snapshot.value.toString();
    } else {
      organicCount = 'null';
    }
  });

  fullOrg.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      organicFull = snapshot.value.toString();
    } else {
      organicFull = 'null';
    }
  });

  plasticCt.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      plasticCount = snapshot.value.toString();
    } else {
      plasticCount = 'null';
    }
  });

  fullPls.onValue.listen((DatabaseEvent event) {
    var snapshot = event.snapshot;
    if (snapshot.value != null) {
      plasticFull = snapshot.value.toString();
    } else {
      plasticFull = 'null';
    }
  });
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

class Chart1Data {
  Chart1Data(this.percentage, this.weight, this.time, this.timestamp);

  final int percentage;
  final dynamic weight;
  final String time;
  final String timestamp;

  factory Chart1Data.fromJson(Map<String, dynamic> parsedJson) {
    return Chart1Data(
      parsedJson['percentage'],
      parsedJson['weight'],
      parsedJson['time'],
      '${parsedJson['day']}, ${parsedJson['date']} | ${parsedJson['time']}',
    );
  }
}

List<Chart1Data> chart1Data = [];

// fungsi untuk request http get ke url json firebase dan mengambil data json sebagai string
Future<String> getJsonForChart1() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String? token = await user.getIdToken();
    String url =
        "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/ChartLog.json?auth=$token";
    http.Response response = await http.get(
      Uri.parse(url),
    );
    return response.body;
  } else {
    throw Exception('User is not authenticated');
  }
}

//Bin 2 chart
class Chart2Data {
  Chart2Data(this.percentage, this.weight, this.time, this.timestamp);

  final int percentage;
  final dynamic weight;
  final String time;
  final String timestamp;

  factory Chart2Data.fromJson(Map<String, dynamic> parsedJson) {
    return Chart2Data(
      parsedJson['percentage'],
      parsedJson['weight'],
      parsedJson['time'],
      '${parsedJson['day']}, ${parsedJson['date']} | ${parsedJson['time']}',
    );
  }
}

List<Chart2Data> chart2Data = [];

// fungsi untuk request http get ke url json firebase dan mengambil data json sebagai string
Future<String> getJsonForChart2() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String? token = await user.getIdToken();
    String url =
        "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/ChartLog2.json?auth=$token";
    http.Response response = await http.get(
      Uri.parse(url),
    );
    return response.body;
  } else {
    throw Exception('User is not authenticated');
  }
}

//Bin 3 chart
class Chart3Data {
  Chart3Data(this.percentage, this.weight, this.time, this.timestamp);

  final int percentage;
  final dynamic weight;
  final String time;
  final String timestamp;

  factory Chart3Data.fromJson(Map<String, dynamic> parsedJson) {
    return Chart3Data(
      parsedJson['percentage'],
      parsedJson['weight'],
      parsedJson['time'],
      '${parsedJson['day']}, ${parsedJson['date']} | ${parsedJson['time']}',
    );
  }
}

List<Chart3Data> chart3Data = [];

// fungsi untuk request http get ke url json firebase dan mengambil data json sebagai string
Future<String> getJsonForChart3() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String? token = await user.getIdToken();
    String url =
        "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/ChartLog3.json?auth=$token";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  } else {
    throw Exception('User is not authenticated');
  }
}

// Bin 1 Data Log
// http get ambil data json dari firebase dan decode ke dalam list of Log1
Future<List<Log1>> generateLogList() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String? token = await user.getIdToken();
    String url =
        "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/LogTest.json?auth=$token";
    http.Response response = await http.get(Uri.parse(url));
    var decodedLogs = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Log1> logList =
        await decodedLogs.map<Log1>((json) => Log1.fromJson(json)).toList();
    return logList;
  } else {
    throw Exception('User is not authenticated');
  }
}

// Bin 2 Data Log
// http get ambil data json dari firebase dan decode ke dalam list of Log2
Future<List<Log2>> generateLogList2() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String? token = await user.getIdToken();
    String url =
        "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/LogTest2.json?auth=$token";
    http.Response response = await http.get(Uri.parse(url));
    var decodedLogs2 = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Log2> logList2 =
        await decodedLogs2.map<Log2>((json) => Log2.fromJson(json)).toList();
    return logList2;
  } else {
    throw Exception('User is not authenticated');
  }
}

// Bin 3 Data Log
// http get ambil data json dari firebase dan decode ke dalam list of Log3
Future<List<Log3>> generateLogList3() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String? token = await user.getIdToken();
    String url =
        "https://esp-scale-default-rtdb.asia-southeast1.firebasedatabase.app/LogTest3.json?auth=$token";
    http.Response response = await http.get(Uri.parse(url));
    var decodedLogs3 = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Log3> logList3 =
        await decodedLogs3.map<Log3>((json) => Log3.fromJson(json)).toList();
    return logList3;
  } else {
    throw Exception('User is not authenticated');
  }
}

// Time Picker Popup
TimeOfDay? selectedTime1;
TimeOfDay? selectedTime2;
TimeOfDay? selectedTime3;

Future<TimeOfDay?> showMyTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  final Widget dialog = TimePickerDialog(
    initialTime: initialTime,
    initialEntryMode: TimePickerEntryMode.input,
    cancelText: 'Cancel',
    confirmText: 'Schedule',
    helpText: 'Schedule Log Time',
    errorInvalidText: 'Invalid Time',
    hourLabelText: 'Hour',
    minuteLabelText: 'Minute',
  );

  const timePickerTheme = TimePickerThemeData(
    backgroundColor: Color.fromARGB(255, 28, 28, 28),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    hourMinuteTextStyle: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: 'Work',
        color: Colors.white),
    helpTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: 'Work',
        color: Colors.white),
    dialTextStyle: TextStyle(
      fontSize: 17,
      fontFamily: 'Work',
      color: Colors.white,
    ),
  );

  return showDialog<TimeOfDay>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (BuildContext context) {
      return Theme(
        data: ThemeData.dark().copyWith(
            timePickerTheme: timePickerTheme,
            colorScheme: const ColorScheme.dark(
              primary: Colors.white,
              onPrimary: Colors.white,
              surface: Color.fromARGB(255, 27, 27, 27),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Work',
                ),
              ),
            ))),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: dialog,
        ),
      );
    },
  );
}
