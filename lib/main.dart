import 'package:cats_app/screens/home.dart';
import 'package:flutter/material.dart';

// Esta es la función principal que inicia la aplicación.
// runApp() recibe el widget principal de la app.
void main() {
  runApp(const MyApp());
}

// Este widget es la raíz de la aplicación.
// Aquí se configura el MaterialApp, que es el contenedor general de la app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de "debug" en la esquina.
      home: const MyHomePage(), // Indica que la pantalla principal es MyHomePage.
    );
  }
}