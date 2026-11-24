import 'package:flutter/cupertino.dart';

import '../routes/app_routes.dart';
import '../theme/app_theme.dart';
import 'tabs/ajustes_tab.dart';
import 'tabs/destinos_tab.dart';
import 'tabs/favoritos_tab.dart';
import 'tabs/regiones_tab.dart';

/// Pantalla principal con barra de pestañas inferior estilo iOS
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: AppTheme.primario,
        iconSize: 26,
        height: 56,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.compass),
            activeIcon: Icon(CupertinoIcons.compass_fill),
            label: 'Explorar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map),
            activeIcon: Icon(CupertinoIcons.map_fill),
            label: 'Regiones',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            activeIcon: Icon(CupertinoIcons.heart_fill),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle),
            activeIcon: Icon(CupertinoIcons.person_crop_circle_fill),
            label: 'Perfil',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return const DestinosTab();
              case 1:
                return const RegionesTab();
              case 2:
                return const FavoritosTab();
              default:
                return const AjustesTab();
            }
          },
        );
      },
    );
  }
}

/// Navega a la ruta con nombre '/detalle' usando el Navigator raíz
/// (el que tiene registradas las rutas de CupertinoApp).
void abrirDetalle(BuildContext context, Map<String, dynamic> destino, String heroTag) {
  Navigator.of(context, rootNavigator: true).pushNamed(
    AppRoutes.detalle,
    arguments: {'destino': destino, 'heroTag': heroTag},
  );
}
