import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_bin/listfolder/list_n_request.dart';
import 'package:smart_bin/mobilepages/navpages/fullscr.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smart_bin/widget/carousel.dart';

// home page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double temp = 3 / 4 * 100;

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

  Future<void>? fetchDataFuture;

  Future<void> _refreshData() async {
    setState(() {
      fetchDataFuture = fetchData();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
    // load tema map dari file json ke mapTheme
    DefaultAssetBundle.of(context)
        .loadString('assets/darkmode.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome Back,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Nova',
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 2),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${FirebaseAuth.instance.currentUser!.displayName}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'Nova',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: 140.0,
                          viewportFraction: 1.02,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 8),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                        ),
                        items: carouselItems),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FullScr(),
                              ));
                        },
                        child: const Row(
                          children: [
                            Icon(
                              LineIcons.expand,
                              color: Colors.white,
                            ),
                            Text(
                              ' Expand Map',
                              style: TextStyle(
                                  fontFamily: 'Nova',
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: 340,
                      height: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: const Color.fromARGB(255, 203, 203, 203),
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          compassEnabled: true,
                          initialCameraPosition: _initialPos,
                          markers: {
                            _bin1,
                            _bin2,
                            _bin3,
                          },
                          onMapCreated: (GoogleMapController controller) {
                            controller.setMapStyle(mapTheme);
                          },
                          mapType: MapType.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
