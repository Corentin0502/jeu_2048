import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:jeu_2048/pages/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      dark: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
          colorScheme: ColorScheme.dark(
            primary: Colors.orange,
            secondary: Colors.blueAccent,
            surface: Colors.black.withOpacity(0.85), // Ajustement de l'opacité
            background: Colors.black.withOpacity(0.87), // Fond moins sombre
        ),
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Jeu du 2048',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        home: const HomePage(),
      ),
    );
  }
}