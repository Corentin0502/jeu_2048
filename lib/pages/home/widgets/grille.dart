import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/colors.dart';
import 'dart:async';

class Grille extends StatefulWidget {
  final String title;
  Grille({required this.title});

  @override
  _TableauState createState() => _TableauState();
}

class _TableauState extends State<Grille> {
  List<int?> gridValues = List.filled(16, null); // Liste pour représenter la grille, null pour vide
  int sensibilite = 10; // Sensibilité du glissement
  bool isMoving = false; // Indicateur pour éviter plusieurs ajouts

  @override
  void initState() {
    super.initState();
    Random random = Random();
    int firstIndex = random.nextInt(16);
    int secondIndex;

    do {
      secondIndex = random.nextInt(16);
    } while (secondIndex == firstIndex);

    gridValues[firstIndex] = 2048;
    gridValues[secondIndex] = 2;
  }

  void ajouterNouvelleValeur() {
    Random random = Random();
    int nouvelIndex;
    do {
      nouvelIndex = random.nextInt(16);
    } while (gridValues[nouvelIndex] != null);

    setState(() {
      gridValues[nouvelIndex] = 2;
    });
  }

  // Fonction pour déplacer et fusionner les tuiles
  Future<void> moveDirection(int direction) async {
    if (isMoving) return; // Si un mouvement est déjà en cours, on ne fait rien
    isMoving = true; // Indiquer qu'un mouvement est en cours

    List<int?> newGridValues = List.from(gridValues); // Copie de la grille pour effectuer les déplacements
    bool moved = false;

    // Déplacer et fusionner dans la direction spécifiée
    if (direction == 0) { // Gauche
      for (int i = 0; i < 16; i++) {
        if (i % 4 != 0) {  // Exclure la première colonne pour ne pas dépasser les limites
          moved = _moveLeft(i, newGridValues) || moved;
        }
      }
    } else if (direction == 1) { // Droite
      for (int i = 15; i >= 0; i--) {
        if (i % 4 != 3) {  // Exclure la dernière colonne pour ne pas dépasser les limites
          moved = _moveRight(i, newGridValues) || moved;
        }
      }
    } else if (direction == 2) { // Haut
      for (int i = 0; i < 16; i++) {
        if (i >= 4) {
          moved = _moveUp(i, newGridValues) || moved;
        }
      }
    } else if (direction == 3) { // Bas
      for (int i = 15; i >= 0; i--) {
        if (i <= 11) {
          moved = _moveDown(i, newGridValues) || moved;
        }
      }
    }

    // Si un mouvement a eu lieu, mettre à jour la grille et ajouter une nouvelle valeur
    if (moved) {
      setState(() {
        gridValues = List.from(newGridValues);
      });
      await Future.delayed(Duration(milliseconds: 100)); // Attendre un peu avant d'ajouter la nouvelle tuile
      ajouterNouvelleValeur();
    }

    isMoving = false; // Terminer le mouvement
  }

  // Fonction pour déplacer et fusionner vers la gauche
  bool _moveLeft(int index, List<int?> newGridValues) {
    bool moved = false;
    int targetIndex = index;

    // Déplacer la tuile vers la gauche
    while (targetIndex % 4 != 0 && newGridValues[targetIndex - 1] == null) {
      newGridValues[targetIndex - 1] = newGridValues[targetIndex];
      newGridValues[targetIndex] = null;
      targetIndex--;
      moved = true;
    }

    // Fusionner si la valeur est identique
    if (targetIndex % 4 != 0 && newGridValues[targetIndex - 1] == newGridValues[targetIndex]) {
      newGridValues[targetIndex - 1] = newGridValues[targetIndex]! * 2;
      newGridValues[targetIndex] = null;
      moved = true;
    }

    return moved;
  }

  // Fonction pour déplacer et fusionner vers la droite
  bool _moveRight(int index, List<int?> newGridValues) {
    bool moved = false;
    int targetIndex = index;

    // Déplacer la tuile vers la droite
    while (targetIndex % 4 != 3 && newGridValues[targetIndex + 1] == null) {
      newGridValues[targetIndex + 1] = newGridValues[targetIndex];
      newGridValues[targetIndex] = null;
      targetIndex++;
      moved = true;
    }

    // Fusionner si la valeur est identique
    if (targetIndex % 4 != 3 && newGridValues[targetIndex + 1] == newGridValues[targetIndex]) {
      newGridValues[targetIndex + 1] = newGridValues[targetIndex]! * 2;
      newGridValues[targetIndex] = null;
      moved = true;
    }

    return moved;
  }

  // Fonction pour déplacer et fusionner vers le haut
  bool _moveUp(int index, List<int?> newGridValues) {
    bool moved = false;
    int targetIndex = index;

    // Déplacer la tuile vers le haut
    while (targetIndex >= 4 && newGridValues[targetIndex - 4] == null) {
      newGridValues[targetIndex - 4] = newGridValues[targetIndex];
      newGridValues[targetIndex] = null;
      targetIndex -= 4;
      moved = true;
    }

    // Fusionner si la valeur est identique
    if (targetIndex >= 4 && newGridValues[targetIndex - 4] == newGridValues[targetIndex]) {
      newGridValues[targetIndex - 4] = newGridValues[targetIndex]! * 2;
      newGridValues[targetIndex] = null;
      moved = true;
    }

    return moved;
  }

  // Fonction pour déplacer et fusionner vers le bas
  bool _moveDown(int index, List<int?> newGridValues) {
    bool moved = false;
    int targetIndex = index;

    // Déplacer la tuile vers le bas
    while (targetIndex <= 11 && newGridValues[targetIndex + 4] == null) {
      newGridValues[targetIndex + 4] = newGridValues[targetIndex];
      newGridValues[targetIndex] = null;
      targetIndex += 4;
      moved = true;
    }

    // Fusionner si la valeur est identique
    if (targetIndex <= 11 && newGridValues[targetIndex + 4] == newGridValues[targetIndex]) {
      newGridValues[targetIndex + 4] = newGridValues[targetIndex]! * 2;
      newGridValues[targetIndex] = null;
      moved = true;
    }

    return moved;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double gridSize = min(screenWidth, screenHeight) * 0.9;
    double tileSize = gridSize / 4;

    return Center(
      child: Column(
        children: [
          Container(
            width: gridSize,
            height: 325,  // Suppression de l'ajout de 30 pour une hauteur symétrique
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,  // Assurez-vous que ces valeurs sont égales
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      String displayText = gridValues[index]?.toString() ?? '';
                      Color caseColor = gridValues[index] != null ? tileColors[gridValues[index]!]! : emptyTileColor;
                      Color textColor = (gridValues[index] != null && gridValues[index]! > 4)
                          ? textColorWhite
                          : textColorDefault;

                      // Calculer la taille de la police en fonction du nombre de chiffres
                      double fontSize = tileSize / 2;
                      if (displayText.length == 2) {
                        fontSize = tileSize / 2.5;
                      } else if (displayText.length == 3) {
                        fontSize = tileSize / 3;
                      } else if (displayText.length == 4) {
                        fontSize = tileSize / 4;
                      }

                      return GestureDetector(
                        onPanUpdate: (details) {
                          if (details.delta.dy.abs() > sensibilite || details.delta.dx.abs() > sensibilite) {
                            if (details.delta.dy.abs() > details.delta.dx.abs()) {
                              if (details.delta.dy < 0) {
                                moveDirection(2); // Haut
                              } else {
                                moveDirection(3); // Bas
                              }
                            } else {
                              if (details.delta.dx < 0) {
                                moveDirection(0); // Gauche
                              } else {
                                moveDirection(1); // Droite
                              }
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: caseColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            displayText,
                            style: TextStyle(
                              color: textColor,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
