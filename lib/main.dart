// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/tableau.dart'; // Import du widget créé

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Encapsuler avec MaterialApp
      home: Scaffold(
        appBar: AppBar(
          title: Text('F-2048'),
          actions: [
            IconButton(
              icon: const Icon(Icons.smart_button),
              tooltip: 'Help',
              onPressed: () {},
            ),
          ],
        ),
        body: Tableau(title: "Tableau personnalisé"), // Utilisation du widget
      ),
    );
  }
}
