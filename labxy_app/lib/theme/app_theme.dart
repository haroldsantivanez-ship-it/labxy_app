import 'package:flutter/cupertino.dart';

/// Tema global de la aplicación (CupertinoThemeData) + estilos reutilizables.
class AppTheme {
  static const Color primario = Color(0xFFE0464F);
  static const Color primarioClaro = Color(0xFFFF7A59);

  static const LinearGradient gradientePrimario = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primarioClaro, primario],
  );

  static CupertinoThemeData tema(bool oscuro) {
    return CupertinoThemeData(
      brightness: oscuro ? Brightness.dark : Brightness.light,
      primaryColor: primario,
      primaryContrastingColor: CupertinoColors.white,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      barBackgroundColor: CupertinoColors.systemGroupedBackground,
      textTheme: const CupertinoTextThemeData(
        primaryColor: primario,
        textStyle: TextStyle(fontSize: 16, color: CupertinoColors.label),
        navTitleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: CupertinoColors.label,
        ),
        navLargeTitleTextStyle: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: CupertinoColors.label,
        ),
      ),
    );
  }

  // ---------- Estilos reutilizables ----------
  static Color label(BuildContext c) => CupertinoColors.label.resolveFrom(c);
  static Color secundario(BuildContext c) => CupertinoColors.secondaryLabel.resolveFrom(c);
  static Color tarjeta(BuildContext c) =>
      CupertinoColors.secondarySystemGroupedBackground.resolveFrom(c);
  static Color relleno(BuildContext c) => CupertinoColors.tertiarySystemFill.resolveFrom(c);

  static const List<BoxShadow> sombraSuave = [
    BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, 8)),
  ];

  static TextStyle tituloSeccion(BuildContext c) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
        color: label(c),
      );
}
