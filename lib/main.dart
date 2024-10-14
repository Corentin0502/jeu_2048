// lib/main.dart
import 'package:flutter/material.dart';
import 'package:jeu_2048/widgets/swipe.dart';
import 'widgets/tableau.dart'; // Import du widget créé
import 'widgets/coup.dart'; // Import du widget créé


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
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
              icon: const Icon(Icons.smart_button),
              tooltip: 'Help',
              onPressed: () {},
            ),
          ],
        ),
        body:
        Column( // Utilisation de Column pour empiler les widgets
          children: [
            //Coup(), // Ajout du widget Coup ici
            //Swipe(),
            Expanded(child: Tableau(title: "Tableau personnalisé")), // Utilisation du widget
          ],
        ),
      ),
    );
  }
}