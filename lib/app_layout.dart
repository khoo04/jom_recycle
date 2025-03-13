import 'package:flutter/material.dart';
import 'package:jom_recycle/common/theme/app_theme_provider.dart';
import 'package:jom_recycle/features/info/pages/info_page.dart';
import 'package:jom_recycle/features/near_me/pages/near_me_page.dart';
import 'package:jom_recycle/features/waste_recogniton/pages/waste_recogniton_page.dart';
import 'package:provider/provider.dart';

/// Main Layout of the application
class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

List<Widget> _pageList = [WasteRecognitionPage(), NearMePage(), InfoPage()];

class _AppLayoutState extends State<AppLayout> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jom Recycle"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppThemeProvider>().toggleTheme();
            },
            icon: Icon(
              Icons.dark_mode,
              color: context.watch<AppThemeProvider>().isLightTheme
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ],
      ),
      body: _pageList[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera,
              ),
              label: "Waste Recogniton"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.near_me,
              ),
              label: "Recycle Center"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.info,
              ),
              label: "Info"),
        ],
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
