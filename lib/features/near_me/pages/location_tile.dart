import 'package:flutter/material.dart';

import 'package:jom_recycle/features/near_me/data/models/place_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({
    super.key,
    required this.place,
  });

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${place.distance.toStringAsFixed(2)} km"),
          Text(place.vicinity),
        ],
      ),
      trailing: IconButton.outlined(
          onPressed: () {
            _openGoogleMap(place.id);
          },
          icon: Icon(Icons.map)),
    );
  }

  _openGoogleMap(String placeId) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=place_id:$placeId';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
