import 'package:flutter/cupertino.dart';

import '../../data/destinos.dart';
import '../../routes/app_routes.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/comunes.dart';

/// Pestaña "Perfil / Ajustes". Cambia el TEMA GLOBAL (claro/oscuro)
class AjustesTab extends StatelessWidget {
  const AjustesTab({super.key});

  void _confirmarLimpiar(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Limpiar favoritos'),
        content: const Text('¿Seguro que quieres borrar todos tus favoritos?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              AppState.limpiarFavoritos();
              Navigator.pop(ctx);
            },
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(largeTitle: Text('Perfil'), border: null),

          // Tarjeta de perfil
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 4, 20, 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppTheme.gradientePrimario,
                // Foto de portada (Machu Picchu) oscurecida para que se lea el texto
                image: DecorationImage(
                  image: const NetworkImage(fotoPortada),
                  fit: BoxFit.cover,
                  colorFilter: const ColorFilter.mode(Color(0x8C000000), BlendMode.darken),
                  onError: (_, __) {},
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primario.withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // FOTO DE PERFIL: pon tu foto en assets/perfil.jpg
                      Container(
                        width: 72,
                        height: 72,
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppTheme.gradientePrimario,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/perfil.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFF2B2E4A),
                              alignment: Alignment.center,
                              child: const Text('HS',
                                  style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Harold Santivañez',
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                )),
                            SizedBox(height: 2),
                            Text('Viajero explorador 🌎',
                                style: TextStyle(color: Color(0xDDFFFFFF), fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ValueListenableBuilder<Set<int>>(
                    valueListenable: AppState.favoritos,
                    builder: (context, favs, _) => Vidrio(
                      radio: 18,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          _Stat(valor: '${favs.length}', etiqueta: 'Favoritos'),
                          _Stat(valor: '${destinos.length}', etiqueta: 'Destinos'),
                          const _Stat(valor: '4.9', etiqueta: 'Nivel'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                CupertinoListSection.insetGrouped(
                  header: const Text('APARIENCIA'),
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: AppState.modoOscuro,
                      builder: (context, oscuro, _) => CupertinoListTile(
                        leading: const IconoAjuste(
                            icono: CupertinoIcons.moon_fill, color: Color(0xFF5856D6)),
                        title: const Text('Modo oscuro'),
                        trailing: CupertinoSwitch(
                          value: oscuro,
                          activeTrackColor: AppTheme.primario,
                          onChanged: (v) => AppState.modoOscuro.value = v,
                        ),
                      ),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: const Text('MIS DATOS'),
                  children: [
                    ValueListenableBuilder<Set<int>>(
                      valueListenable: AppState.favoritos,
                      builder: (context, favs, _) => CupertinoListTile(
                        leading: const IconoAjuste(
                            icono: CupertinoIcons.heart_fill, color: Color(0xFFFF2D55)),
                        title: const Text('Favoritos guardados'),
                        additionalInfo: Text('${favs.length}'),
                      ),
                    ),
                    CupertinoListTile(
                      leading: const IconoAjuste(
                          icono: CupertinoIcons.trash_fill, color: Color(0xFFFF3B30)),
                      title: const Text('Limpiar favoritos'),
                      onTap: () => _confirmarLimpiar(context),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: const Text('INFORMACIÓN'),
                  children: [
                    CupertinoListTile(
                      leading: const IconoAjuste(
                          icono: CupertinoIcons.info, color: Color(0xFF007AFF)),
                      title: const Text('Acerca de la app'),
                      trailing: const CupertinoListTileChevron(),
                      // Ruta con nombre registrada en CupertinoApp.routes
                      onTap: () => Navigator.of(context, rootNavigator: true)
                          .pushNamed(AppRoutes.acerca),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String valor;
  final String etiqueta;
  const _Stat({required this.valor, required this.etiqueta});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(valor,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              )),
          Text(etiqueta, style: const TextStyle(color: Color(0xDDFFFFFF), fontSize: 12)),
        ],
      ),
    );
  }
}
