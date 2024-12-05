import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:jeu_2048/pages/home/widgets/custom_navigation_bar.dart';
import 'liste_deroulante.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool isLargeGrid = false;
  bool isInverseMode = false;
  bool isRandomMode = false;

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
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Grille 8*8 :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Checkbox(
                value: isLargeGrid,
                onChanged: (value) {
                  setState(() {
                    isLargeGrid = value!;
                  });
                },
              ),
              const Spacer(flex: 1,)
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Mode inversée :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Checkbox(
                value: isInverseMode,
                onChanged: (value) {
                  setState(() {
                    isInverseMode = value!;
                  });
                },
              ),
              const Spacer(flex: 1,)
            ],
          ),
          Row(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Mode Alétoire :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Checkbox(
                value: isRandomMode,
                onChanged: (value) {
                  setState(() {
                    isRandomMode = value!;
                  });
                },
              ),
              const Spacer(flex: 1,)
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}