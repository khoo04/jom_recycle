import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jom_recycle/features/waste_recogniton/pages/recognition_result_page.dart';

class CameraFeed extends StatelessWidget {
  const CameraFeed({
    super.key,
    required this.controller,
    required this.cameraLensDirection,
    required this.onCameraLensChange,
    required this.availableCameraDireciton,
  });

  final CameraController controller;
  final CameraLensDirection cameraLensDirection;
  final Function(CameraLensDirection) onCameraLensChange;
  final Map<CameraLensDirection, Widget> availableCameraDireciton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(child: CameraPreview(controller)),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CupertinoSlidingSegmentedControl<CameraLensDirection>(
              backgroundColor: Theme.of(context).colorScheme.inverseSurface,
              thumbColor: Theme.of(context).colorScheme.primary,
              children: availableCameraDireciton,
              groupValue: cameraLensDirection,
              onValueChanged: (value) {
                if (value != null) {
                  onCameraLensChange(value);
                }
              },
            ),
          ),
        ),
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
              ),
            ),
          ),
        )
      ],
    );
  }
}
