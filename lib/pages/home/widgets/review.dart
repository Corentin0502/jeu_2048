import 'package:flutter/material.dart';

import 'liste_deroulante.dart';

class ReviewSection extends StatefulWidget {
  final int selectedValue;

  const ReviewSection({super.key, required this.selectedValue});

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

void onSelectionChanged(String value) {
  debugPrint('Nouvelle sélection : $value'); // Pour débogage ou autre logique
}

class _ReviewSectionState extends State<ReviewSection> {
  late int selectedValue;
  late int maxScore;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
    maxScore = selectedValue;
  }

  void _onSelectionChanged(int value) {
    setState(() {
      selectedValue = value;
      maxScore = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, // Assure un alignement vertical cohérent
        children: [
          Expanded(
            child: Text(
              'Objectifs : $selectedValue',
              style: const TextStyle(
                fontSize: 18,
                height: 1.2, // Espacement vertical
              ),
            ),
          ),
          // Bouton ActionSheetExample conservé
          const ActionSheetExample(onSelectionChanged: onSelectionChanged),
        ],
      ),
    );
  }
}

/* import 'package:flutter/material.dart';

import 'liste_deroulante.dart';

class ReviewSection extends StatefulWidget {
  final int selectedValue;

  const ReviewSection({super.key, required this.selectedValue});

  @override
  _ReviewSectionState createState() => _ReviewSectionState();
}

void onSelectionChanged(String value) {
  debugPrint('Nouvelle sélection : $value'); // Pour débogage ou autre logique
}

class _ReviewSectionState extends State<ReviewSection> {
  late int selectedValue;
  late int maxScore;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
    maxScore = selectedValue;
  }

  void _onSelectionChanged(int value) {
    setState(() {
      selectedValue = value;
      maxScore = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Objectifs à atteindre : $selectedValue',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const ActionSheetExample(onSelectionChanged: onSelectionChanged),
          /*ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 4,
            ),
            child: const Icon(
              Icons.refresh,
              size: 24,
            ),
          ),*/
      ],
      ),
    );
  }
} */
