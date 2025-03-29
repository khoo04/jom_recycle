import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jom_recycle/common/utils/logger.dart';
import 'package:jom_recycle/features/near_me/pages/location_tile.dart';
import 'package:jom_recycle/features/near_me/services/places_service.dart';
import 'package:location/location.dart';

class NearMePage extends StatefulWidget {
  const NearMePage({super.key});

  @override
  State<NearMePage> createState() => _NearMePageState();
}

class _NearMePageState extends State<NearMePage> {
  final _controller = Completer<GoogleMapController>();
  var currentLatLng = LatLng(3.1390, 101.6869);
  // var currentLatLng = LatLng(37.7749, -122.4194);
  var _markers = new Set<Marker>();

  @override
  void initState() {
    super.initState();

    final placeService = PlacesService();

    // placeService.getNearbyRecyclingCenters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLatLng,
                zoom: 14.4746,
              ),
              mapType: MapType.normal,
              markers: _markers,
              onMapCreated: (controller_) {
                _controller.complete(controller_);

                _getUserLocation();
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Text("Recycling Center Near Me"),
                //TODO: use actual recycling data from google map
                for (var _ in [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]) LocationTile()
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getUserLocation() async {
    final location = Location();
    final locationData = await location.getLocation();

    // currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);
    final controller = await _controller.future;
    final userLatLng = LatLng(locationData.latitude!, locationData.longitude!);

    controller.moveCamera(CameraUpdate.newLatLng(userLatLng));
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("User Location"),
            position: userLatLng,
            infoWindow: InfoWindow(
              title: "Your current location",
              snippet: "balls",
            )),
      );
      Future.delayed(Duration(seconds: 1), () {
        controller.showMarkerInfoWindow(MarkerId("User Location"));
      });
    });

    vLog(locationData);
  }
}
