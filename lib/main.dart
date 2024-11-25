import 'package:flutter/material.dart';
import 'widgets/listeDeroulante.dart'; // Importation d'un widget externe pour la sélection

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Désactiver la bannière de débogage
      home: MyHomePage(), // Home défini comme un StatefulWidget
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int score = 0; // Score actuel
  int selectedValue = 2048; // Valeur sélectionnée via le bouton
  int maxScore = 2048; // Score maximum, initialisé à la valeur de l'objectif sélectionné

  void _onSelectionChanged(int value) {
    setState(() {
      selectedValue = value; // Met à jour la valeur sélectionnée
      maxScore = value; // Met à jour la limite de score
    });
  }

  // Fonction pour afficher une boîte de dialogue
  void _showMaxScoreMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Félicitations!'),
          content: Text(
              'Vous avez atteint le score maximum de $maxScore points ! Cliquez OK pour réinitialiser.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetScore(); // Réinitialise le score après confirmation
              },
            ),
          ],
        );
      },
    );
  }

  // Réinitialiser le score
  void _resetScore() {
    setState(() {
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2048'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Section pour afficher le score
          Container(
            color: Colors.cyanAccent,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  "Score : $score",
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          // Grille du jeu 4x4
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (score < maxScore) {
                        score += 50; // Incrémente le score
                      }
                      if (score >= maxScore) {
                        _showMaxScoreMessage(); // Affiche la boîte de dialogue
                      }
                    });
                    print('Score : $score');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    height: 50.0,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: Text(
                      '$index',
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
          ActionSheet(onSelectionChanged: _onSelectionChanged),
        ],
      ),
    );
  }
}
