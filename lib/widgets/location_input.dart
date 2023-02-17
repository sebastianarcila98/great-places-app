// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/helpers/location_helpers.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function setLocation;
  const LocationInput(this.setLocation, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _locationImgUrl;

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    final imageUrl = LocationHelpers.getMapImageUrl(
        locationData.latitude!, locationData.longitude!);
    setState(() {
      _locationImgUrl = imageUrl;
    });
    widget.setLocation(locationData.latitude, locationData.longitude);
  }

  Future<void> _selectLocationOnMap() async {
    final LatLng? selectedLocation = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MapScreen(),
        ));
    if (selectedLocation == null) return;
    setState(() {
      _locationImgUrl = LocationHelpers.getMapImageUrl(
          selectedLocation.latitude, selectedLocation.longitude);
    });
    widget.setLocation(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Column(children: [
        Container(
          height: 200,
          decoration: BoxDecoration(border: Border.all()),
          child: _locationImgUrl == null
              ? const Center(
                  child: Text('Provide Location'),
                )
              : Image.network(
                  _locationImgUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: _selectLocationOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        )
      ]),
    );
  }
}
