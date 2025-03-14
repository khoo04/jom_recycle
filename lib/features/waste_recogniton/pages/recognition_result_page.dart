import 'package:flutter/material.dart';

class RecognitionResultPage extends StatefulWidget {
  const RecognitionResultPage({super.key});

  @override
  State<RecognitionResultPage> createState() => _RecognitionResultPageState();
}

class _RecognitionResultPageState extends State<RecognitionResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Placeholder(),
                Center(child: Text("Recognized image")),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Recognized Waste type",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Recognized Waste description. Lorem ipsum dolor sit amet consectetur adipisicing elit. Est deleniti natus sit quaerat nam excepturi blanditiis adipisci laboriosam veniam, consectetur eveniet cum? Sapiente qui ea maxime provident quis aperiam excepturi! ",
                    style: TextStyle(),
                  )
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
    );
  }
}
