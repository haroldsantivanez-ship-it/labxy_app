import 'package:flutter/cupertino.dart';

import 'routes/app_routes.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha el modo oscuro para reconstruir la app con el tema global
    return ValueListenableBuilder<bool>(
      valueListenable: AppState.modoOscuro,
      builder: (context, oscuro, _) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          title: 'Destinos Perú',
          theme: AppTheme.tema(oscuro), // TEMA GLOBAL
          initialRoute: AppRoutes.inicio, // RUTAS
          routes: AppRoutes.rutas,
          onGenerateRoute: AppRoutes.generarRuta,
          builder: (context, child) => MarcoCelular(child: child!),
        );
      },
    );
  }
}

/// Cuando la app se abre en una pantalla ancha (Chrome en PC),
/// la muestra dentro de un "celular" centrado. En el celular real no hace nada.
class MarcoCelular extends StatelessWidget {
  final Widget child;
  const MarcoCelular({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < 600) return child;

    final double alto = (size.height - 32).clamp(560.0, 920.0);
    const double ancho = 410; // ancho de un celular normal (+ el borde)

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF3B1C32), Color(0xFF6A1E55)],
        ),
      ),
      child: Center(
        child: Container(
          width: ancho,
          height: alto,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: BorderRadius.circular(48),
            boxShadow: const [
              BoxShadow(color: Color(0x99000000), blurRadius: 50, offset: Offset(0, 25)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(38),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: Size(ancho - 20, alto - 20),
                padding: const EdgeInsets.only(top: 34, bottom: 20),
                viewPadding: const EdgeInsets.only(top: 34, bottom: 20),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
