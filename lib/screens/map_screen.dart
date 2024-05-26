import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:plant_app/themes/colors.dart';
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
  final Map<String, List<Marker>> _citymarkers = {};
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
    _loadMapStyle();
  }

  Future<void> _loadMapStyle() async {
    // Load the map style from the asset file
    String mapstyle = await rootBundle.loadString('lib/assets/style/map.json');
    setState(() {
      style = mapstyle;
    });
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
    Map<String, int> counts = {};
    _markers.clear();
    _markerColors.clear();
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.cyan,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.brown,
      Colors.grey,
      Colors.teal,
      Colors.lime,
      Colors.indigo,
      Colors.amber,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.black,
      Colors.white,
      Colors.blueGrey,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.yellowAccent,
      Colors.cyanAccent,
      Colors.purpleAccent,
      Colors.orangeAccent,
      Colors.pinkAccent,
      Colors.brown[300]!,
      Colors.grey[300]!,
      Colors.tealAccent,
      Colors.limeAccent,
      Colors.indigoAccent,
      Colors.amberAccent,
      Colors.deepOrangeAccent,
      Colors.deepPurpleAccent,
      Colors.lightBlueAccent,
      Colors.lightGreenAccent,
      Colors.blueGrey[300]!,
      Colors.red[300]!,
      Colors.green[300]!,
      Colors.blue[300]!,
      Colors.yellow[300]!,
      Colors.cyan[300]!,
      Colors.purple[300]!,
      Colors.orange[300]!,
      Colors.pink[300]!,
      Colors.brown[100]!,
      Colors.grey[100]!,
      Colors.teal[300]!,
    ];

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
      List<Location> locations = await locationFromAddress(data[i]['city']);
      Location clocation = locations[0];

      final LatLng randomLocation = LatLng(
          clocation.latitude +
              (_random.nextDouble() * 0.1 - 0.05), // Randomize latitude
          clocation.longitude +
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

      if (_citymarkers.containsKey(data[i]['city'])) {
        _citymarkers[data[i]['city']]?.add(newMarker);
      } else {
        _citymarkers[data[i]['city']] = [newMarker];
      }
      _markers.add(newMarker);
      _markerColors[markerId] = colors[i];
    }
    setState(() {}); // Trigger rebuild to display markers
  }

  double _colorToHue(Color color) {
    // Convert Flutter Color to hue for Google Maps marker
    return HSVColor.fromColor(color).hue;
  }

  void _showMarkerInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: Text(
            'Diseases on Map',
            style: GoogleFonts.poppins(fontSize: 19),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: _citymarkers.entries.map((entry) {
                String city = entry.key;
                List<Marker> markers = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      city,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ...markers.map((marker) {
                      Color color =
                          _markerColors[marker.markerId.value] ?? Colors.black;
                      String title = marker.infoWindow.title ?? 'No Title';
                      return Row(
                        children: <Widget>[
                          Icon(Icons.location_on, color: color),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                              ),
                              title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    SizedBox(height: 16), // Add spacing between cities
                  ],
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: GoogleFonts.poppins(color: AppColors.onSurface),
              ),
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
