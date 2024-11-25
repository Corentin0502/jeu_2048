import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionSheet extends StatefulWidget {
  final Function(int) onSelectionChanged; // Changer le type pour int

  const ActionSheet({super.key, required this.onSelectionChanged});

  @override
  _ActionSheetState createState() => _ActionSheetState();
}

class _ActionSheetState extends State<ActionSheet> {
  int obj1 = 2048;
  int obj2 = 1024;
  int obj3 = 512;
  int obj4 = 256;

  // Méthode pour afficher le CupertinoActionSheet
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              widget.onSelectionChanged(2048); // Envoie la valeur sélectionnée en tant qu'int
              Navigator.pop(context);
            },
            child: Text('${obj1.toString()}'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              widget.onSelectionChanged(1024); // Envoie la valeur sélectionnée en tant qu'int
              Navigator.pop(context);
            },
            child: Text('${obj2.toString()}'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              widget.onSelectionChanged(512); // Envoie la valeur sélectionnée en tant qu'int
              Navigator.pop(context);
            },
            child: Text('${obj3.toString()}'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              widget.onSelectionChanged(256); // Envoie la valeur sélectionnée en tant qu'int
              Navigator.pop(context);
            },
            child: Text('${obj4.toString()}'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Décalage de 20px par rapport à tous les bords de l'écran
        child: CupertinoButton(
          onPressed: () => _showActionSheet(context),
          color: CupertinoColors.activeBlue, // Couleur du bouton
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Taille interne du bouton
          borderRadius: BorderRadius.circular(20), // Bordures arrondies
          child: const Text(
            "Sélection de l'objectif",
            style: TextStyle(
              fontSize: 16, // Taille du texte
              color: CupertinoColors.white, // Couleur du texte
            ),
          ),
        ),
      ),
    );
  }
}
