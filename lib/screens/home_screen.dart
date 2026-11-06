
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/componente.dart';
import '../providers/catalogo_provider.dart';
import '../widgets/categoria_chip.dart';
import '../widgets/componente_card.dart';
import '../widgets/formulario_componente.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Abrir el formulario modal.
  void abrirFormulario(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return const FormularioComponente();
      },
    );
  }

  // Navegar hacia la ficha técnica.
  void abrirDetalle(
    BuildContext context,
    Componente componente,
  ) {
    Navigator.pushNamed(
      context,
      '/details',
      arguments: componente,
    );
  }

  @override
  Widget build(BuildContext context) {
    final catalogo = context.watch<CatalogoProvider>();

    final componentes = catalogo.componentesFiltrados;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo SENATI'),
        actions: [
          IconButton(
            tooltip: 'Buscar componente',
            onPressed: () {
              showSearch(
                context: context,
                delegate: BusquedaComponentes(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado institucional.
          Container(
            width: double.infinity,
            color: const Color(0xFF003B70),
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              12,
            ),
            child: const Text(
              'Seleccione una categoría o toque un componente '
              'para ver su ficha técnica:',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ),

          // Filtros horizontales.
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              itemCount: catalogo.categorias.length,
              itemBuilder: (context, index) {
                final categoria =
                    catalogo.categorias[index];

                return CategoriaChip(
                  categoria: categoria,
                  seleccionada:
                      catalogo.categoriaSeleccionada ==
                      categoria,
                  onTap: () {
                    catalogo.seleccionarCategoria(
                      categoria,
                    );
                  },
                );
              },
            ),
          ),

          // Lista dinámica de componentes.
          Expanded(
            child: componentes.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 12),

                        Text(
                          'No se encontraron componentes.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 90,
                    ),
                    itemCount: componentes.length,
                    itemBuilder: (context, index) {
                      final componente =
                          componentes[index];

                      return ComponenteCard(
                        componente: componente,
                        onTap: () {
                          abrirDetalle(
                            context,
                            componente,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),

      // Botón flotante para registrar componentes.
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          abrirFormulario(context);
        },
        backgroundColor: const Color(0xFF003B70),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Componente'),
      ),
    );
  }
}

// ======================================================
// BUSCADOR DE COMPONENTES
// ======================================================

class BusquedaComponentes extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Buscar componente...';

  // Botón para limpiar la búsqueda.
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Limpiar búsqueda',
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  // Botón para regresar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Volver',
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // Mostrar resultados de búsqueda.
  @override
  Widget buildResults(BuildContext context) {
    final catalogo = context.read<CatalogoProvider>();

    final resultados = catalogo.componentes.where(
      (componente) {
        return componente.nombre
            .toLowerCase()
            .contains(query.toLowerCase());
      },
    ).toList();

    return _crearListaResultados(
      context,
      resultados,
    );
  }

  // Mostrar sugerencias mientras se escribe.
  @override
  Widget buildSuggestions(BuildContext context) {
    final catalogo = context.watch<CatalogoProvider>();

    final resultados = catalogo.componentes.where(
      (componente) {
        return componente.nombre
            .toLowerCase()
            .contains(query.toLowerCase());
      },
    ).toList();

    return _crearListaResultados(
      context,
      resultados,
    );
  }

  // Construir la lista de resultados.
  Widget _crearListaResultados(
    BuildContext context,
    List<Componente> resultados,
  ) {
    if (resultados.isEmpty) {
      return const Center(
        child: Text(
          'No se encontraron componentes.',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        final componente = resultados[index];

        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFE5F0FC),
            child: Icon(
              Icons.computer,
              color: Color(0xFF003B70),
            ),
          ),

          title: Text(
            componente.nombre,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          subtitle: Text(
            componente.categoria,
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'S/ ${componente.precio.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFF35A853),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 4),

              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),

          onTap: () {
            Navigator.pushNamed(
              context,
              '/details',
              arguments: componente,
            );
          },
        );
      },
    );
  }
}
