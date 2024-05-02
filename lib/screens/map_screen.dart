import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<MapScreen> {
  GoogleMapController? _controller;
  final Random _random = Random();

  // Updated CameraPosition with a lower zoom level for a less detailed, broader view
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(39.9334, 32.8597), // Ankara's coordinates
    zoom: 10, // Lower zoom level to view a broader area
  );

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Initially add random markers
    _addRandomMarkers(10);
  }

  void _addRandomMarkers(int count) {
    for (int i = 0; i < count; i++) {
      double lat = 39.9334 + (_random.nextDouble() * 0.1 - 0.05);
      double lng = 32.8597 + (_random.nextDouble() * 0.1 - 0.05);
      String markerId = "marker_$i";

      Marker marker = Marker(
        markerId: MarkerId(markerId),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'Random Marker $i',
          snippet: 'A randomly placed marker',
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
