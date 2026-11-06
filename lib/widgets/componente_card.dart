
import 'package:flutter/material.dart';

import '../models/componente.dart';

class ComponenteCard extends StatelessWidget {
  final Componente componente;
  final VoidCallback onTap;

  const ComponenteCard({
    super.key,
    required this.componente,
    required this.onTap,
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
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: Row(
            children: [
              // Ícono del componente.
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF003B70),
                child: Icon(
                  obtenerIcono(componente.categoria),
                  color: Colors.white,
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              // Nombre y categoría.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      componente.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5F0FC),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        componente.categoria,
                        style: const TextStyle(
                          color: Color(0xFF003B70),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Precio.
              Text(
                'S/ ${componente.precio.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFF35A853),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),

              const SizedBox(width: 4),

              // Flecha de navegación.
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
