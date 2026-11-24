import 'package:flutter/cupertino.dart';

import '../data/destinos.dart';
import '../theme/app_theme.dart';
import 'comunes.dart';

/// CARD grande para el carrusel de destacados.
class DestacadoCard extends StatelessWidget {
  final Map<String, dynamic> destino;
  final String heroTag;
  final VoidCallback onTap;

  const DestacadoCard({
    super.key,
    required this.destino,
    required this.heroTag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = destino['color'] as Color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 6, 8, 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.45),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: heroTag,
                child: DestinoArte(
                  destino: destino,
                  borderRadius: BorderRadius.circular(30),
                  iconSize: 76,
                  alineacion: const Alignment(0, -0.35),
                ),
              ),
            ),
            // Sombra inferior para que el texto se lea bien
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.45, 1.0],
                      colors: [Color(0x00000000), Color(0x00000000), Color(0x99000000)],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Vidrio(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.star_fill, size: 14, color: Color(0xFFFFD60A)),
                    const SizedBox(width: 4),
                    Text('${destino['rating']}',
                        style: const TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13)),
                  ],
                ),
              ),
            ),
            Positioned(top: 12, right: 12, child: BotonFavorito(id: destino['id'], vidrio: true)),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (destino['zona'] as String).toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    destino['nombre'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.location_solid,
                          size: 14, color: Color(0xCCFFFFFF)),
                      const SizedBox(width: 4),
                      Text(destino['region'],
                          style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 14)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          soles(destino['precio']),
                          style: TextStyle(
                            color: destino['color2'] as Color,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// CARD horizontal compacta para las listas.
class DestinoTile extends StatelessWidget {
  final Map<String, dynamic> destino;
  final String heroTag;
  final VoidCallback onTap;

  const DestinoTile({
    super.key,
    required this.destino,
    required this.heroTag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.tarjeta(context),
          borderRadius: BorderRadius.circular(22),
          boxShadow: AppTheme.sombraSuave,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 86,
              height: 86,
              child: Hero(
                tag: heroTag,
                child: DestinoArte(
                  destino: destino,
                  borderRadius: BorderRadius.circular(18),
                  iconSize: 34,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          destino['nombre'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.label(context),
                          ),
                        ),
                      ),
                      BotonFavorito(id: destino['id'], size: 20),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(CupertinoIcons.location_solid,
                          size: 13, color: AppTheme.secundario(context)),
                      const SizedBox(width: 3),
                      Text(destino['region'],
                          style: TextStyle(fontSize: 13, color: AppTheme.secundario(context))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // FittedBox: si no hay espacio, achica las píldoras en vez de desbordarse
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Pildora(
                                icono: CupertinoIcons.star_fill,
                                texto: '${destino['rating']}',
                                colorIcono: const Color(0xFFFFB800),
                              ),
                              const SizedBox(width: 6),
                              Pildora(
                                  icono: CupertinoIcons.clock_fill, texto: '${destino['dias']}d'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        soles(destino['precio']),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primario,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
