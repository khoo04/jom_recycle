import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jom_recycle/common/utils/logger.dart';
import 'package:jom_recycle/features/waste_recogniton/pages/camera_feed.dart';

class WasteRecognitionPage extends StatefulWidget {
  const WasteRecognitionPage({super.key});

  @override
  State<WasteRecognitionPage> createState() => _WasteRecognitionPageState();
}

class _WasteRecognitionPageState extends State<WasteRecognitionPage>
    with WidgetsBindingObserver {
  CameraLensDirection _defaultDirection = CameraLensDirection.back;
  late Map<CameraLensDirection, Widget> availableCameraDireciton;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  Future<CameraController> _initalizeCamera() async {
    try {
      final List<CameraDescription> cameras = await availableCameras();

      availableCameraDireciton = {
        for (var camera in cameras)
          camera.lensDirection: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _cameraLabel(camera.lensDirection),
              style: const TextStyle(color: Colors.white),
            ),
          )
      };

      final controller = CameraController(
        cameras.where((c) => c.lensDirection == _defaultDirection).first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await controller.initialize();
      return controller;
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          throw Exception('You have denied camera access.');
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          throw Exception('Please go to Settings app to enable camera access.');
        case 'CameraAccessRestricted':
          // iOS only
          throw Exception('Camera access is restricted.');
        case 'AudioAccessDenied':
          throw Exception('You have denied audio access.');
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          throw Exception('Please go to Settings app to enable audio access.');
        case 'AudioAccessRestricted':
          // iOS only
          throw Exception('Audio access is restricted.');
        default:
          throw Exception(e.description);
      }
    } catch (e) {
      rethrow;
    }
  }

  void _onCameraLensChange(CameraLensDirection lensDirection) {
    setState(() {
      _defaultDirection = lensDirection;
    });
  }

  String _cameraLabel(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return 'Main';
      case CameraLensDirection.front:
        return 'Front';
      case CameraLensDirection.external:
        return 'External';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Center(child: Text("Waste Recogniton")),
          Expanded(
            child: FutureBuilder(
                future: _initalizeCamera(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.error.toString(),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.upload),
                            label: Text("Upload via Album"),
                          )
                        ],
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    final controller = snapshot.data!;

                    return controller.value.isInitialized
                        ? CameraFeed(
                            controller: controller,
                            cameraLensDirection: _defaultDirection,
                            onCameraLensChange: _onCameraLensChange,
                            availableCameraDireciton: availableCameraDireciton,
                          )
                        : SizedBox(
                            child: Text("Camera is not initialized"),
                          );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
