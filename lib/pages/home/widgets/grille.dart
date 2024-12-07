import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/colors.dart';

class Grille extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    _initializeGrid();
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
    await Future.delayed(const Duration(milliseconds: 100)); // Attendre 1 seconde
    setState(() {
      _addNewTile();
    });

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
  }




  List<int?> _mergeTiles(List<int?> tiles) {
    List<int?> merged = List.filled(tiles.length, null); // Résultat final
    List<bool> hasMerged = List.filled(tiles.length, false); // Indique si une tuile a déjà fusionné
    int targetIndex = 0; // Index où placer la prochaine tuile

    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i] != null) {
        if (
        targetIndex > 0 &&
            merged[targetIndex - 1] == tiles[i] &&
            !hasMerged[targetIndex - 1]
        ) {
          // Fusionner avec la tuile précédente
          merged[targetIndex - 1] = merged[targetIndex - 1]! * 2;
          hasMerged[targetIndex - 1] = true; // Marquer comme fusionnée
        } else {
          // Déplacer la tuile sans fusion
          merged[targetIndex] = tiles[i];
          targetIndex++;
        }
      }
    }

    return merged;
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