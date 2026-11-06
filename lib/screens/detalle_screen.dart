
import 'package:flutter/material.dart';

import '../models/componente.dart';

class DetalleScreen extends StatelessWidget {
  final Componente componente;

  const DetalleScreen({
    super.key,
    required this.componente,
  });

  IconData obtenerIcono(String categoria) {
    switch (categoria) {
      case 'Hardware':
        return Icons.memory;
      case 'Procesadores':
        return Icons.developer_board;
      case 'Almacenamiento':
        return Icons.storage;
      case 'Periféricos':
        return Icons.devices;
      default:
        return Icons.computer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(componente.nombre),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Ícono principal.
                    CircleAvatar(
                      radius: 42,
                      backgroundColor:
                          const Color(0xFF003B70),
                      child: Icon(
                        obtenerIcono(componente.categoria),
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Ficha técnica.
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    componente.nombre,
                                    style: const TextStyle(
                                      color:
                                          Color(0xFF003B70),
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Chip(
                                  avatar: const Icon(
                                    Icons.category,
                                    size: 14,
                                  ),
                                  label: Text(
                                    componente.categoria,
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  backgroundColor:
                                      const Color(0xFFE5F0FC),
                                ),
                              ],
                            ),

                            const Divider(height: 28),

                            const Text(
                              'Ficha Técnica y Descripción:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              componente.descripcion,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Precio y stock.
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFE8F5E9),
                                border: Border.all(
                                  color:
                                      const Color(0xFFB7DFBD),
                                ),
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Precio estimado:',
                                          style: TextStyle(
                                            color:
                                                Colors.black54,
                                            fontSize: 11,
                                          ),
                                        ),

                                        SizedBox(height: 4),

                                        Text(
                                          'Stock disponible en almacén',
                                          style: TextStyle(
                                            color:
                                                Color(0xFF35A853),
                                            fontSize: 11,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text(
                                    'S/ ${componente.precio.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color:
                                          Color(0xFF35A853),
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Cantidad disponible.
                            Row(
                              children: [
                                const Icon(
                                  Icons.inventory_2_outlined,
                                  color: Color(0xFF003B70),
                                  size: 18,
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  'Cantidad disponible: ${componente.stock} unidades',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Botón inferior.
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                16,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text(
                    'Volver al Catálogo',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
