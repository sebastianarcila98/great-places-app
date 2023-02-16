import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places_provider.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

import './screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlacesProvider>.value(
      value: PlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const PlacesListScreen(),
        routes: {AddPlaceScreen.route: (context) => const AddPlaceScreen()},
      ),
    );
  }
}
