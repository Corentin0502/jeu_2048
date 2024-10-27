import 'package:flutter/material.dart';

class info_page extends StatelessWidget {
  const info_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Comment Jouer ?'),
        backgroundColor: Colors.blueAccent,
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Le jeu du 2048',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'Le but du jeu est de faire glisser les tuiles pour combiner les nombres.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Combinez-les pour atteindre la tuile 2048!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Text(
                'Mais il existe des objectifs intermédiaires :',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Image(image: AssetImage('img/score.png')),
              SizedBox(height: 50),
              Text(
                'Il y a différents types de déplacements : ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Image(image: AssetImage('img/grille.png')),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      );
    }
}