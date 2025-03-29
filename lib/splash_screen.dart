import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_recycle/app_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController for rotation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(); // Continuously rotate for 5 seconds

    // Set full screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Navigate to next screen after 5 seconds
    _startApp(context);
  }

  Future<void> _startApp(BuildContext context) async {
    await Future.delayed(Duration(seconds: 5));
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AppLayout()),
      );
    }
  }

  @override
  void dispose() {
    // Restore UI mode & dispose animation controller
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          // Center the content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                // Apply rotation animation
                turns: _controller,
                child: Icon(
                  Icons.recycling,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Jom Recycling',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
