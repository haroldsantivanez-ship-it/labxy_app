import 'package:flutter/cupertino.dart';

import '../../data/destinos.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../../widgets/destino_card.dart';
import '../home_screen.dart';

/// Pestaña "Explorar": carrusel de destacados, filtros por zona,
/// búsqueda, orden y lista de destinos.
class DestinosTab extends StatefulWidget {
  const DestinosTab({super.key});

  @override
  State<DestinosTab> createState() => _DestinosTabState();
}

class _DestinosTabState extends State<DestinosTab> {
  final PageController _carrusel = PageController(viewportFraction: 0.82);
  String _busqueda = '';
  String _zona = 'Todas';
  String _orden = 'rating';
  int _pagina = 0;

  @override
  void dispose() {
    _carrusel.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _destacados {
    final lista = [...destinos];
    lista.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
    return lista.take(5).toList();
  }

  List<Map<String, dynamic>> get _filtrados {
    final q = _busqueda.toLowerCase();
    final lista = destinos.where((d) {
      final coincideZona = _zona == 'Todas' || d['zona'] == _zona;
      final coincideTexto = d['nombre'].toString().toLowerCase().contains(q) ||
          d['region'].toString().toLowerCase().contains(q);
      return coincideZona && coincideTexto;
    }).toList();

    switch (_orden) {
      case 'precio':
        lista.sort((a, b) => (a['precio'] as double).compareTo(b['precio'] as double));
        break;
      case 'nombre':
        lista.sort((a, b) => a['nombre'].toString().compareTo(b['nombre'].toString()));
        break;
      default:
        lista.sort((a, b) => (b['rating'] as double).compareTo(a['rating'] as double));
    }
    return lista;
  }

  void _mostrarOrden() {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: const Text('Ordenar destinos por'),
        actions: [
          _opcion(ctx, 'Mejor calificación', 'rating'),
          _opcion(ctx, 'Precio (menor a mayor)', 'precio'),
          _opcion(ctx, 'Nombre (A-Z)', 'nombre'),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  CupertinoActionSheetAction _opcion(BuildContext ctx, String texto, String valor) {
    return CupertinoActionSheetAction(
      isDefaultAction: _orden == valor,
      onPressed: () {
        setState(() => _orden = valor);
        Navigator.pop(ctx);
      },
      child: Text(texto),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lista = _filtrados;
    final mostrarDestacados = _busqueda.isEmpty && _zona == 'Todas';

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Explorar'),
            border: null,
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _mostrarOrden,
              child: const Icon(CupertinoIcons.slider_horizontal_3),
            ),
          ),

          // Saludo + buscador
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿A dónde viajamos hoy? ✈️',
                    style: TextStyle(fontSize: 16, color: AppTheme.secundario(context)),
                  ),
                  const SizedBox(height: 14),
                  CupertinoSearchTextField(
                    placeholder: 'Buscar destino o región',
                    borderRadius: BorderRadius.circular(14),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    backgroundColor: AppTheme.tarjeta(context),
                    onChanged: (v) => setState(() => _busqueda = v),
                  ),
                ],
              ),
            ),
          ),

          // Filtros por zona (ListView horizontal)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 64,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                itemCount: zonas.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final nombre = zonas.keys.elementAt(i);
                  return _ChipZona(
                    texto: nombre,
                    icono: zonas[nombre]!,
                    activo: _zona == nombre,
                    onTap: () => setState(() => _zona = nombre),
                  );
                },
              ),
            ),
          ),

          // Carrusel de destacados
          if (mostrarDestacados) ...[
            const SliverToBoxAdapter(child: TituloSeccion(titulo: 'Destacados', extra: 'Top 5')),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 320,
                child: PageView.builder(
                  controller: _carrusel,
                  itemCount: _destacados.length,
                  onPageChanged: (p) => setState(() => _pagina = p),
                  itemBuilder: (context, i) {
                    final d = _destacados[i];
                    return AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: i == _pagina ? 1.0 : 0.92,
                      child: DestacadoCard(
                        destino: d,
                        heroTag: 'destacado-${d['id']}',
                        onTap: () => abrirDetalle(context, d, 'destacado-${d['id']}'),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_destacados.length, (i) {
                  final activo = i == _pagina;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: activo ? 22 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: activo ? AppTheme.primario : AppTheme.relleno(context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ],

          SliverToBoxAdapter(
            child: TituloSeccion(
              titulo: mostrarDestacados ? 'Todos los destinos' : 'Resultados',
              extra: '${lista.length} lugares',
            ),
          ),

          if (lista.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(CupertinoIcons.search, size: 48, color: AppTheme.secundario(context)),
                    const SizedBox(height: 10),
                    Text('No encontramos destinos',
                        style: TextStyle(color: AppTheme.secundario(context))),
                  ],
                ),
              ),
            ),

          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final d = lista[i];
                  return DestinoTile(
                    destino: d,
                    heroTag: 'lista-${d['id']}',
                    onTap: () => abrirDetalle(context, d, 'lista-${d['id']}'),
                  );
                },
                childCount: lista.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _ChipZona extends StatelessWidget {
  final String texto;
  final IconData icono;
  final bool activo;
  final VoidCallback onTap;

  const _ChipZona({
    required this.texto,
    required this.icono,
    required this.activo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: activo ? AppTheme.gradientePrimario : null,
          color: activo ? null : AppTheme.tarjeta(context),
          borderRadius: BorderRadius.circular(22),
          boxShadow: activo
              ? [
                  BoxShadow(
                    color: AppTheme.primario.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : AppTheme.sombraSuave,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono,
                size: 16,
                color: activo ? CupertinoColors.white : AppTheme.secundario(context)),
            const SizedBox(width: 6),
            Text(
              texto,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: activo ? CupertinoColors.white : AppTheme.label(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
