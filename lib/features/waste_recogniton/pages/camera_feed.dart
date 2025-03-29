import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jom_recycle/common/models/api_response.dart';
import 'package:jom_recycle/common/secrets/app_secret.dart';
import 'package:jom_recycle/common/utils/logger.dart';
import 'package:jom_recycle/common/utils/network.dart';
import 'package:jom_recycle/features/waste_recogniton/models/analyze_result.dart';
import 'package:jom_recycle/features/waste_recogniton/pages/recognition_result_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
              onPressed: () async {
                try {
                  final XFile? image = await _takePicture();
                  if (context.mounted) {
                    context.loaderOverlay.show(
                      widgetBuilder: (progress) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Analyzing....',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  if (image != null && context.mounted) {
                    sendImageAnalysis(image, context);
                  }
                } on DioException catch (e) {
                  if (context.mounted) {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message!)),
                    );
                  }
                  eLog(e.message);
                } catch (e) {
                  if (context.mounted) {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                  eLog(e);
                }
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

  Future<XFile?> _takePicture() async {
    if (!controller.value.isInitialized) {
      eLog("Camera not initialized");
      return null;
    }

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      eLog(e);
      return null;
    }
  }

  Future<void> sendImageAnalysis(XFile picture, BuildContext context) async {
    final Uint8List bytes = await picture.readAsBytes();
    String imageBase64String = base64Encode(bytes);
    try {
      final data = await Http.post(
        "/analyzeWaste",
        options: Options(
          headers: {
            "x-api-key": AppSecret.analyzeImageApiKey,
            Headers.contentTypeHeader: Headers.jsonContentType,
          },
        ),
        data: {
          "type": "image",
          "base64Image": imageBase64String,
        },
      );

      final apiResponse = ApiResponse.fromJson(data);

      if (apiResponse.success && context.mounted) {
        final analyzeResult = AnalyzeResult.fromJson(apiResponse.data);

        final imageProvider = Image.memory(bytes).image;
        context.loaderOverlay.hide();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecognitionResultPage(
              recgonizedImage: imageProvider,
              result: analyzeResult,
            ),
          ),
        );
      } else {
        throw Exception(apiResponse.error);
      }
    } catch (e) {
      rethrow;
    }
  }
}
