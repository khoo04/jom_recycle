import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('info').snapshots(), // Fetching from Firestore
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Firestore Error: ${snapshot.error}");
              return Center(child: Text("Error loading data"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No information available in Firestore"));
            }

            final infoDocs = snapshot.data!.docs;

            return ListView(
              padding: EdgeInsets.all(16),
              children: infoDocs.map((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return InfoTile(
                  title: data['title'] ?? 'No Title',
                  content: data['content'] ?? 'No Content',
                  icon: Icons.info, // Default icon, you can store icons in Firestore if needed
                );
              }).toList(),
            );
          },
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
