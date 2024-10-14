import 'package:flutter/material.dart';
import 'widgets/listeDeroulante.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int coup = 0; // Nombre de coups
  String selectedValue = "2048"; // Valeur sélectionnée via le bouton

  // Cette fonction sera passée à `ActionSheetExample` pour mettre à jour l'état
  void _onSelectionChanged(String value) {
    setState(() {
      selectedValue = value; // Met à jour la valeur sélectionnée
    });
  }

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
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Pour ajouter un peu d'espace
              child: Column(
                children: [
                  Text(
                    "Coup : $coup",
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                ],
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
                      setState(() {
                        coup++; // Incrémente le nombre de coups
                      });
                      print('Coup : $coup');
                    }, // Gérer le tap sur la case ici
                    child: Container(
                      margin: const EdgeInsets.all(1), // Espacement entre les cellules
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
            Text(
              "Objectif à atteindre: $selectedValue", // Affiche la valeur sélectionnée
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            ActionSheetExample(onSelectionChanged: _onSelectionChanged), // Passe la fonction de callback
          ],
        ),
      ),
    );
  }
}
