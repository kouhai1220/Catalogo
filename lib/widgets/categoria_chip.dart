
import 'package:flutter/material.dart';

class CategoriaChip extends StatelessWidget {
  final String categoria;
  final bool seleccionada;
  final VoidCallback onTap;

  const CategoriaChip({
    super.key,
    required this.categoria,
    required this.seleccionada,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: ChoiceChip(
        label: Text(categoria),
        selected: seleccionada,
        onSelected: (_) => onTap(),
        showCheckmark: false,
        labelStyle: TextStyle(
          color: seleccionada
              ? Colors.white
              : const Color(0xFF003B70),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        selectedColor: const Color(0xFF003B70),
        backgroundColor: Colors.white,
        side: BorderSide(
          color: seleccionada
              ? const Color(0xFF003B70)
              : const Color(0xFFD0D5DD),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
