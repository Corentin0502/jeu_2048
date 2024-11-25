import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:jeu_2048/pages/home/widgets/custom_navigation_bar.dart';
import 'liste_deroulante.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  // Ajout d'une méthode pour gérer la sélection
  void onSelectionChanged(String value) {
    debugPrint('Nouvelle sélection : $value'); // Pour débogage ou autre logique
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Page De Configuration',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Choix de l'objectif à atteindre :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ActionSheetExample(onSelectionChanged: onSelectionChanged),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Théme : ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Text(
                  'Light',
                  style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Switch(
                value: AdaptiveTheme.of(context).mode.isDark,
                onChanged: (value) {
                  if (value) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                },
              ),
              const SizedBox(width: 10),
              const Text(
                'Dark',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 1,)
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Grille 8*8 :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Checkbox(value: true, onChanged: null),
              Spacer(flex: 1,)
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Mode inversée :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Checkbox(value: true, onChanged: null),
              Spacer(flex: 1,)
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Mode Alétoire :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Checkbox(value: true, onChanged: null),
              Spacer(flex: 1,)
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}