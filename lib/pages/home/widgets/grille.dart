import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/colors.dart';

class GrilleSection extends StatefulWidget {
  final String title;
  const GrilleSection({Key? key, required this.title}) : super(key: key);

  @override
  _GrilleSectionState createState() => _GrilleSectionState();
}

class _GrilleSectionState extends State<GrilleSection> {
  List<int> filledIndexes = [];

  @override
  void initState() {
    super.initState();
    Random random = Random();
    int firstIndex = random.nextInt(16);
    int secondIndex;

    do {
      secondIndex = random.nextInt(16);
    } while (secondIndex == firstIndex);

    filledIndexes = [firstIndex, secondIndex];
  }

  void moveTile(int index, int offset) {
    int newIndex = index + offset;
    if (filledIndexes.contains(index) && newIndex >= 0 && newIndex < 16) {
      if ((index % 4 == 0 && offset == -1) ||
          (index % 4 == 3 && offset == 1) ||
          (index < 4 && offset == -4) ||
          (index >= 12 && offset == 4)) {
        return;
      }
      setState(() {
        filledIndexes.remove(index);
        filledIndexes.add(newIndex);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Case $index déplacée à $newIndex')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 350,
            height: 360,
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero, // Remove internal padding of the GridView
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      String displayText = filledIndexes.contains(index) ? '2' : '';
                      Color caseColor = filledIndexes.contains(index) ? tileColors[2]! : emptyTileColor;

                      return GestureDetector(
                        onPanUpdate: (details) {
                          if (details.delta.dy < 0) {
                            moveTile(index, -4);
                          } else if (details.delta.dy > 0) {
                            moveTile(index, 4);
                          } else if (details.delta.dx < 0) {
                            moveTile(index, -1);
                          } else if (details.delta.dx > 0) {
                            moveTile(index, 1);
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
                            style: const TextStyle(color: textColor, fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                print('Cases non vides : $filledIndexes');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Indices des cases non vides : $filledIndexes')),
                );
              },
              child: Text('Droite'),
            ),
          ),
        ],
      ),
    );
  }
}