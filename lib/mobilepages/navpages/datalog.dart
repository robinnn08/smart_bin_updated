import 'package:flutter/material.dart';
import 'package:smart_bin/listfolder/list_n_request.dart';

class DataLog extends StatefulWidget {
  const DataLog({super.key});

  @override
  State<DataLog> createState() => _DataLogState();
}

class _DataLogState extends State<DataLog> {
  // Define a variable to store the fetched data
  Future<void>? fetchDataFuture;

  Future<void> _refreshData() async {
    setState(() {
      fetchDataFuture = fetchData();
    });
  }

  // Fetch the data in initState
  @override
  void initState() {
    fetchDataFuture = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: dLbinNum.length,
          itemBuilder: (context, index) {
            final BoxDecoration decoration = BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 28, 28, 28),
              border: Border.all(
                color: Color.fromARGB(255, 43, 43, 43),
                width: 1,
              ),
            );

            final String number = dLbinNum[index];

            // Use the fetched data here

            String? type;
            if (index == 0) {
              type = type1;
            } else if (index == 1) {
              type = type2;
            } else if (index == 2) {
              type = type3;
            }

            Widget datalogs = dlPages[index];

            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => datalogs,
                      ));
                },
                child: Container(
                  height: 110,
                  decoration: decoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 22),
                            child: SizedBox(
                              width: 200,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  number,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 240, 241, 245),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    fontFamily: 'Nova',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: SizedBox(
                              height: 30,
                              width: 200,
                              child: Row(
                                children: [
                                  Image.asset('image/timetable.png'),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Monitor Data',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 240, 241, 245),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      fontFamily: 'Nova',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 13),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Center(
                                child: FutureBuilder(
                                  future:
                                      fetchDataFuture, // Use the same future
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          '$type',
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 240, 241, 245),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            fontFamily: 'Nova',
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (type == 'Recycleable')
                              Image.asset('image/recycleable.png',
                                  width: 50, height: 50)
                            else if (type == 'Plastic')
                              Image.asset('image/plastic.png',
                                  width: 50, height: 50)
                            else if (type == 'Organic')
                              Image.asset('image/organic.png',
                                  width: 50, height: 50)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
