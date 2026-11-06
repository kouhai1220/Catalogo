
import 'package:flutter/material.dart';

class AppTheme {
  // Colores institucionales.
  static const Color azulInstitucional = Color(0xFF003B70);
  static const Color azulOscuro = Color(0xFF052B50);
  static const Color fondo = Color(0xFFF3F5F9);
  static const Color verdePrecio = Color(0xFF35A853);

  static ThemeData get tema {
    return ThemeData(
      useMaterial3: true,

      // Color principal.
      colorScheme: ColorScheme.fromSeed(
        seedColor: azulInstitucional,
        primary: azulInstitucional,
        surface: Colors.white,
      ),

      // Fondo general.
      scaffoldBackgroundColor: fondo,

      // Estilo de la AppBar.
      appBarTheme: const AppBarTheme(
        backgroundColor: azulInstitucional,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Estilo de las tarjetas.
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Estilo de los botones.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: azulInstitucional,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // Estilo de los campos de formulario.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFD0D5DD),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFD0D5DD),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: azulInstitucional,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
