import 'package:flutter/material.dart';
import 'package:jeu_2048/widget/liste_deroulante.dart';

class setting_page extends StatelessWidget {
  final Function(String) onSelectionChanged;

  const setting_page({Key? key, required this.onSelectionChanged}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page De Configuration'),
        backgroundColor: Colors.blueAccent,
      ),
      body:
          Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Choix de l'objectif à atteindre ",
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                ActionSheetExample(onSelectionChanged: onSelectionChanged),
              ]
          ),
    );
  }
}
