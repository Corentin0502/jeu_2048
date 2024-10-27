import 'package:flutter/material.dart';
import 'package:jeu_2048/widget/info_page.dart';
import 'package:jeu_2048/widget/setting_page.dart';

class Footer extends StatelessWidget {
  final Function(String) onSelectionChanged; // Ajoute cette fonction de callback

  const Footer({Key? key, required this.onSelectionChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.home, color: Colors.white),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => setting_page(
                    onSelectionChanged: onSelectionChanged,
                  ),
                ),
              );
            },
            child: const Icon(Icons.settings, color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => info_page(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); // Début de l'animation hors de l'écran à droite
                    const end = Offset.zero;        // Fin de l'animation, au centre
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: const Icon(Icons.help_outline, color: Colors.white),
          )
        ],
      ),
    );
  }
}
