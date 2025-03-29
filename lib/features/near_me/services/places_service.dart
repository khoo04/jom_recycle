import 'dart:convert';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jom_recycle/common/secrets/app_secret.dart';
import 'package:jom_recycle/common/utils/logger.dart';
import 'package:jom_recycle/features/near_me/data/models/place_model.dart';

class PlacesService {
  Future<List<PlaceModel>> getNearbyRecyclingCenters(LatLng center) async {
    final queryParams = <String, String>{
      'key': AppSecret.mapAPIKey,
      'location': "${center.latitude},${center.longitude}",
      'keyword': "Recycling",
      'radius': '50000',
    };

    final url = Uri.https('maps.googleapis.com',
        '/maps/api/place/nearbysearch/json', queryParams);

    final res = await http.get(url);

    final parsed = jsonDecode(res.body) as Map<String, dynamic>;

    if (!parsed.containsKey('status')) throw Exception("Invalid response");

    if (parsed['status'] != 'OK') throw Exception('Invalid stuff');

    final results = parseResults(parsed['results'] as List<dynamic>);

    for (var place in results) {
      final distance = _calculateDistance(center, place.location);
      place.distance = distance;
    }

    return results;
  }

  List<PlaceModel> parseResults(List<dynamic> results) {
    final List<PlaceModel> places = [];

    for (var result in results) {
      final placeLatLng = LatLng(
        result['geometry']['location']['lat'],
        result['geometry']['location']['lng'],
      );

      places.add(
        PlaceModel(
          id: result['place_id'],
          name: result['name'],
          location: placeLatLng,
          vicinity: result['vicinity'],
          distance: 0,
        ),
      );
    }

    return places;
  }

  double _calculateDistance(LatLng center, LatLng location) {
    const R = 6371; // Radius of the Earth in km
    double dLat = _toRadians(location.latitude - center.latitude);
    double dLon = _toRadians(location.longitude - center.longitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(center.latitude)) *
            cos(_toRadians(location.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in km
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
