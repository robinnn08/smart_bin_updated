import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';

class FullScr extends StatefulWidget {
  const FullScr({super.key});

  @override
  State<FullScr> createState() => _FullScrState();
}

class _FullScrState extends State<FullScr> {
  // reference untuk bin1 dan bin2
  final bin1Reference = FirebaseDatabase.instance
      .ref()
      .child('Read')
      .child('Tong1')
      .child('status');
  final bin2Reference = FirebaseDatabase.instance
      .ref()
      .child('Read')
      .child('Tong2')
      .child('status');
  final bin3Reference = FirebaseDatabase.instance
      .ref()
      .child('Read')
      .child('Tong3')
      .child('status');

  // controller untuk google map
  final Completer<GoogleMapController> controller = Completer();
  // string untuk menyimpan tema map
  String mapTheme = '';

  // posisi awal pada map
  static const CameraPosition _initialPos = CameraPosition(
    target: LatLng(-6.20003852, 106.7857378),
    zoom: 16.4746,
  );

  // posisi marker pada map (bin1)
  static final Marker _bin1 = Marker(
    markerId: const MarkerId('bin1'),
    position: _bin1Pos.target,
    infoWindow: const InfoWindow(title: 'Bin 1'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  );

  static const CameraPosition _bin1Pos = CameraPosition(
    target: LatLng(-6.2001682, 106.7857123),
    zoom: 16.4746,
  );

  // posisi marker pada map (bin2)
  static final Marker _bin2 = Marker(
    markerId: const MarkerId('bin2'),
    position: _bin2Pos.target,
    infoWindow: const InfoWindow(title: 'Bin 2'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
  );

  static const CameraPosition _bin2Pos = CameraPosition(
    target: LatLng(-6.202390, 106.782560),
    zoom: 16.4746,
  );

  // posisi marker pada map (bin3)
  static final Marker _bin3 = Marker(
    markerId: const MarkerId('bin3'),
    position: _bin3Pos.target,
    infoWindow: const InfoWindow(title: 'Bin 3'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
  );

  static const CameraPosition _bin3Pos = CameraPosition(
    target: LatLng(-6.205842, 106.773624),
    zoom: 16.4746,
  );

  Future<void> _goToBin1() async {
    final GoogleMapController controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_bin1Pos));
  }

  Future<void> _goToBin2() async {
    final GoogleMapController controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_bin2Pos));
  }

  Future<void> _goToBin3() async {
    final GoogleMapController controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_bin3Pos));
  }

  @override
  void initState() {
    super.initState();
    // load tema map dari file json ke mapTheme
    DefaultAssetBundle.of(context)
        .loadString('assets/darkmode.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerWidth = screenWidth;
    double containerHeight = screenHeight * 0.7;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          child: Image.asset(
            'image/trashlogo.png',
          ),
        ),
        title: Text(
          'Full Screen View',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Work',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(LineIcons.arrowCircleLeft),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 66, 66, 66).withOpacity(0.2),
      ),
      body: SafeArea(
        child: Stack(children: [
          SizedBox(
            width: containerWidth,
            height: containerHeight,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: _initialPos,
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(mapTheme);
                this.controller.complete(controller);
              },
              markers: {
                _bin1,
                _bin2,
                _bin3,
              },
            ),
          ),
          DraggableScrollableSheet(
              initialChildSize:
                  0.216, // Initial size of the sheet (20% of the screen)
              minChildSize:
                  0.216, // Minimum size of the sheet (20% of the screen)
              maxChildSize:
                  0.7, // Maximum size of the sheet (80% of the screen)
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 45, 45, 45),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        spreadRadius: 10, // How far the shadow should spread
                        blurRadius: 5, // How blurry the shadow should be
                        offset: const Offset(0, 7), // Offset of the shadow
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Container(
                            width: 80,
                            height: 4,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Locations',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontFamily: 'Source',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.fullscreen_exit,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ],
                        ),
                      ),
                      buildBinCard(
                          "Bin 1",
                          "Jl. K.H. Syahdan No.9, RT.6/RW.14, Kemanggisan, Jakarta Barat",
                          bin1Reference),
                      buildBinCard(
                          "Bin 2",
                          "Jl. Rawa Belong No.35, RT.3/RW.6, Jakarta Barat",
                          bin2Reference),
                      buildBinCard(
                          "Bin 3",
                          "Jl. Ayub No.26b, RT.1/RW.6, Jakarta Barat",
                          bin3Reference),
                    ],
                  ),
                );
              })
        ]),
      ),
    );
  }

  // widget untuk membuat card bin
  Card buildBinCard(
      String title, String subtitle, DatabaseReference binReference) {
    final binnRef = binReference;
    return Card(
      elevation: 4, // Add elevation for a shadow effect
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8), // Adjust margins as needed
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Source',
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        subtitle: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Source',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Align(
                alignment: Alignment.centerLeft,
                child: StreamBuilder<DatabaseEvent>(
                  stream: binnRef.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final String status =
                          snapshot.data!.snapshot.value.toString();
                      final Color textColor =
                          status == 'Available' ? Colors.green : Colors.red;
                      return RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Status: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Source',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: status,
                              style: TextStyle(
                                color: textColor,
                                fontFamily: 'Source',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Source',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      );
                    }
                  },
                )),
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            if (title == 'Bin 1') {
              _goToBin1();
            } else if (title == 'Bin 2') {
              _goToBin2();
            } else if (title == 'Bin 3') {
              _goToBin3();
            }
          },
          icon: const Icon(
            Icons.location_pin,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    );
  }
}
