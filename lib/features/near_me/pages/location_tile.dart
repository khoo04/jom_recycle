import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  const LocationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Location 1"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location 1 Distance'),
          Text("Location 1 Address")
        ],
      ),
      trailing: IconButton.outlined(
          onPressed: () {}, icon: Icon(Icons.map)),
    );
  }
}
