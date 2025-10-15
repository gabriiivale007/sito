import 'package:flutter/material.dart';
import 'home_page.dart'; // Importa il nuovo file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gabriele Valente - Portfolio',
      theme: ThemeData.dark().copyWith(
        // Imposta un tema scuro di base
        scaffoldBackgroundColor: ModernAppColors.background,
      ),
      debugShowCheckedModeBanner: false,
      home: const ModernHomePage(),
    );
  }
}