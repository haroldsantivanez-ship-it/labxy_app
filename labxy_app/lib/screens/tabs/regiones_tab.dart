import 'package:flutter/cupertino.dart';

import '../../data/destinos.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';
import '../home_screen.dart';

/// Pestaña "Regiones": Mapa región -> destinos, mostrado con
/// CupertinoListSection + CupertinoListTile (equivalente iOS de ListTile)
class RegionesTab extends StatelessWidget {
  const RegionesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> mapa = destinosPorRegion();
    final regiones = mapa.keys.toList()..sort();

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(largeTitle: Text('Regiones'), border: null),

          // Resumen en tarjeta con degradado
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 4, 20, 4),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: AppTheme.gradientePrimario,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primario.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _Resumen(valor: '${destinos.length}', etiqueta: 'Destinos'),
                  _Resumen(valor: '${regiones.length}', etiqueta: 'Regiones'),
                  _Resumen(valor: '${zonas.length - 1}', etiqueta: 'Zonas'),
                ],
              ),
            ),
          ),

          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final region = regiones[i];
                  final items = mapa[region]!;
                  return CupertinoListSection.insetGrouped(
                    header: Row(
                      children: [
                        Text(region,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.label(context),
                            )),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.primario.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('${items.length}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.primario,
                              )),
                        ),
                      ],
                    ),
                    children: items.map((d) {
                      return CupertinoListTile(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        leadingSize: 54,
                        leadingToTitle: 14,
                        leading: Hero(
                          tag: 'region-${d['id']}',
                          child: DestinoArte(
                            destino: d,
                            borderRadius: BorderRadius.circular(14),
                            iconSize: 24,
                          ),
                        ),
                        title: Text(d['nombre'],
                            style: const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: Text('${d['zona']} · ${d['dias']} día(s) · ★ ${d['rating']}'),
                        additionalInfo: Text(soles(d['precio']),
                            style: const TextStyle(
                                color: AppTheme.primario, fontWeight: FontWeight.w700)),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () => abrirDetalle(context, d, 'region-${d['id']}'),
                      );
                    }).toList(),
                  );
                },
                childCount: regiones.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Resumen extends StatelessWidget {
  final String valor;
  final String etiqueta;
  const _Resumen({required this.valor, required this.etiqueta});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(valor,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              )),
          Text(etiqueta, style: const TextStyle(color: Color(0xDDFFFFFF), fontSize: 13)),
        ],
      ),
    );
  }
}
