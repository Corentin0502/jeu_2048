import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'custom_navigation_bar.dart';


class SettingsSection extends StatefulWidget {
  final Function(bool) onInverseModeChanged;

  const SettingsSection({super.key, required this.onInverseModeChanged});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  bool isInverseMode = false; // Initialisation du mode inversé

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
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
