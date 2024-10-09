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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 colonnes
            childAspectRatio: 1, // Chaque cellule est carrée
          ),
          itemCount: 16, // 4x4 = 16 cellules
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print('Tapped on tile $index');
                //IncrementCoup(coup);
              }, // Gérer le tap sur la case ici
              child: Container(
                margin: EdgeInsets.all(1), // Espacement entre les cellules
                height: 50.0,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}