import 'package:flutter/material.dart';
import 'widgets/listeDeroulante.dart'; // Importation d'un widget externe pour la sélection

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int score = 0; // Score

  int selectedValue = 2048; // Valeur sélectionnée via le bouton (stockée en tant qu'int)

  // Cette fonction sera passée à `ActionSheetExample` pour mettre à jour l'état
  void _onSelectionChanged(int value) {
    setState(() {
      selectedValue = value; // Met à jour la valeur sélectionnée avec un `int`
    });
  }

  // Méthode pour tester la limite d'atteinte de l'objectif
  void testLimiteObject(int score) {
    setState(() {
      // Si le score atteint ou dépasse l'objectif
      if (score >= selectedValue) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            content: Text('Objectif atteint !'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Envelopper avec MaterialApp
      debugShowCheckedModeBanner: false, // Désactiver la bannière de débogage
      home: Scaffold(
        appBar: AppBar(
          title: const Text('2048'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            // Section pour afficher le score
            Container(
              color: Colors.cyanAccent, // Couleur de surlignage
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Pour ajouter un peu d'espace
              child: Column(
                children: [
                  Text(
                    "Score : $score", // Affiche le score
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            // Grille du jeu 4x4
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
                      setState(() {
                        score += 50; // Incrémente le score
                      });
                      print('Score : $score');
                      testLimiteObject(score); // Teste si l'objectif est atteint
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1), // Espacement entre les cellules
                      height: 50.0,
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: Text(
                        '$index', // Affiche l'indice de la cellule (exemple simplifié)
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Affiche l'objectif à atteindre
            Text(
              "Objectif à atteindre: $selectedValue",
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            // Widget de sélection d'objectif
            ActionSheetExample(onSelectionChanged: _onSelectionChanged), // Passe la fonction de callback
          ],
        ),
      ),
    );
  }
}
