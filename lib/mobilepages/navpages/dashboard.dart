import 'package:flutter/material.dart';
import 'package:smart_bin/listfolder/lists.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
          itemCount: dBbinNum.length,
          itemBuilder: (context, index) {
            final BoxDecoration decoration = BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: gradientColors[index],
            );

            final String number = dBbinNum[index];

            // Use the fetched data here
            String? capacity;
            if (index == 0) {
              capacity = capacity1;
            } else if (index == 1) {
              capacity = capacity2;
            } else if (index == 2) {
              capacity = capacity3;
            }

            String? weight;
            if (index == 0) {
              weight = weight1;
            } else if (index == 1) {
              weight = weight2;
            } else if (index == 2) {
              weight = weight3;
            }

            String? type;
            if (index == 0) {
              type = type1;
            } else if (index == 1) {
              type = type2;
            } else if (index == 2) {
              type = type3;
            }

            Widget dashboards = dbPages[index];

            return Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => dashboards,
                      ));
                },
                child: Container(
                  height: 122,
                  decoration: decoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 25),
                            child: SizedBox(
                              width: 200,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  number,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    fontFamily: 'Work',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: SizedBox(
                              height: 30,
                              width: 200,
                              child: Row(
                                children: [
                                  Image.asset('image/bin.png'),
                                  FutureBuilder(
                                    future:
                                        fetchDataFuture, // Use the same future
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            '$capacity %',
                                            style: const TextStyle(
                                                fontFamily: 'Work',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
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
                                  const SizedBox(width: 20),
                                  Image.asset('image/weight.png'),
                                  FutureBuilder(
                                    future:
                                        fetchDataFuture, // Use the same future
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            '$weight g',
                                            style: const TextStyle(
                                                fontFamily: 'Work',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
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
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 120,
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
                                              fontFamily: 'Work',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
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
