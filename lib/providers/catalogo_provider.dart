
import 'package:flutter/material.dart';

import '../data/componentes_iniciales.dart';
import '../models/componente.dart';

class CatalogoProvider extends ChangeNotifier {
  // Lista principal de componentes.
  final List<Componente> _componentes = [
    ...componentesIniciales,
  ];

  // Categoría seleccionada actualmente.
  String _categoriaSeleccionada = 'Todos';

  // Texto ingresado en el buscador.
  String _textoBusqueda = '';

  // Categorías disponibles para los filtros.
  final List<String> _categorias = [
    'Todos',
    'Hardware',
    'Procesadores',
    'Almacenamiento',
    'Periféricos',
  ];

  // Obtener las categorías.
  List<String> get categorias => _categorias;

  // Obtener la categoría seleccionada.
  String get categoriaSeleccionada => _categoriaSeleccionada;

  // Obtener todos los componentes.
  List<Componente> get componentes => List.unmodifiable(_componentes);

  // Obtener componentes filtrados.
  List<Componente> get componentesFiltrados {
    return _componentes.where((componente) {
      final coincideCategoria =
          _categoriaSeleccionada == 'Todos' ||
          componente.categoria == _categoriaSeleccionada;

      final coincideBusqueda = componente.nombre
          .toLowerCase()
          .contains(_textoBusqueda.toLowerCase());

      return coincideCategoria && coincideBusqueda;
    }).toList();
  }

  // Cambiar la categoría seleccionada.
  void seleccionarCategoria(String categoria) {
    _categoriaSeleccionada = categoria;
    notifyListeners();
  }

  // Actualizar el texto de búsqueda.
  void buscarComponente(String texto) {
    _textoBusqueda = texto;
    notifyListeners();
  }

  // Registrar un nuevo componente.
  void agregarComponente({
    required String nombre,
    required String categoria,
    required double precio,
    required String descripcion,
  }) {
    final nuevoComponente = Componente(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      nombre: nombre,
      categoria: categoria,
      precio: precio,
      descripcion: descripcion,
      stock: 50,
    );

    _componentes.add(nuevoComponente);

    // Regresar a la categoría Todos para mostrar el nuevo registro.
    _categoriaSeleccionada = 'Todos';

    // Limpiar la búsqueda.
    _textoBusqueda = '';

    // Actualizar la interfaz.
    notifyListeners();
  }
}
