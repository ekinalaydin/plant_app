import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  String style = '';
  bool _locationPermissionGranted = false;
  final Set<Marker> _markers = {};
  final Random _random = Random();
  final Map<String, Color> _markerColors = {};
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(39.92077, 32.85411), // Ankara's coordinates
    zoom: 10.0,
  );
  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _checkPermissions();
    _addRandomMarkers();
  }

  void _checkPermissions() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      PermissionStatus permissionStatus = await Permission.location.request();
      setState(() {
        _locationPermissionGranted = permissionStatus.isGranted;
      });
    } else {
      setState(() {
        _locationPermissionGranted = status.isGranted;
      });
    }
  }

  void _addRandomMarkers() {
    _markers.clear();
    _markerColors.clear();
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue
    ]; // Marker colors
    for (int i = 0; i < 3; i++) {
      final LatLng randomLocation = LatLng(
          39.92077 + (_random.nextDouble() * 0.1 - 0.05), // Randomize latitude
          32.85411 + (_random.nextDouble() * 0.1 - 0.05) // Randomize longitude
          );
      String markerId = 'marker_$i';
      Marker newMarker = Marker(
        markerId: MarkerId(markerId),
        position: randomLocation,
        infoWindow: InfoWindow(
          title: 'Marker $i',
          snippet: 'A randomly placed marker',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(_colorToHue(colors[i])),
      );
      _markers.add(newMarker);
      _markerColors[markerId] = colors[i];
    }
    setState(() {}); // Trigger rebuild to display markers
  }

  // Helper method to convert Color to BitmapDescriptor Hue
  double _colorToHue(Color color) {
    double hue = 0.0;
    if (color == Colors.red) {
      hue = BitmapDescriptor.hueRed;
    } else if (color == Colors.green) {
      hue = BitmapDescriptor.hueGreen;
    } else if (color == Colors.blue) {
      hue = BitmapDescriptor.hueBlue;
    }
    return hue;
  }

  void _showMarkerInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Marker Information'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _markers.map((marker) {
                Color color =
                    _markerColors[marker.markerId.value] ?? Colors.black;
                return Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: color),
                    SizedBox(width: 10),
                    Text(marker.infoWindow.title ?? 'No Title'),
                  ],
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          style: style,
          onMapCreated: _onMapCreated,
          initialCameraPosition: _initialCameraPosition,
          myLocationEnabled: _locationPermissionGranted,
          myLocationButtonEnabled: _locationPermissionGranted,
          markers: _markers,
        ),
        Positioned(
          top: 60, // Distance from the top
          right: 20, // Distance from the right
          child: FloatingActionButton(
            onPressed: () => _showMarkerInfo(context),
            backgroundColor: Colors.blue,
            mini: true, // Makes the FloatingActionButton smaller
            child: Icon(
              Icons.info_outline,
              size: 20, // Adjusted icon size for visibility
            ),
          ),
        ),
      ]),
    );
  }
}
