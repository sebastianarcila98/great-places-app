import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _selectedLocation = const LatLng(37.785834, -122.406417);

  void _updateSelectedLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('F A C K'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(_selectedLocation);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _selectedLocation,
          zoom: 13,
        ),
        padding: const EdgeInsets.all(20.0),
        onTap: (location) {
          _updateSelectedLocation(location);
        },
        markers: {
          Marker(markerId: const MarkerId('m1'), position: _selectedLocation)
        },
      ),
    );
  }
}
