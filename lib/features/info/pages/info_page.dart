import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            InfoTile(
              title: "Why Recycling Matters?",
              content: "Recycling helps to reduce waste, conserve resources, and protect the environment.",
              icon: Icons.recycling,
            ),
            InfoTile(
              title: "How to Start Recycling?",
              content: "Separate waste into plastics, glass, and paper. Find local recycling centers.",
              icon: Icons.tips_and_updates,
            ),
            InfoTile(
              title: "Impact of Waste on Earth",
              content: "Excess waste contributes to pollution, climate change, and harms wildlife.",
              icon: Icons.clean_hands_outlined,
            ),
            InfoTile(
              title: "Fun Recycling Facts",
              content: "Recycling one aluminum can saves enough energy to power a TV for 3 hours!",
              icon: Icons.fact_check,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatefulWidget {
  final String title;
  final String content;
  final IconData icon;

  const InfoTile({required this.title, required this.content, required this.icon});

  @override
  _InfoTileState createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Icon(widget.icon, color: Colors.green.shade700),
        title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(
          _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: Colors.green.shade700,
        ),
        onExpansionChanged: (expanded) {
          setState(() => _isExpanded = expanded);
        },
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(widget.content, style: TextStyle(fontSize: 16, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
