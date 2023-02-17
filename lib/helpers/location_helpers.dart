import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationHelpers {
  static String getMapImageUrl(double latitude, double longitude) {
    var url =
        'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${dotenv.env['GOOGLE_MAPS_KEY']}';
    return url;
  }
}
