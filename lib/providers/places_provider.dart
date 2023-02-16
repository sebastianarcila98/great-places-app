import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    Place newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      location: PlaceLocation(
        latitude: 0.0,
        longitude: 0.0,
        address: null,
      ),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
