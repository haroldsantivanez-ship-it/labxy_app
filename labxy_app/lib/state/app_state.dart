import 'package:flutter/foundation.dart';

/// Estado global sencillo de la app.
class AppState {
  /// true = tema oscuro, false = tema claro
  static final ValueNotifier<bool> modoOscuro = ValueNotifier<bool>(false);

  /// ids de los destinos marcados como favoritos
  static final ValueNotifier<Set<int>> favoritos = ValueNotifier<Set<int>>({});

  static bool esFavorito(int id) => favoritos.value.contains(id);

  static void alternarFavorito(int id) {
    final nuevo = Set<int>.from(favoritos.value);
    nuevo.contains(id) ? nuevo.remove(id) : nuevo.add(id);
    favoritos.value = nuevo;
  }

  static void limpiarFavoritos() => favoritos.value = {};
}
