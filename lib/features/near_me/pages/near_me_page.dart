import 'package:flutter/material.dart';
import 'package:jom_recycle/features/near_me/pages/location_tile.dart';

class NearMePage extends StatefulWidget {
  const NearMePage({super.key});

  @override
  State<NearMePage> createState() => _NearMePageState();
}

class _NearMePageState extends State<NearMePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                // TODO: Replace this with actual google map view centered around user
                Placeholder(),
                Center(
                  child: Text("Map View"),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                //TODO: use actual recycling data from google map
                for (var _ in [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]) LocationTile()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
