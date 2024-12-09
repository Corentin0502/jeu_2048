import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final int moveCount; // Ajout d'un paramètre pour le compteur

  const HeaderSection({super.key, required this.moveCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      height: 110,
      child: Stack(
        children: [
          const Positioned(
            bottom: 0,
            left: 0,
            child: Text(
              '2048',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 195,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Coup : $moveCount", // Utilisation du moveCount dynamique
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
