// lib/custom_widget.dart
import 'package:flutter/material.dart';

class Coup extends StatelessWidget {
  int nbCoup = 0;

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Container(
        color: Colors.cyanAccent, // Couleur de surlignage
        padding: EdgeInsets.symmetric(vertical: 8.0), // Pour ajouter un peu d'espace
        child: Text(
          "Coup : $nbCoup",
          style: TextStyle(fontSize: 30)
        ),
      ),
    );
  }

}