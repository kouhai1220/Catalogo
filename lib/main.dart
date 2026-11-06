
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/componente.dart';
import 'providers/catalogo_provider.dart';
import 'screens/home_screen.dart';
import 'screens/detalle_screen.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CatalogoProvider(),
      child: const CatalogoSenatiApp(),
    ),
  );
}

class CatalogoSenatiApp extends StatelessWidget {
  const CatalogoSenatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo SENATI',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.tema,

      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final argumento = settings.arguments;

          if (argumento is Componente) {
            return MaterialPageRoute(
              settings: settings,
              builder: (context) {
                return DetalleScreen(
                  componente: argumento,
                );
              },
            );
          }

          return MaterialPageRoute(
            builder: (context) {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'No se recibió un componente válido.',
                  ),
                ),
              );
            },
          );
        }

        return null;
      },
    );
  }
}
