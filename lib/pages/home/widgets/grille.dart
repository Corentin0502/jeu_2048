import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/colors.dart';

class Grille extends StatefulWidget {
  final Function onScoreUpdated;
  final int objective;
  final VoidCallback onGameOver;  // Callback pour fin de jeu
  final VoidCallback onObjectiveAchieved; // Callback pour atteindre l'objectif
  final Function(int) onMoveCountUpdated; // Nouvelle fonction de rappel pour moveCount


  Grille({
    Key? key,
    required this.onScoreUpdated,
    required this.objective,
    required this.onGameOver,
    required this.onObjectiveAchieved,
    required this.onMoveCountUpdated, // Ajouter le callback
  }) : super(key: key);

  @override
  _TableauState createState() => _TableauState();
}

class _TableauState extends State<Grille> {
  int gridSize = 4; // Taille par défaut (4x4)
  late List<int?> gridValues;
  int sensibilite = 10; // Sensibilité du glissement
  bool modeInverse = false; // Mode inversé désactivé par défaut
  bool isMoving = false; // Indique si un mouvement est en cours
  bool randomMode = false; // Mode random désactivé par défaut
  int currentScore = 0; // Déclarez la variable currentScore
  bool isPopupShowing = false; // Empêche plusieurs popups d'atteinte d'objectif

  // Ajout du compteur de coups
  int moveCount = 0; // Nombre de coups effectués

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  // Fonction pour incrémenter le compteur de coups à chaque mouvement
  void _incrementMoveCount() {
    setState(() {
      moveCount++;
    });
    // Notifier le parent de la mise à jour
    widget.onMoveCountUpdated(moveCount);
  }

  void _initializeGrid({bool isRandomMode = false}) {
    gridValues = List.generate(gridSize * gridSize, (_) => null);

    if (isRandomMode) {
      _initializeRandomGrid();
    } else {
      _addNewTile();
      _addNewTile();
    }
  }

  void _initializeRandomGrid() {
    // Définir les valeurs possibles pour les tuiles initiales
    List<int> possibleValues = [2, 4, 8, 16, 32, 64, 128, 256, 512];

    // Déterminer le nombre de tuiles à générer (entre 2 et gridSize^2)
    int tileCount = (2 + (gridSize * gridSize - 2) * (Random().nextDouble())).round();

    // Ajouter des tuiles aléatoires
    for (int i = 0; i < tileCount; i++) {
      List<int> emptyIndices = [];
      for (int j = 0; j < gridValues.length; j++) {
        if (gridValues[j] == null) emptyIndices.add(j);
      }

      if (emptyIndices.isNotEmpty) {
        int randomIndex = emptyIndices[Random().nextInt(emptyIndices.length)];
        int randomValue = possibleValues[Random().nextInt(possibleValues.length)];
        gridValues[randomIndex] = randomValue;
      }
    }
  }

  void _resetGrid({bool isRandomMode = false}) {
    setState(() {
      gridValues = List.generate(gridSize * gridSize, (_) => null);
      if (isRandomMode) {
        _initializeRandomGrid();
      } else {
        _addNewTile();
        _addNewTile();
      }
    });
  }

  void _addNewTile() {
    List<int> emptyIndices = [];
    for (int i = 0; i < gridValues.length; i++) {
      if (gridValues[i] == null) emptyIndices.add(i);
    }
    if (emptyIndices.isNotEmpty) {
      int randomIndex = emptyIndices[emptyIndices.length - 1]; // Vous pouvez utiliser un Random ici
      gridValues[randomIndex] = 2;
    }
  }

  void _performMove(void Function() moveFunction) async {
    if (isMoving) return; // Bloquer si un mouvement est déjà en cours
    isMoving = true;

    setState(moveFunction); // Appliquer le mouvement
    await Future.delayed(const Duration(milliseconds: 100)); // Attendre une animation
    _addNewTile(); // Ajouter une nouvelle tuile

    // Notifier le parent du nouveau score
    widget.onScoreUpdated(currentScore);

    // Vérifier si l'objectif est atteint ou si le jeu est perdu
    _checkObjectiveAndGameOver();

    // Incrémenter le compteur de coups après un mouvement valide
    _incrementMoveCount();

    isMoving = false; // Débloquer après l'ajout de la tuile
  }

  void _moveUp() {
    _performMove(() {
      for (int col = 0; col < gridSize; col++) {
        List<int?> column = [];
        // Récupérer les valeurs de la colonne
        for (int row = 0; row < gridSize; row++) {
          int index = row * gridSize + col;
          column.add(gridValues[index]);
        }
        // Appliquer le mode inversé si activé
        if (modeInverse) column = column.reversed.toList();

        // Fusionner la colonne
        column = _mergeTiles(column);

        // Réappliquer le mode inversé après fusion si activé
        if (modeInverse) column = column.reversed.toList();

        // Réinjecter les valeurs fusionnées dans la colonne
        for (int row = 0; row < gridSize; row++) {
          int index = row * gridSize + col;
          gridValues[index] = row < column.length ? column[row] : null;
        }
      }
    });
    // Recalculer et mettre à jour le score
    _updateScore(); // Mise à jour du score après le déplacement
  }

  void _moveDown() {
    _performMove(() {
      for (int col = 0; col < gridSize; col++) {
        List<int?> column = [];
        // Récupérer les valeurs de la colonne
        for (int row = 0; row < gridSize; row++) {
          int index = row * gridSize + col;
          column.add(gridValues[index]);
        }
        // Appliquer le mode inversé si activé
        if (modeInverse) column = column.reversed.toList();

        // Fusionner la colonne inversée (ou normale si non inversée)
        column = _mergeTiles(column.reversed.toList()).reversed.toList();

        // Réappliquer le mode inversé après fusion si activé
        if (modeInverse) column = column.reversed.toList();

        // Réinjecter les valeurs fusionnées dans la colonne
        for (int row = 0; row < gridSize; row++) {
          int index = row * gridSize + col;
          gridValues[index] = row < column.length ? column[row] : null;
        }
      }
    });
    // Recalculer et mettre à jour le score
    _updateScore(); // Mise à jour du score après le déplacement
  }

  void _moveLeft() {
    _performMove(() {
      for (int row = 0; row < gridSize; row++) {
        List<int?> line = [];
        // Récupérer les valeurs de la ligne
        for (int col = 0; col < gridSize; col++) {
          int index = row * gridSize + col;
          line.add(gridValues[index]);
        }
        // Appliquer le mode inversé si activé
        if (modeInverse) line = line.reversed.toList();

        // Fusionner la ligne
        line = _mergeTiles(line);

        // Réappliquer le mode inversé après fusion si activé
        if (modeInverse) line = line.reversed.toList();

        // Réinjecter les valeurs fusionnées dans la ligne
        for (int col = 0; col < gridSize; col++) {
          int index = row * gridSize + col;
          gridValues[index] = col < line.length ? line[col] : null;
        }
      }
    });
    // Recalculer et mettre à jour le score
    _updateScore(); // Mise à jour du score après le déplacement
  }

  void _moveRight() {
    _performMove(() {
      for (int row = 0; row < gridSize; row++) {
        List<int?> line = [];
        // Récupérer les valeurs de la ligne
        for (int col = 0; col < gridSize; col++) {
          int index = row * gridSize + col;
          line.add(gridValues[index]);
        }
        // Appliquer le mode inversé si activé
        if (modeInverse) line = line.reversed.toList();

        // Fusionner la ligne inversée (ou normale si non inversée)
        line = _mergeTiles(line.reversed.toList()).reversed.toList();

        // Réappliquer le mode inversé après fusion si activé
        if (modeInverse) line = line.reversed.toList();

        // Réinjecter les valeurs fusionnées dans la ligne
        for (int col = 0; col < gridSize; col++) {
          int index = row * gridSize + col;
          gridValues[index] = col < line.length ? line[col] : null;
        }
      }
    });
    // Recalculer et mettre à jour le score
    _updateScore(); // Mise à jour du score après le déplacement
  }

  List<int?> _mergeTiles(List<int?> tiles) {
    List<int?> merged = List.filled(tiles.length, null);
    List<bool> hasMerged = List.filled(tiles.length, false);
    int targetIndex = 0;

    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != null) {
        if (targetIndex > 0 &&
            merged[targetIndex - 1] == tiles[i] &&
            !hasMerged[targetIndex - 1]) {
          merged[targetIndex - 1] = merged[targetIndex - 1]! * 2;
          currentScore += merged[targetIndex - 1]!; // Mise à jour du score
          hasMerged[targetIndex - 1] = true;
        } else {
          merged[targetIndex] = tiles[i];
          targetIndex++;
        }
      }
    }

    return merged;
  }

  void _checkObjectiveAndGameOver() {
    // Vérifier si l'objectif est atteint
    if (currentScore >= widget.objective && !isPopupShowing) {
      // Afficher le pop-up
      setState(() {
        isPopupShowing = true;
      });

      // Appeler le pop-up après un délai et réinitialiser la grille
      //widget.onObjectiveAchieved();  // Affiche le pop-up
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          isPopupShowing = false;
        });
        _resetGrid(isRandomMode: randomMode); // Réinitialiser la grille
      });
    }

    // Vérifier si le jeu est terminé
    if (_isGameOver()) {
      widget.onGameOver(); // Affiche le pop-up de fin de jeu
      _resetGrid(isRandomMode: randomMode); // Réinitialiser la grille
    }
  }

  bool _isGameOver() {
    // Vérifier si toutes les cases sont remplies
    for (int i = 0; i < gridValues.length; i++) {
      if (gridValues[i] == null) return false; // Il y a encore une case vide
    }

    // Vérifier s'il est possible de fusionner
    for (int i = 0; i < gridValues.length; i++) {
      int currentValue = gridValues[i] ?? 0;
      if (i % gridSize != gridSize - 1 && currentValue == gridValues[i + 1]) {
        return false; // Fusion possible horizontalement
      }
      if (i + gridSize < gridValues.length && currentValue == gridValues[i + gridSize]) {
        return false; // Fusion possible verticalement
      }
    }

    return true; // Si aucune fusion n'est possible
  }

  void _updateScore() {
    currentScore = 0; // Réinitialiser le score
    for (var tile in gridValues) {
      if (tile != null) {
        currentScore += tile; // Additionner les valeurs des tuiles non nulles
      }
    }
    widget.onScoreUpdated(currentScore); // Notifier la mise à jour du score
  }

  @override
  Widget build(BuildContext context) {
    double gridSizePx = MediaQuery.of(context).size.width - 40;

    return Center(
      child: Column(
        children: [
          // Boutons pour ajuster la taille de la grille
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (gridSize > 3) {
                    setState(() {
                      gridSize--;
                      _resetGrid(isRandomMode: randomMode);
                    });
                  }
                },
                child: const Text("Réduire"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  if (gridSize < 8) {
                    setState(() {
                      gridSize++;
                      _resetGrid(isRandomMode: randomMode);
                    });
                  }
                },
                child: const Text("Agrandir"),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Case à cocher pour le mode inversé
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: modeInverse,
                onChanged: (value) {
                  setState(() {
                    modeInverse = value!;
                  });
                },
              ),
              const Text("Mode inversé"),
              Checkbox(
                value: randomMode,
                onChanged: (value) {
                  setState(() {
                    randomMode = value!;
                    _resetGrid(isRandomMode: randomMode);
                  });
                },
              ),
              const Text("Mode random"),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: gridSizePx,
            height: gridSizePx,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dy.abs() > sensibilite || details.delta.dx.abs() > sensibilite) {
                  if (details.delta.dy.abs() > details.delta.dx.abs()) {
                    if (details.delta.dy < 0)
                      _moveUp();
                    else
                      _moveDown();
                  } else {
                    if (details.delta.dx < 0)
                      _moveLeft();
                    else
                      _moveRight();
                  }
                }
              },
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridSize,
                  childAspectRatio: 1,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                ),
                itemCount: gridSize * gridSize,
                itemBuilder: (context, index) {
                  String displayText = gridValues[index]?.toString() ?? '';
                  Color caseColor = gridValues[index] != null ? tileColors[gridValues[index]!]! : emptyTileColor;
                  Color textColor = (gridValues[index] != null && gridValues[index]! > 4)
                      ? textColorWhite
                      : textColorDefault;

                  double fontSize = gridSizePx / (3 * gridSize);
                  if (gridSize == 8) {
                    fontSize = gridSizePx / (4 * gridSize); // Réduction si la grille est plus grande
                  }
                  return Container(
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}