import 'package:flutter/material.dart';
//import 'package:jeu_2048/widget/listeDeroulante.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  int coup = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('2048'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.cyanAccent, // Couleur de surlignage
              padding: EdgeInsets.symmetric(vertical: 8.0), // Pour ajouter un peu d'espace
              child: Text(
                "Coup : $coup",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Expanded(
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
                      coup++;
                      print('Coup : $coup');
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
            //ActionSheetExample(), // bouton selection objectif
          ],
        ),
      ),
    );
  }
}


