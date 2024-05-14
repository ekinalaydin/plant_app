import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  String style = '';
  bool _locationPermissionGranted = false;
  final Set<Marker> _markers = {};
  final Random _random = Random();
  final Map<String, Color> _markerColors = {};
  late CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(0.0, 0.0), // Default coordinates
    zoom: 10.0,
  );
  late Location location;
  @override
  void initState() {
    super.initState();
    _getCoordinates();
  }

  void _getCoordinates() async {
    String city = Provider.of<UserProvider>(context, listen: false).city!;
    List<Location> locations = await locationFromAddress(city);
    Location location = locations[0];
    setState(() {
      this.location = location;
    });
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: 10.0,
    )));
    _addRandomMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _checkPermissions();
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

  void _addRandomMarkers() async {
    List<dynamic> data = await ApiService().getHistorySummary(context);

    _markers.clear();
    _markerColors.clear();
    List<Color> colors = [
      //Colors.red,
      //Colors.green,
      //Colors.blue
    ]; // Marker colors

    Random random = Random();
    for (int i = 0; i < data.length; i++) {
      colors.add(Color.fromRGBO(
        random.nextInt(256), // Generates a random value for Red (0-255)
        random.nextInt(256), // Generates a random value for Green (0-255)
        random.nextInt(256), // Generates a random value for Blue (0-255)
        1.0, // Opacity (1.0 for fully opaque)
      ));
    }

    for (int i = 0; i < data.length; i++) {
      final LatLng randomLocation = LatLng(
          location.latitude +
              (_random.nextDouble() * 0.1 - 0.05), // Randomize latitude
          location.longitude +
              (_random.nextDouble() * 0.1 - 0.05) // Randomize longitude
          );
      String markerId = 'marker_$i';
      Marker newMarker = Marker(
        markerId: MarkerId(markerId),
        position: randomLocation,
        infoWindow: InfoWindow(
          title: '${data[i]['label']} (${data[i]['count']})',
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
    HSVColor hsvColor = HSVColor.fromColor(color);
    return hsvColor.hue;
  }

  void _showMarkerInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Diseases on Map'),
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
