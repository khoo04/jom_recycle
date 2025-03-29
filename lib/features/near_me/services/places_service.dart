import 'dart:convert';

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

    final results =
        parseResults(parsed['results'] as List<Map<String, dynamic>>);

    return results;
  }

  List<PlaceModel> parseResults(List<Map<String, dynamic>> results) {
    final List<PlaceModel> places = [];

    for(var result in results) {
      places.add(PlaceModel(name: result['name'], location: LatLng(result['geometry'][''], longitude)))
    }

    return places;
  }
}
