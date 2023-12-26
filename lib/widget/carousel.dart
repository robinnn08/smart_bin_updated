import 'package:flutter/material.dart';
import 'package:smart_bin/listfolder/list_n_request.dart';

List<Widget> carouselItems = [
  const CarouselItem1(),
  const CarouselItem2(),
  const CarouselItem3(),
  const CarouselItem4(),
];

class CarouselItem1 extends StatefulWidget {
  const CarouselItem1({super.key});

  @override
  State<CarouselItem1> createState() => _CarouselItem1State();
}

class _CarouselItem1State extends State<CarouselItem1> {
  Future<void>? fetchDataFuture;

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        width: 340.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 28, 28),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(255, 43, 43, 43),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Row(
                children: [
                  Image.asset('image/frieren.png', height: 25, width: 25),
                  const SizedBox(width: 5),
                  const Text('Quick Access',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nova',
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Divider(
                color: Color.fromARGB(255, 80, 80, 80),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2.5),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 60, 60, 60),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 43, 43, 43),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'image/dashboard.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2.5),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                            fontFamily: 'Nova',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 60, 60, 60),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 43, 43, 43),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'image/datalog.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2.5),
                      Text(
                        'Data Log',
                        style: TextStyle(
                            fontFamily: 'Nova',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 60, 60, 60),
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: const Color.fromARGB(255, 43, 43, 43),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'image/locate.png',
                              width: 50,
                              height: 50,
                            ),
                          )),
                      const SizedBox(height: 2.5),
                      Text(
                        'Locate Bins',
                        style: TextStyle(
                            fontFamily: 'Nova',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 60, 60, 60),
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: const Color.fromARGB(255, 43, 43, 43),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'image/trashlogo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2.5),
                      const Text(
                        'Trash?',
                        style: TextStyle(
                            fontFamily: 'Nova',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class CarouselItem2 extends StatefulWidget {
  const CarouselItem2({super.key});
  @override
  State<CarouselItem2> createState() => _CarouselItem2State();
}

class _CarouselItem2State extends State<CarouselItem2> {
  Future<void>? fetchDataFuture;

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 340.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 28, 28),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(255, 43, 43, 43),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Row(
                children: [
                  Image.asset('image/recycleable.png', height: 25, width: 25),
                  const SizedBox(width: 5),
                  const Text('Recycleable Waste',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nova',
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Divider(
                color: Color.fromARGB(255, 80, 80, 80),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 2.5,
              ),
              child: Container(
                width: 320,
                height: 70,
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                            future: fetchDataFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  'Ready for pickup = $recycleFull / $recycleCount',
                                  style: const TextStyle(
                                    fontFamily: 'Nova',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 253, 221, 202),
                                    fontSize: 15,
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator(
                                    color: Colors.white);
                              }
                            },
                          ),
                          SizedBox(height: 5),
                          FutureBuilder(
                            future: fetchDataFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text('Total Bin Count = $recycleCount',
                                    style: const TextStyle(
                                      fontFamily: 'Nova',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 253, 221, 202),
                                      fontSize: 15,
                                    ));
                              } else {
                                return CircularProgressIndicator(
                                    color: Colors.white);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder(
                            future: fetchDataFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (recycleFull == '0') {
                                  return Column(
                                    children: [
                                      Image.asset(
                                        'image/check.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'All clean!',
                                        style: TextStyle(
                                            fontFamily: 'Nova',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      )
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Image.asset(
                                        'image/warning.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'Some bins are full!',
                                        style: TextStyle(
                                            fontFamily: 'Nova',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      )
                                    ],
                                  );
                                }
                              } else {
                                return CircularProgressIndicator(
                                    color: Colors.white);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class CarouselItem3 extends StatefulWidget {
  const CarouselItem3({super.key});
  @override
  State<CarouselItem3> createState() => _CarouselItem3State();
}

class _CarouselItem3State extends State<CarouselItem3> {
  Future<void>? fetchDataFuture;

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 340.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 28, 28),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(255, 43, 43, 43),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Row(
                children: [
                  Image.asset('image/plastic.png', height: 25, width: 25),
                  const SizedBox(width: 5),
                  const Text('Plastic Waste',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nova',
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Divider(
                color: Color.fromARGB(255, 80, 80, 80),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 2.5,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: fetchDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text(
                                'Ready for pickup = $plasticFull / $plasticCount',
                                style: const TextStyle(
                                  fontFamily: 'Nova',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 200, 229, 255),
                                  fontSize: 15,
                                ),
                              );
                            } else {
                              return CircularProgressIndicator(
                                  color: Colors.white);
                            }
                          },
                        ),
                        SizedBox(height: 5),
                        FutureBuilder(
                          future: fetchDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text('Total Bin Count = $plasticCount',
                                  style: const TextStyle(
                                    fontFamily: 'Nova',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 200, 229, 255),
                                    fontSize: 15,
                                  ));
                            } else {
                              return CircularProgressIndicator(
                                  color: Colors.white);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: fetchDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (plasticFull == '0') {
                                return Column(
                                  children: [
                                    Image.asset(
                                      'image/check.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'All clean!',
                                      style: TextStyle(
                                          fontFamily: 'Nova',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    Image.asset(
                                      'image/warning.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Some bins are full!',
                                      style: TextStyle(
                                          fontFamily: 'Nova',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                );
                              }
                            } else {
                              return CircularProgressIndicator(
                                  color: Colors.white);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class CarouselItem4 extends StatefulWidget {
  const CarouselItem4({super.key});
  @override
  State<CarouselItem4> createState() => _CarouselItem4State();
}

class _CarouselItem4State extends State<CarouselItem4> {
  Future<void>? fetchDataFuture;

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 340.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 28, 28),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: const Color.fromARGB(255, 43, 43, 43),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Row(
                children: [
                  Image.asset('image/organic.png', height: 25, width: 25),
                  const SizedBox(width: 5),
                  const Text('Organic Waste',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Nova',
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Divider(
                color: Color.fromARGB(255, 80, 80, 80),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 2.5,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: fetchDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text(
                                'Ready for pickup = $organicFull / $organicCount',
                                style: const TextStyle(
                                  fontFamily: 'Nova',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 202, 253, 222),
                                  fontSize: 15,
                                ),
                              );
                            } else {
                              return CircularProgressIndicator(
                                  color: Colors.white);
                            }
                          },
                        ),
                        SizedBox(height: 5),
                        FutureBuilder(
                          future: fetchDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Text('Total Bin Count = $organicCount',
                                  style: const TextStyle(
                                    fontFamily: 'Nova',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 202, 253, 222),
                                    fontSize: 15,
                                  ));
                            } else {
                              return CircularProgressIndicator(
                                  color: Colors.white);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: fetchDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (organicFull == '0') {
                                return Column(
                                  children: [
                                    Image.asset(
                                      'image/check.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'All clean!',
                                      style: TextStyle(
                                          fontFamily: 'Nova',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    Image.asset(
                                      'image/warning.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Some bins are full!',
                                      style: TextStyle(
                                          fontFamily: 'Nova',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                );
                              }
                            } else {
                              return CircularProgressIndicator(
                                  color: Colors.white);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
