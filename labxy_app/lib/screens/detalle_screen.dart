import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';

import '../data/destinos.dart';
import '../theme/app_theme.dart';
import '../widgets/comunes.dart';

/// Detalle de un destino. Recibe el Map por argumentos de la ruta '/detalle'
class DetalleScreen extends StatelessWidget {
  final Map<String, dynamic> destino;
  final String heroTag;

  const DetalleScreen({super.key, required this.destino, required this.heroTag});

  void _abrirReserva(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => _HojaReserva(
        destino: destino,
        onConfirmar: (personas, total) {
          showCupertinoDialog(
            context: context,
            builder: (c) => CupertinoAlertDialog(
              title: const Text('¡Reserva confirmada! 🎉'),
              content: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${destino['nombre']}\n$personas persona(s) · S/ ${total.toStringAsFixed(0)}',
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () => Navigator.pop(c),
                  child: const Text('Genial'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double arriba = MediaQuery.of(context).padding.top;
    final List<String> actividades = List<String>.from(destino['actividades']);
    final Color c1 = destino['color'] as Color;
    final Color c2 = destino['color2'] as Color;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // ---------- Cabecera grande ----------
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 420,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Hero(
                          tag: heroTag,
                          child: DestinoArte(
                            destino: destino,
                            borderRadius:
                                const BorderRadius.vertical(bottom: Radius.circular(36)),
                            iconSize: 110,
                            alineacion: const Alignment(0, -0.25),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.vertical(bottom: Radius.circular(36)),
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 0.5, 1.0],
                                colors: [
                                  Color(0x33000000),
                                  Color(0x00000000),
                                  Color(0xA6000000),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: arriba + 10,
                        left: 16,
                        child: BotonVidrio(
                          icono: CupertinoIcons.chevron_back,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      Positioned(
                        top: arriba + 10,
                        right: 16,
                        child: BotonFavorito(id: destino['id'], vidrio: true),
                      ),
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Vidrio(
                              child: Text(
                                '${destino['zona']} · ${destino['region']}',
                                style: const TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              destino['nombre'],
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 36,
                                height: 1.05,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (i) => Icon(
                                    i < (destino['rating'] as double).round()
                                        ? CupertinoIcons.star_fill
                                        : CupertinoIcons.star,
                                    size: 16,
                                    color: const Color(0xFFFFD60A),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${destino['rating']} · +2k reseñas',
                                  style: const TextStyle(color: Color(0xDDFFFFFF), fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- Datos rápidos ----------
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: Row(
                    children: [
                      _Dato(icono: CupertinoIcons.clock_fill, valor: '${destino['dias']} días', etiqueta: 'Duración', color: c1),
                      const SizedBox(width: 12),
                      _Dato(icono: CupertinoIcons.arrow_up_circle_fill, valor: destino['altitud'], etiqueta: 'Altitud', color: c1),
                      const SizedBox(width: 12),
                      _Dato(icono: CupertinoIcons.person_2_fill, valor: '2 - 12', etiqueta: 'Grupo', color: c1),
                    ],
                  ),
                ),
              ),

              // ---------- Descripción ----------
              const SliverToBoxAdapter(child: TituloSeccion(titulo: 'Sobre el destino')),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    destino['descripcion'],
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.55,
                      color: AppTheme.secundario(context),
                    ),
                  ),
                ),
              ),

              // ---------- Actividades (CupertinoListTile) ----------
              SliverToBoxAdapter(
                child: TituloSeccion(titulo: 'Qué harás', extra: '${actividades.length} actividades'),
              ),
              SliverToBoxAdapter(
                child: CupertinoListSection.insetGrouped(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: const Color(0x00000000),
                  children: List.generate(actividades.length, (i) {
                    return CupertinoListTile(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leadingSize: 36,
                      leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [c1, c2]),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      title: Text(actividades[i]),
                      trailing: const Icon(CupertinoIcons.checkmark_seal_fill,
                          color: CupertinoColors.activeGreen),
                    );
                  }),
                ),
              ),

              // ---------- Incluye ----------
              const SliverToBoxAdapter(child: TituloSeccion(titulo: 'Incluye')),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      _Incluye(icono: CupertinoIcons.bus, texto: 'Transporte'),
                      _Incluye(icono: CupertinoIcons.person_badge_plus_fill, texto: 'Guía local'),
                      _Incluye(icono: CupertinoIcons.ticket_fill, texto: 'Entradas'),
                      _Incluye(icono: CupertinoIcons.shield_lefthalf_fill, texto: 'Seguro'),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 140)),
            ],
          ),

          // ---------- Barra inferior fija con precio ----------
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24, 16, 24, 16 + MediaQuery.of(context).padding.bottom),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground.resolveFrom(context).withOpacity(0.85),
                    border: Border(
                      top: BorderSide(
                        color: CupertinoColors.separator.resolveFrom(context),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Desde',
                              style: TextStyle(fontSize: 13, color: AppTheme.secundario(context))),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                soles(destino['precio']),
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.label(context),
                                ),
                              ),
                              Text(' /persona',
                                  style: TextStyle(
                                      fontSize: 13, color: AppTheme.secundario(context))),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => _abrirReserva(context),
                        child: Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          decoration: BoxDecoration(
                            gradient: AppTheme.gradientePrimario,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primario.withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Reservar',
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(CupertinoIcons.arrow_right, color: CupertinoColors.white, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dato extends StatelessWidget {
  final IconData icono;
  final String valor;
  final String etiqueta;
  final Color color;

  const _Dato({
    required this.icono,
    required this.valor,
    required this.etiqueta,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: AppTheme.tarjeta(context),
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.sombraSuave,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icono, size: 20, color: color),
            ),
            const SizedBox(height: 10),
            Text(valor,
                style: TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 15, color: AppTheme.label(context))),
            const SizedBox(height: 2),
            Text(etiqueta,
                style: TextStyle(fontSize: 12, color: AppTheme.secundario(context))),
          ],
        ),
      ),
    );
  }
}

class _Incluye extends StatelessWidget {
  final IconData icono;
  final String texto;
  const _Incluye({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.tarjeta(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 18, color: AppTheme.primario),
          const SizedBox(width: 8),
          Text(texto,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.label(context))),
        ],
      ),
    );
  }
}

/// Hoja inferior para reservar: personas + tipo de tour + total
class _HojaReserva extends StatefulWidget {
  final Map<String, dynamic> destino;
  final void Function(int personas, double total) onConfirmar;

  const _HojaReserva({required this.destino, required this.onConfirmar});

  @override
  State<_HojaReserva> createState() => _HojaReservaState();
}

class _HojaReservaState extends State<_HojaReserva> {
  int _personas = 1;
  int _tipo = 0; // 0 = Estándar, 1 = Premium

  double get _total {
    final base = widget.destino['precio'] as double;
    return base * _personas * (_tipo == 1 ? 1.5 : 1.0);
  }

  Widget _botonRedondo(IconData icono, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: onTap == null ? AppTheme.relleno(context) : AppTheme.primario.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icono,
            size: 20,
            color: onTap == null ? AppTheme.secundario(context) : AppTheme.primario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 12, 24, 24 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: AppTheme.relleno(context),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: DestinoArte(
                  destino: widget.destino,
                  borderRadius: BorderRadius.circular(16),
                  iconSize: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reservar viaje',
                        style: TextStyle(fontSize: 13, color: AppTheme.secundario(context))),
                    Text(widget.destino['nombre'],
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.label(context))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text('Tipo de tour',
              style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.label(context))),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<int>(
              groupValue: _tipo,
              children: const {
                0: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Estándar')),
                1: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Premium ✨')),
              },
              onValueChanged: (v) => setState(() => _tipo = v ?? 0),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Text('Personas',
                  style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.label(context))),
              const Spacer(),
              _botonRedondo(CupertinoIcons.minus,
                  _personas > 1 ? () => setState(() => _personas--) : null),
              SizedBox(
                width: 44,
                child: Text('$_personas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.label(context))),
              ),
              _botonRedondo(CupertinoIcons.plus,
                  _personas < 12 ? () => setState(() => _personas++) : null),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.relleno(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text('Total', style: TextStyle(color: AppTheme.secundario(context))),
                const Spacer(),
                Text('S/ ${_total.toStringAsFixed(0)}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.label(context))),
              ],
            ),
          ),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              widget.onConfirmar(_personas, _total);
            },
            child: Container(
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: AppTheme.gradientePrimario,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                'Confirmar reserva',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
