import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

// Global constants for location
const double _originLatitude = 38.392300;
const double _originLongitude = 27.047840;

class _MapsState extends State<MapScreen> {
  GoogleMapController? _controller; // Nullable controller

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 15,
  );

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
      ),
    );
  }

  @override
  void dispose() {
    _controller
        ?.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }
}
