# labxy – Destinos del Perú (Flutter + Cupertino)

Versión del laboratorio de la semana 8 hecha principalmente con widgets **Cupertino** (estilo iOS).

## Cómo ejecutarlo

```bash
flutter create labxy          # crea las carpetas android/ios/web
# reemplazar la carpeta lib/ y el pubspec.yaml por los de este proyecto
cd labxy
flutter pub get
flutter run
```

## Estructura

```
lib/
├── main.dart                  -> CupertinoApp, tema global y rutas
├── theme/app_theme.dart       -> CupertinoThemeData (claro / oscuro)
├── routes/app_routes.dart     -> rutas con nombre + onGenerateRoute (CupertinoPageRoute)
├── data/destinos.dart         -> List<Map<String, dynamic>> y Map agrupado por región
├── state/app_state.dart       -> ValueNotifier para modo oscuro y favoritos
├── widgets/destino_card.dart  -> Card estilo iOS (Container + BoxDecoration)
└── screens/
    ├── home_screen.dart       -> CupertinoTabScaffold + CupertinoTabBar
    ├── detalle_screen.dart    -> detalle (recibe el Map por argumentos)
    ├── acerca_screen.dart     -> pantalla abierta con ruta '/acerca'
    └── tabs/
        ├── destinos_tab.dart  -> ListView.builder de Cards, búsqueda y orden
        ├── regiones_tab.dart  -> CupertinoListSection + CupertinoListTile (Mapa)
        ├── favoritos_tab.dart -> lista de favoritos
        └── ajustes_tab.dart   -> CupertinoSwitch para cambiar el tema global
```

## Equivalencias Material → Cupertino

| Tema del lab   | Material (semana 8)      | Cupertino (este lab)                                  |
|----------------|--------------------------|-------------------------------------------------------|
| App            | MaterialApp              | CupertinoApp                                          |
| Tema global    | ThemeData                | CupertinoThemeData                                    |
| Pantalla       | Scaffold + AppBar        | CupertinoPageScaffold + CupertinoNavigationBar        |
| Navegación inf.| BottomNavigationBar      | CupertinoTabScaffold + CupertinoTabBar                |
| ListView       | ListView.builder         | ListView.builder (es neutral, se usa igual)           |
| ListTile       | ListTile                 | CupertinoListTile + CupertinoListSection              |
| Card           | Card                     | Container con BoxDecoration (Cupertino no tiene Card) |
| Rutas          | MaterialPageRoute        | CupertinoPageRoute + rutas con nombre                 |
| Diálogo        | AlertDialog              | CupertinoAlertDialog                                  |
| Menú inferior  | BottomSheet              | CupertinoActionSheet                                  |
| Switch         | Switch                   | CupertinoSwitch                                       |
| Botón          | ElevatedButton           | CupertinoButton.filled                                |
| Búsqueda       | TextField                | CupertinoSearchTextField                              |
