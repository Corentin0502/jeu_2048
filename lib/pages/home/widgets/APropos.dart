import 'package:flutter/material.dart';
import 'package:jeu_2048/pages/home/widgets/custom_navigation_bar.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Comment Jouer ?',
            style: TextStyle(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Le jeu du 2048',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Le but du jeu est de faire glisser les tuiles pour combiner les nombres.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Combinez-les pour atteindre la tuile 2048!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Mais il existe des objectifs intermédiaires : ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'img/score.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Il y a différents types de déplacements :'
                    '\n- Gauche'
                    '\n- Droite'
                    '\n- Haut'
                    '\n- Bas'
                    "\n\nIls s'effectuent tous avec un glissement sur l'écran",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'img/grille.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}