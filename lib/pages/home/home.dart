import 'package:flutter/material.dart';
import 'package:jeu_2048/pages/home/widgets/custom_navigation_bar.dart';
import 'package:jeu_2048/pages/home/widgets/grille.dart';
import 'package:jeu_2048/pages/home/widgets/header.dart';
import 'package:jeu_2048/pages/home/widgets/liste_deroulante.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedValue = 2048; // Objectif sélectionné
  int currentScore = 0; // Score actuel
  bool isGameWon = false; // Flag pour éviter d'afficher plusieurs fois le dialogue de félicitations
  int moveCount = 0; // Compteur de mouvements
  int newMoveCount = 0;

  void _onMoveCountUpdated(int newMoveCount) {
    setState(() {
      moveCount = newMoveCount; // Met à jour le moveCount dans HomePage
    });
  }

  void _onSelectionChanged(int value) {
    setState(() {
      selectedValue = value; // Mise à jour de l'objectif
      currentScore = 0; // Réinitialisation du score
      isGameWon = false; // Réinitialisation du flag de victoire
    });
  }

  void _onScoreUpdated(int score) {
    if (isGameWon) return; // Empêcher tout traitement si l'objectif est déjà atteint

    setState(() {
      currentScore = score;

      print('currentScore: $currentScore');
      print('selectedValue: $selectedValue');

      // Vérification si le score atteint l'objectif
      if (currentScore >= selectedValue) {
        isGameWon = true; // Marquer l'objectif comme atteint AVANT d'afficher la popup
        print('Félicitations! Vous avez atteint l\'objectif.');
        _showCongratulationsDialog();
      }
    });
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Félicitations!'),
          content: Text(
              'Vous avez atteint l’objectif de $selectedValue points. Cliquez sur OK pour continuer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentScore = 0; // Réinitialise le score après confirmation
                  isGameWon = false; // Réinitialisation pour permettre un nouveau jeu
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Jeu terminé !"),
          content: const Text("Vous avez perdu, il n'y a plus de coups possibles."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(moveCount: moveCount),
            Grille(
              onScoreUpdated: _onScoreUpdated,
              objective: selectedValue,
              onGameOver: _showGameOverDialog,
              onObjectiveAchieved: _showCongratulationsDialog,
              onMoveCountUpdated: _onMoveCountUpdated, // Passez la fonction ici
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Objectif actuel: $selectedValue',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              child: ActionSheet(onSelectionChanged: _onSelectionChanged),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}