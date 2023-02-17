import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places_provider.dart';
import 'package:great_places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../widgets/image_upload.dart';

class AddPlaceScreen extends StatefulWidget {
  static const route = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  // var newPlace = {
  //   'title': '',
  //   'image': '',
  // };
  String? _title;
  File? _image;
  double? _lat;
  double? _lng;

  void _pickImage(File img) {
    _image = img;
  }

  void _setLocation(double lat, double lng) {
    _lat = lat;
    _lng = lng;
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_lat == null || _lng == null) return;
    _formKey.currentState!.save();
    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_title!, _image!, _lat!, _lng!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Places'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Title'),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter title';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _title = newValue;
                          },
                        ),
                        // const SizedBox(height: 20.0),
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     label: Text('Longitude'),
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   validator: (value) {
                        //     return null;
                        //   },
                        //   onSaved: (newValue) {},
                        // ),
                        // const SizedBox(height: 20.0),
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     label: Text('Latitude'),
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   validator: (value) {
                        //     return null;
                        //   },
                        //   onSaved: (newValue) {},
                        // ),
                        const SizedBox(height: 20.0),
                        ImageUpload(_pickImage),
                        const SizedBox(height: 20.0),
                        LocationInput(_setLocation),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveForm();
                  Navigator.of(context).pop();
                },
                child: const Text('Add Place'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
