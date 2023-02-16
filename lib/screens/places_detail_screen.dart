import 'package:flutter/material.dart';

class PlacesDetailScreen extends StatelessWidget {
  static const route = '';
  const PlacesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Great Places'),
      ),
      body: const Center(
        child: Text('Coming soon...'),
      ),
    );
  }
}