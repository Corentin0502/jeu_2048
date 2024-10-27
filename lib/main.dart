import 'package:flutter/material.dart';
import 'package:jeu_2048/widget/info_page.dart';
import 'package:jeu_2048/widget/liste_deroulante.dart';
import 'package:jeu_2048/widget/refresh.dart';
import 'package:jeu_2048/widget/footer.dart'; // Import du footer

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
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.cyanAccent,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Coup : $coup",
                    style: const TextStyle(fontSize: 30),
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
                          setState(() {
                            coup++; // Incrémente le nombre de coups
                          });
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
                Padding(
                padding: const EdgeInsets.all(60.0),
                  child: Text(
                    "Objectif à atteindre: $selectedValue",
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(onSelectionChanged: _onSelectionChanged),
            ),
          ],
        ),
      ),
    );
  }
}
