
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/catalogo_provider.dart';

class FormularioComponente extends StatefulWidget {
  const FormularioComponente({super.key});

  @override
  State<FormularioComponente> createState() =>
      _FormularioComponenteState();
}

class _FormularioComponenteState
    extends State<FormularioComponente> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _descripcionController = TextEditingController();

  String _categoriaSeleccionada = 'Hardware';

  final List<String> _categorias = [
    'Hardware',
    'Procesadores',
    'Almacenamiento',
    'Periféricos',
  ];

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    _descripcionController.dispose();

    super.dispose();
  }

  void guardarComponente() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final nombre = _nombreController.text.trim();
    final precio = double.parse(
      _precioController.text.trim(),
    );
    final descripcion = _descripcionController.text.trim();

    context.read<CatalogoProvider>().agregarComponente(
      nombre: nombre,
      categoria: _categoriaSeleccionada,
      precio: precio,
      descripcion: descripcion,
    );

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Componente registrado correctamente'),
        backgroundColor: Color(0xFF35A853),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Encabezado.
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Registrar Nuevo Componente',
                      style: TextStyle(
                        color: Color(0xFF003B70),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const Divider(),

              const SizedBox(height: 8),

              // Nombre.
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.computer),
                  hintText: 'Nombre del Componente',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el nombre del componente';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Categoría.
              DropdownButtonFormField<String>(
                value: _categoriaSeleccionada,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.category),
                  labelText: 'Categoría',
                ),
                items: _categorias.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _categoriaSeleccionada = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 10),

              // Precio.
              TextFormField(
                controller: _precioController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.attach_money),
                  hintText: 'Precio (Ej. S/ 450.00)',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el precio';
                  }

                  final precio = double.tryParse(
                    value.trim(),
                  );

                  if (precio == null || precio < 0) {
                    return 'Ingrese un precio válido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 10),

              // Descripción técnica.
              TextFormField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Descripción Técnica',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese la descripción técnica';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Botón de registro.
              ElevatedButton.icon(
                onPressed: guardarComponente,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Componente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
