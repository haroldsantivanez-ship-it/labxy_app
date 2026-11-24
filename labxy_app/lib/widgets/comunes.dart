import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';

/// Arte del destino: degradado + círculos decorativos + ícono grande.
class DestinoArte extends StatelessWidget {
  final Map<String, dynamic> destino;
  final BorderRadius borderRadius;
  final double iconSize;
  final Alignment alineacion;

  const DestinoArte({
    super.key,
    required this.destino,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.iconSize = 64,
    this.alineacion = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final Color c1 = destino['color'] as Color;
    final Color c2 = destino['color2'] as Color;
    final IconData icono = destino['icono'] as IconData;

    return ClipRRect(
      borderRadius: borderRadius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [c1, c2],
          ),
        ),
        child: LayoutBuilder(builder: (context, box) {
          final double s = box.maxWidth < box.maxHeight ? box.maxWidth : box.maxHeight;
          final bool tieneFoto = destino['imagen'] != null;
          return Stack(
            fit: StackFit.expand,
            children: [
              // Decoración (solo si el lugar no tiene foto)
              if (!tieneFoto) ...[
              Positioned(top: -s * 0.35, right: -s * 0.25, child: _circulo(s * 0.9, 0.10)),
              Positioned(bottom: -s * 0.5, left: -s * 0.3, child: _circulo(s * 1.0, 0.07)),
              Positioned(top: s * 0.14, left: s * 0.10, child: _circulo(s * 0.16, 0.14)),
              Positioned(
                right: -iconSize * 0.5,
                bottom: -iconSize * 0.4,
                child: Icon(icono, size: iconSize * 2.6, color: const Color(0x1AFFFFFF)),
              ),
              Align(
                alignment: alineacion,
                child: Icon(icono, size: iconSize, color: const Color(0xF2FFFFFF)),
              ),
              ],
              // FOTO REAL del lugar (se descarga de internet).
              // Mientras carga, o si no hay internet, se ve el degradado de arriba.
              if (tieneFoto)
                Image.network(
                  destino['imagen'] as String,
                  fit: BoxFit.cover,
                  frameBuilder: (context, child, frame, sincrono) {
                    if (sincrono) return child;
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: child,
                    );
                  },
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _circulo(double d, double opacidad) => Container(
        width: d,
        height: d,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CupertinoColors.white.withOpacity(opacidad),
        ),
      );
}

/// Contenedor con efecto vidrio (blur).
class Vidrio extends StatelessWidget {
  final Widget child;
  final double radio;
  final EdgeInsets padding;
  final double opacidad;

  const Vidrio({
    super.key,
    required this.child,
    this.radio = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.opacidad = 0.22,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radio),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: CupertinoColors.white.withOpacity(opacidad),
            borderRadius: BorderRadius.circular(radio),
            border: Border.all(color: CupertinoColors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Botón circular de vidrio (atrás, compartir, etc.)
class BotonVidrio extends StatelessWidget {
  final IconData icono;
  final VoidCallback onTap;
  final Color color;

  const BotonVidrio({
    super.key,
    required this.icono,
    required this.onTap,
    this.color = CupertinoColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Vidrio(
        radio: 22,
        padding: const EdgeInsets.all(10),
        child: Icon(icono, size: 22, color: color),
      ),
    );
  }
}

/// Corazón de favorito animado (se actualiza solo).
class BotonFavorito extends StatelessWidget {
  final int id;
  final bool vidrio;
  final double size;

  const BotonFavorito({super.key, required this.id, this.vidrio = false, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<int>>(
      valueListenable: AppState.favoritos,
      builder: (context, favs, _) {
        final fav = favs.contains(id);
        final icono = AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
          child: Icon(
            fav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            key: ValueKey(fav),
            size: size,
            color: fav
                ? const Color(0xFFFF375F)
                : (vidrio ? CupertinoColors.white : AppTheme.secundario(context)),
          ),
        );
        return GestureDetector(
          onTap: () => AppState.alternarFavorito(id),
          behavior: HitTestBehavior.opaque,
          child: vidrio
              ? Vidrio(radio: 22, padding: const EdgeInsets.all(10), child: icono)
              : Padding(padding: const EdgeInsets.all(4), child: icono),
        );
      },
    );
  }
}

/// Píldora pequeña con ícono y texto
class Pildora extends StatelessWidget {
  final IconData icono;
  final String texto;
  final Color? colorIcono;

  const Pildora({super.key, required this.icono, required this.texto, this.colorIcono});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.relleno(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 12, color: colorIcono ?? AppTheme.secundario(context)),
          const SizedBox(width: 4),
          Text(texto,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.label(context))),
        ],
      ),
    );
  }
}

/// Título de sección: "Destacados ........ Ver todo"
class TituloSeccion extends StatelessWidget {
  final String titulo;
  final String? extra;

  const TituloSeccion({super.key, required this.titulo, this.extra});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(titulo, style: AppTheme.tituloSeccion(context)),
          const Spacer(),
          if (extra != null)
            Text(extra!,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.primario)),
        ],
      ),
    );
  }
}

/// Ícono cuadrado de color estilo Ajustes de iOS
class IconoAjuste extends StatelessWidget {
  final IconData icono;
  final Color color;
  const IconoAjuste({super.key, required this.icono, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Icon(icono, size: 18, color: CupertinoColors.white),
    );
  }
}
