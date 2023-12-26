import 'package:flutter/material.dart';
import 'package:smart_bin/listfolder/list_n_request.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:firebase_database/firebase_database.dart';

// class log yang digunakan untuk menampung data dari url json yang diambil dari firebase
class Log2 {
  factory Log2.fromJson(Map<String, dynamic> json) {
    return Log2(
      date: json['date'] ?? '', // jika date null, maka date = '' (empty string)
      time: json['time'] ?? '', // jika time null, maka time = '' (empty string)
      status: json['status'] ??
          '', // jika status null, maka status = '' (empty string)
      capacity: json['fullness'] ?? 0, // jika fullness null, maka capacity = 0
      weight: json['weight'] ?? 0.0,
    ); // jika weight null, maka weight = 0
  }
  Log2({
    required this.date,
    required this.time,
    required this.status,
    required this.capacity,
    required this.weight,
  });
  final String? date;
  final String? time;
  final String? status;
  final int? capacity;
  final double? weight;
}

// class LogDataGridSource sebagai sumber data untuk menampilkan data pada row2 di SfDataGrid
class LogDataGridSource extends DataGridSource {
  LogDataGridSource(this.logList2) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Log2> logList2;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Work',
          ),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Work',
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: row.getCells()[2].value == 'Available'
                ? const Color.fromARGB(255, 145, 221, 147)
                : Colors.red,
            fontFamily: 'Work',
          ),
        ),
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${row.getCells()[3].value} %',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Work',
          ),
        ),
      ),
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${row.getCells()[4].value} kg',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Work',
            ),
          ))
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  // mapping data dari logList2 (list dari class Log) ke dalam list dataGridRows
  void buildDataGridRow() {
    dataGridRows = logList2.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'date', value: dataGridRow.date),
        DataGridCell<String>(columnName: 'time', value: dataGridRow.time),
        DataGridCell<String>(columnName: 'status', value: dataGridRow.status),
        DataGridCell<int>(columnName: 'capacity', value: dataGridRow.capacity),
        DataGridCell<double>(columnName: 'weight', value: dataGridRow.weight)
      ]);
    }).toList(growable: false);
  }
}

class LogTwo extends StatefulWidget {
  const LogTwo({super.key});

  @override
  State<LogTwo> createState() => _LogTwoState();
}

class _LogTwoState extends State<LogTwo> {
  // mengambil data menggunakan fungsi generateLogList2()
  // kemudian memasukkan data tersebut ke dalam LogDataGridSource
  // untuk ditampilkan sebagai sumber data pada SfDataGrid
  Future<LogDataGridSource> getLogDataSource() async {
    var logList2 = await generateLogList2();
    return LogDataGridSource(logList2);
  }

  // list dari GridColumn yang merupakan judul dari setiap kolom pada SfDataGrid
  // setiap GridColumn memiliki columnName yang sama dengan nama property pada DataGridCell
  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'date',
          width: 100,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Date',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Work',
                ),
              ))),
      GridColumn(
          columnName: 'time',
          width: 80,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Time',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Work',
                ),
              ))),
      GridColumn(
          columnName: 'status',
          width: 95,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text(
                'Status',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Work',
                ),
              ))),
      GridColumn(
          columnName: 'capacity',
          width: 90,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text(
                'Capacity',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Work',
                ),
              ))),
      GridColumn(
          columnName: 'weight',
          width: 75,
          label: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text(
                'Weight',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Work',
                ),
              ))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final hourReference =
        FirebaseDatabase.instance.ref().child('Read/Tong2/hour');
    final minuteReference =
        FirebaseDatabase.instance.ref().child('Read/Tong2/minute');
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth;
    double containerHeight = screenHeight * 0.8;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () async {
            final TimeOfDay? time = await showMyTimePicker(
              context: context,
              initialTime: selectedTime2 ?? TimeOfDay.now(),
            );
            setState(() {
              selectedTime2 = time;
            });
            hourReference.set(selectedTime2!.hour);
            minuteReference.set(selectedTime2!.minute);
          },
          child: const Icon(
            Icons.av_timer_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Bin 2 - Log',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            if (selectedTime2 != null)
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text('Scheduled time: ${selectedTime2!.format(context)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Work',
                      fontWeight: FontWeight.w700,
                    )),
              ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  height: containerHeight,
                  width: containerWidth,
                  child: FutureBuilder(
                    future: getLogDataSource(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return snapshot.hasData
                          ? SfTheme(
                              data: SfThemeData(
                                  dataGridThemeData: SfDataGridThemeData(
                                brightness: Brightness.dark,
                                gridLineColor:
                                    const Color.fromARGB(255, 156, 156, 156),
                              )),
                              child: SfDataGrid(
                                rowHeight: 80,
                                columnWidthMode: ColumnWidthMode.fill,
                                allowPullToRefresh: true,
                                source: snapshot.data,
                                columns: getColumns(),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
