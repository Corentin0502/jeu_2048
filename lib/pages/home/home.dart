import 'package:flutter/material.dart';
import 'package:jeu_2048/pages/home/widgets/custom_navigation_bar.dart';
import 'package:jeu_2048/pages/home/widgets/grille.dart';
import 'package:jeu_2048/pages/home/widgets/header.dart';
import 'package:jeu_2048/pages/home/widgets/review.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderSection(),
          GrilleSection(title: ''),
          ReviewSection(selectedValue: 2048),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
