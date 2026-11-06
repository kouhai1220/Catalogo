
class Componente {
  final String id;
  final String nombre;
  final String categoria;
  final double precio;
  final String descripcion;
  final int stock;

  Componente({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.precio,
    required this.descripcion,
    this.stock = 50,
  });

  // Crear una copia del componente con nuevos valores.
  Componente copyWith({
    String? id,
    String? nombre,
    String? categoria,
    double? precio,
    String? descripcion,
    int? stock,
  }) {
    return Componente(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      precio: precio ?? this.precio,
      descripcion: descripcion ?? this.descripcion,
      stock: stock ?? this.stock,
    );
  }
}
