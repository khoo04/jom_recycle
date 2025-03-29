import 'package:flutter/material.dart';
import 'package:jom_recycle/features/waste_recogniton/models/analyze_result.dart';

class RecognitionResultPage extends StatefulWidget {
  final ImageProvider<Object> recgonizedImage;
  final AnalyzeResult result;
  const RecognitionResultPage({
    super.key,
    required this.recgonizedImage,
    required this.result,
  });

  @override
  State<RecognitionResultPage> createState() => _RecognitionResultPageState();
}

class _RecognitionResultPageState extends State<RecognitionResultPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 300,
                      child: Image(
                        image: widget.recgonizedImage,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(widget.result.wasteName),
                          Text(
                            widget.result.wasteCategory,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Recycable? : ",
                              children: [
                                TextSpan(
                                  text: widget.result.isRecycleable
                                      ? "Yes"
                                      : "No",
                                  style: TextStyle(
                                    color: widget.result.isRecycleable
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          widget.result.isRecycleable &&
                                  widget.result.recycleBinColor != null
                              ? Builder(builder: (context) {
                                  Color binColor = Colors.black;
                                  switch (widget.result.recycleBinColor!
                                      .toLowerCase()) {
                                    case "orange":
                                      binColor = Colors.orange;
                                    case "blue":
                                      binColor = Colors.blue;
                                    case "brown":
                                      binColor = Colors.brown;
                                  }
                                  return Row(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: "Recycle Bin Color: ",
                                          children: [
                                            TextSpan(
                                              text: widget
                                                  .result.recycleBinColor!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: binColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.delete,
                                        size: 18,
                                        color: binColor,
                                      ),
                                    ],
                                  );
                                })
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                              widget.result.instructions.length,
                              (int index) => Text(
                                  "${index + 1}. ${widget.result.instructions[index]}")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text("SCAN MORE"),
                  icon: Icon(Icons.camera),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
