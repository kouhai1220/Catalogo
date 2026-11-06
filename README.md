# Catálogo SENATI

Aplicación Flutter para consultar y administrar un catálogo de componentes.

## Inicio de sesión

Al iniciar la aplicación, se muestra la pantalla de acceso (`/login`). El
formulario valida que el correo tenga un formato válido y que la contraseña no
esté vacía. Para ingresar al catálogo, las credenciales de demostración son:

- **Correo:** `demo@senati.edu.pe`
- **Contraseña:** `Senati123!`

El acceso compara las credenciales localmente en `lib/screens/login_screen.dart`.
Si son correctas, reemplaza la pantalla de acceso por la ruta `/home`; si no,
muestra un mensaje de error. La pantalla usa el tema institucional definido en
`lib/theme/app_theme.dart`.

**Importante:** este inicio de sesión es solo para demostración. No utiliza un
backend, no crea sesiones seguras y las credenciales están incluidas en el
código de la aplicación. No debe usarse para proteger datos reales.

## Pruebas

Ejecuta `flutter test` para verificar la presentación del formulario, la
validación de campos y el acceso con las credenciales de demostración.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
