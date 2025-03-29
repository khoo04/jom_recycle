// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  String id;
  String name;
  LatLng location;
  String vicinity;
  double distance;

  PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    required this.vicinity,
    required this.distance,
  });

  @override
  String toString() {
    return 'PlaceModel(id: $id, name: $name, location: $location, vicinity: $vicinity, distance: $distance)';
  }
}
