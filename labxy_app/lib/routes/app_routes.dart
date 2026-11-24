import 'package:flutter/cupertino.dart';

import '../screens/acerca_screen.dart';
import '../screens/detalle_screen.dart';
import '../screens/home_screen.dart';

/// Rutas con nombre de la aplicación
class AppRoutes {
  static const String inicio = '/';
  static const String detalle = '/detalle';
  static const String acerca = '/acerca';

  /// Rutas simples (sin argumentos)
  static Map<String, WidgetBuilder> get rutas => {
        inicio: (_) => const HomeScreen(),
        acerca: (_) => const AcercaScreen(),
      };

  /// Rutas que reciben argumentos -> transición estilo iOS (CupertinoPageRoute)
  static Route<dynamic>? generarRuta(RouteSettings settings) {
    if (settings.name == detalle) {
      final args = settings.arguments as Map<String, dynamic>;
      return CupertinoPageRoute(
        settings: settings,
        builder: (_) => DetalleScreen(
          destino: args['destino'] as Map<String, dynamic>,
          heroTag: args['heroTag'] as String,
        ),
      );
    }
    return CupertinoPageRoute(
      builder: (_) => const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Error')),
        child: Center(child: Text('Ruta no encontrada')),
      ),
    );
  }
}
