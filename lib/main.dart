import 'package:flutter/material.dart';
import 'package:jeu_2048/widget/listeDeroulante.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('2048'),
          backgroundColor: Colors.yellow,
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 colonnes
                  childAspectRatio: 1, // Chaque cellule est carrée
                ),
                itemCount: 16, // 4x4 = 16 cellules
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4), // Espacement entre les cellules
                    height: 50.0,
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: Text(
                      'Cellule $index',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            ActionSheetExample(), // bouton selection objectif
          ],
        ),
      ),
    );
  }
}
