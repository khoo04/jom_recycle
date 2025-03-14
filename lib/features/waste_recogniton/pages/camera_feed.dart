import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFeed extends StatelessWidget {
  const CameraFeed({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        SizedBox.expand(child: CameraPreview(controller)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: IconButton.filled(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera,
                    size: 42,
                  )),
            ))
      ]);
  }
}
