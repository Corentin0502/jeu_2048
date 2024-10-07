// lib/custom_widget.dart
import 'package:flutter/material.dart';

class Tableau extends StatelessWidget {
  final String title;

  Tableau({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400, // Espacement interne autour du tableau
        child: GridView.builder(
          shrinkWrap: true, // Ajuster le tableau à son contenu
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 colonnes
            childAspectRatio: 1, // Chaque cellule est carrée
          ),
          itemCount: 16, // 4x4 = 16 cellules
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(0), // Espacement entre les cellules
              color: Colors.primaries[index % Colors.primaries.length],
              alignment: Alignment.center,
              child: Text(
                'Cellule $index',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
