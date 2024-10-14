import 'package:flutter/material.dart';
import 'package:jeu_2048/widget/info.dart';
import 'package:jeu_2048/widget/liste_deroulante.dart';

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
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.cyanAccent,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Coup : $coup",
                style: TextStyle(fontSize: 30),
              ),
            ),
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
                      print('Tapped on tile $index');
                      coup++;
                      print('Coup : $coup');
                    },
                    child: Container(
                      margin: EdgeInsets.all(1),
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
            Text(
              "Objectif à atteindre: $selectedValue", // Affiche la valeur sélectionnée
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            ActionSheetExample(onSelectionChanged: _onSelectionChanged),

            FloatingButton(),
          ],
        ),
      ),
    );
  }
}
