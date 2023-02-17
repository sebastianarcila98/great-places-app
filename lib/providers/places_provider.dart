import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/db_helpers.dart';

import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

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
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> getPlaces() async {
    final places = await DBHelper.getData('user_places');
    _items = places
        .map((place) => Place(
              id: place['id'],
              title: place['title'],
              location: PlaceLocation(
                latitude: 0.0,
                longitude: 0.0,
                address: null,
              ),
              image: File(place['image']),
            ))
        .toList();
    notifyListeners();
  }
}
