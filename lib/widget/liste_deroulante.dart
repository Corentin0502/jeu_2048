import 'package:flutter/cupertino.dart';

class ActionSheetExample extends StatefulWidget {
  final Function(String) onSelectionChanged; // Callback pour envoyer la sélection à main.dart

  const ActionSheetExample({super.key, required this.onSelectionChanged});

  @override
  _ActionSheetExampleState createState() => _ActionSheetExampleState();
}

class _ActionSheetExampleState extends State<ActionSheetExample> {
  // Méthode pour afficher le CupertinoActionSheet
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              widget.onSelectionChanged('2048'); // Envoie la valeur sélectionnée à main.dart
              Navigator.pop(context);
            },
            child: const Text('2048'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              widget.onSelectionChanged('1024');
              Navigator.pop(context);
            },
            child: const Text('1024'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              widget.onSelectionChanged('512');
              Navigator.pop(context);
            },
            child: const Text('512'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              widget.onSelectionChanged('256');
              Navigator.pop(context);
            },
            child: const Text('256'),
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