import 'package:flutter/cupertino.dart';

import '../../data/destinos.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/destino_card.dart';
import '../home_screen.dart';

/// Pestaña "Favoritos": se actualiza sola con ValueListenableBuilder
class FavoritosTab extends StatelessWidget {
  const FavoritosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<Set<int>>(
        valueListenable: AppState.favoritos,
        builder: (context, favs, _) {
          final lista = favs.map(destinoPorId).toList();
          final total = lista.fold<double>(0, (s, d) => s + (d['precio'] as double));

          return CustomScrollView(
            slivers: [
              const CupertinoSliverNavigationBar(largeTitle: Text('Favoritos'), border: null),
              if (lista.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            gradient: AppTheme.gradientePrimario,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primario.withOpacity(0.35),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(CupertinoIcons.heart_fill,
                              size: 50, color: CupertinoColors.white),
                        ),
                        const SizedBox(height: 24),
                        Text('Tu lista está vacía',
                            style: AppTheme.tituloSeccion(context)),
                        const SizedBox(height: 8),
                        Text(
                          'Toca el ❤️ en cualquier destino para guardarlo aquí y planear tu próximo viaje.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, height: 1.4, color: AppTheme.secundario(context)),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                // Tarjeta resumen
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF2B2E4A), Color(0xFF1A1A2E)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tu próximo viaje',
                                style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 13)),
                            const SizedBox(height: 4),
                            Text('S/ ${total.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                )),
                            Text('${lista.length} destino(s) guardados',
                                style: const TextStyle(color: Color(0xAAFFFFFF), fontSize: 13)),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: const BoxDecoration(
                            gradient: AppTheme.gradientePrimario,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(CupertinoIcons.airplane,
                              color: CupertinoColors.white, size: 28),
                        ),
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
                          heroTag: 'fav-${d['id']}',
                          onTap: () => abrirDetalle(context, d, 'fav-${d['id']}'),
                        );
                      },
                      childCount: lista.length,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
