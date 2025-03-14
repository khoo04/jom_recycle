import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jom_recycle/features/waste_recogniton/pages/recognition_result_page.dart';

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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecognitionResultPage()));
                },
                icon: Icon(
                  Icons.camera,
                  size: 42,
                )),
          ))
    ]);
  }
}
