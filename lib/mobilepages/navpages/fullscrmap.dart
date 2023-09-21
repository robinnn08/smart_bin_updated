import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({super.key});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
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
    position: const LatLng(-6.2001682, 106.7857123),
    infoWindow: const InfoWindow(title: 'Bin 1'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  );

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
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPos,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
          this.controller.complete(controller);
        },
        markers: {
          _bin1,
        },
      ),
    );
  }
}
