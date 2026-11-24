import 'package:flutter/cupertino.dart';

import '../theme/app_theme.dart';

/// Pantalla abierta con la ruta con nombre '/acerca'
class AcercaScreen extends StatelessWidget {
  const AcercaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Acerca de'),
        previousPageTitle: 'Perfil',
        border: null,
      ),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: AppTheme.gradientePrimario,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primario.withOpacity(0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(CupertinoIcons.airplane, size: 52, color: CupertinoColors.white),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text('Destinos Perú',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.label(context),
                  )),
            ),
            Center(
              child: Text('Versión 1.0.0',
                  style: TextStyle(color: AppTheme.secundario(context))),
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('LABORATORIO'),
              children: const [
                CupertinoListTile(
                  title: Text('Curso'),
                  additionalInfo: Text('Apps Móviles Multiplataforma'),
                ),
                CupertinoListTile(
                  title: Text('Institución'),
                  additionalInfo: Text('TECSUP'),
                ),
                CupertinoListTile(
                  title: Text('Widgets'),
                  additionalInfo: Text('Cupertino'),
                ),
                CupertinoListTile(
                  title: Text('Fotos'),
                  additionalInfo: Text('Wikimedia Commons (CC BY-SA)'),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('INTEGRANTES'),
              children: const [
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.person_fill),
                  title: Text('Harold Santivañez Garcia'),
                ),
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.person_fill),
                  title: Text('Integrante 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
