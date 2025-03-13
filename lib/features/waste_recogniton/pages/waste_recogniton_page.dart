import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:jom_recycle/common/utils/logger.dart';

class WasteRecognitionPage extends StatefulWidget {
  const WasteRecognitionPage({super.key});

  @override
  State<WasteRecognitionPage> createState() => _WasteRecognitionPageState();
}

class _WasteRecognitionPageState extends State<WasteRecognitionPage>
    with WidgetsBindingObserver {
  late Future<void> cameraValue;

  @override
  void initState() {
    super.initState();
    cameraValue = _initalizeCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  Future<CameraController> _initalizeCamera() async {
    final cameras = await availableCameras();
    final controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await controller.initialize();
    vLog(controller);
    return controller;
  }

//TODO: REFACTOR FOR GOOD STRUCTURE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("Waste Recogniton")),
          Expanded(
            child: FutureBuilder(
                future: _initalizeCamera(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final controller = snapshot.data!;

                    return controller.value.isInitialized
                        ? CameraPreview(controller)
                        : SizedBox(
                            child: Text("Camera is not initialized"),
                          );
                  }
                  return CircularProgressIndicator();
                }),
          )
        ],
      ),
    );
  }

  // void showInSnackBar(String message) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  // void _showCameraException(CameraException e) {
  //   _logError(e.code, e.description);
  //   showInSnackBar('Error: ${e.code}\n${e.description}');
  // }

  // Future<void> _initializeCameraController(
  //     CameraDescription cameraDescription) async {
  //   print("hELLO");
  //   final CameraController cameraController = CameraController(
  //     cameraDescription,
  //     kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
  //     enableAudio: false,
  //     imageFormatGroup: ImageFormatGroup.jpeg,
  //   );

  //   controller = cameraController;

  //   // If the controller is updated then update the UI.
  //   cameraController.addListener(() {
  //     if (mounted) {
  //       setState(() {
  //         print("hELLO");
  //       });
  //     }
  //     if (cameraController.value.hasError) {
  //       showInSnackBar(
  //           'Camera error ${cameraController.value.errorDescription}');
  //     }
  //   });

  //   try {
  //     await cameraController.initialize();
  //   } on CameraException catch (e) {
  //     switch (e.code) {
  //       case 'CameraAccessDenied':
  //         showInSnackBar('You have denied camera access.');
  //       case 'CameraAccessDeniedWithoutPrompt':
  //         // iOS only
  //         showInSnackBar('Please go to Settings app to enable camera access.');
  //       case 'CameraAccessRestricted':
  //         // iOS only
  //         showInSnackBar('Camera access is restricted.');
  //       case 'AudioAccessDenied':
  //         showInSnackBar('You have denied audio access.');
  //       case 'AudioAccessDeniedWithoutPrompt':
  //         // iOS only
  //         showInSnackBar('Please go to Settings app to enable audio access.');
  //       case 'AudioAccessRestricted':
  //         // iOS only
  //         showInSnackBar('Audio access is restricted.');
  //       default:
  //         _showCameraException(e);
  //     }
  //   }
  // }
}
