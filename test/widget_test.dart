import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:catalogo/main.dart';
import 'package:catalogo/providers/catalogo_provider.dart';

void main() {
  testWidgets('la aplicación abre el formulario de inicio de sesión', (
    tester,
  ) async {
    await tester.pumpWidget(const CatalogoSenatiApp());

    expect(find.text('Catálogo SENATI'), findsOneWidget);
    expect(find.text('Correo electrónico'), findsOneWidget);
    expect(find.text('Contraseña'), findsOneWidget);
  });

  testWidgets('valida campos vacíos al intentar iniciar sesión', (
    tester,
  ) async {
    await tester.pumpWidget(const CatalogoSenatiApp());

    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pump();

    expect(find.text('Ingresa tu correo electrónico'), findsOneWidget);
    expect(find.text('Ingresa tu contraseña'), findsOneWidget);
  });

  testWidgets('permite entrar con las credenciales de demostración', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CatalogoProvider(),
        child: const CatalogoSenatiApp(),
      ),
    );

    await tester.enterText(
      find.byKey(const Key('login-email')),
      'demo@senati.edu.pe',
    );
    await tester.enterText(
      find.byKey(const Key('login-password')),
      'Senati123!',
    );
    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pumpAndSettle();

    expect(find.text('Nuevo Componente'), findsOneWidget);
  });

  testWidgets('rechaza credenciales distintas a las de demostración', (
    tester,
  ) async {
    await tester.pumpWidget(const CatalogoSenatiApp());

    await tester.enterText(
      find.byKey(const Key('login-email')),
      'alumno@senati.edu.pe',
    );
    await tester.enterText(
      find.byKey(const Key('login-password')),
      'una-clave',
    );
    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pump();

    expect(find.text('Correo o contraseña incorrectos.'), findsOneWidget);
  });
}
