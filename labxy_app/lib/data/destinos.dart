import 'package:flutter/cupertino.dart';

/// Zonas para los filtros (Map: nombre -> icono)
const Map<String, IconData> zonas = {
  'Todas': CupertinoIcons.square_grid_2x2_fill,
  'Costa': CupertinoIcons.sun_max_fill,
  'Sierra': CupertinoIcons.cloud_fill,
  'Selva': CupertinoIcons.tree,
};

/// LISTA de MAPAS: cada destino es un Map<String, dynamic>
final List<Map<String, dynamic>> destinos = [
  {
    'id': 1,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Machu_Picchu%2C_Peru.jpg/1280px-Machu_Picchu%2C_Peru.jpg',
    'nombre': 'Machu Picchu',
    'region': 'Cusco',
    'zona': 'Sierra',
    'descripcion':
        'Ciudadela inca del siglo XV escondida entre montañas y nubes. Es una de las nuevas siete maravillas del mundo y el destino más visitado del Perú.',
    'precio': 450.0,
    'dias': 2,
    'rating': 4.9,
    'altitud': '2430 m',
    'icono': CupertinoIcons.sun_max_fill,
    'color': const Color(0xFF11998E),
    'color2': const Color(0xFF0B5345),
    'actividades': ['Tour guiado por la ciudadela', 'Subida a Huayna Picchu', 'Tren a Aguas Calientes'],
  },
  {
    'id': 2,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Lascar_Some_of_the_Ollantaytambo%27s_terraces_%28Sacred_Valley_of_the_Incas%29_%284577538815%29.jpg/1280px-Lascar_Some_of_the_Ollantaytambo%27s_terraces_%28Sacred_Valley_of_the_Incas%29_%284577538815%29.jpg',
    'nombre': 'Valle Sagrado',
    'region': 'Cusco',
    'zona': 'Sierra',
    'descripcion':
        'Valle formado por el río Urubamba, lleno de pueblos tradicionales, andenes incas y mercados artesanales llenos de color.',
    'precio': 180.0,
    'dias': 1,
    'rating': 4.7,
    'altitud': '2900 m',
    'icono': CupertinoIcons.cloud_sun_fill,
    'color': const Color(0xFF56AB2F),
    'color2': const Color(0xFF2E6B12),
    'actividades': ['Mercado de Pisac', 'Fortaleza de Ollantaytambo', 'Salineras de Maras'],
  },
  {
    'id': 3,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Reed_Islands_of_Lake_Titicaca.jpg/1280px-Reed_Islands_of_Lake_Titicaca.jpg',
    'nombre': 'Lago Titicaca',
    'region': 'Puno',
    'zona': 'Sierra',
    'descripcion':
        'El lago navegable más alto del mundo. Hogar de las islas flotantes de los Uros, construidas completamente con totora.',
    'precio': 220.0,
    'dias': 2,
    'rating': 4.6,
    'altitud': '3812 m',
    'icono': CupertinoIcons.drop_fill,
    'color': const Color(0xFF2193B0),
    'color2': const Color(0xFF0F3D7A),
    'actividades': ['Islas flotantes de los Uros', 'Isla Taquile', 'Paseo en bote al atardecer'],
  },
  {
    'id': 4,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Colca_Canyon_Puno.jpg/1280px-Colca_Canyon_Puno.jpg',
    'nombre': 'Cañón del Colca',
    'region': 'Arequipa',
    'zona': 'Sierra',
    'descripcion':
        'Uno de los cañones más profundos del planeta. Desde sus miradores se puede ver el majestuoso vuelo del cóndor andino.',
    'precio': 260.0,
    'dias': 2,
    'rating': 4.8,
    'altitud': '3635 m',
    'icono': CupertinoIcons.wind,
    'color': const Color(0xFFC06C3E),
    'color2': const Color(0xFF6B2E14),
    'actividades': ['Mirador Cruz del Cóndor', 'Baños termales de Chivay', 'Trekking por el cañón'],
  },
  {
    'id': 5,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Oasis_de_Huacachina%2C_Ica%2C_Per%C3%BA%2C_2015-07-29%2C_DD_18.JPG/1280px-Oasis_de_Huacachina%2C_Ica%2C_Per%C3%BA%2C_2015-07-29%2C_DD_18.JPG',
    'nombre': 'Huacachina',
    'region': 'Ica',
    'zona': 'Costa',
    'descripcion':
        'Un oasis natural rodeado de dunas gigantes. Perfecto para la aventura y para ver uno de los atardeceres más bonitos del país.',
    'precio': 120.0,
    'dias': 1,
    'rating': 4.5,
    'altitud': '406 m',
    'icono': CupertinoIcons.flame_fill,
    'color': const Color(0xFFF7B733),
    'color2': const Color(0xFFE2582B),
    'actividades': ['Paseo en tubulares', 'Sandboard en las dunas', 'Atardecer en el desierto'],
  },
  {
    'id': 6,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Ballestas_Islands_P%C3%A9rou_2011_%282%29.jpg/1280px-Ballestas_Islands_P%C3%A9rou_2011_%282%29.jpg',
    'nombre': 'Islas Ballestas',
    'region': 'Ica',
    'zona': 'Costa',
    'descripcion':
        'Reserva natural conocida como las "Galápagos peruanas", con lobos marinos, pingüinos de Humboldt y miles de aves.',
    'precio': 90.0,
    'dias': 1,
    'rating': 4.4,
    'altitud': '0 m',
    'icono': CupertinoIcons.compass_fill,
    'color': const Color(0xFF00B4DB),
    'color2': const Color(0xFF005C97),
    'actividades': ['Paseo en lancha', 'Geoglifo El Candelabro', 'Avistamiento de fauna marina'],
  },
  {
    'id': 7,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Chan_Chan_Archaeological_Zone-110903.jpg/1280px-Chan_Chan_Archaeological_Zone-110903.jpg',
    'nombre': 'Chan Chan',
    'region': 'La Libertad',
    'zona': 'Costa',
    'descripcion':
        'La ciudad de barro más grande de la América precolombina y antigua capital del reino Chimú. Patrimonio de la Humanidad.',
    'precio': 70.0,
    'dias': 1,
    'rating': 4.3,
    'altitud': '34 m',
    'icono': CupertinoIcons.building_2_fill,
    'color': const Color(0xFFB79891),
    'color2': const Color(0xFF6D4C41),
    'actividades': ['Palacio Nik An', 'Huaca del Dragón', 'Playa de Huanchaco'],
  },
  {
    'id': 8,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Laguna_69%2C_July_22%2C_2017.jpg/1280px-Laguna_69%2C_July_22%2C_2017.jpg',
    'nombre': 'Huascarán',
    'region': 'Áncash',
    'zona': 'Sierra',
    'descripcion':
        'Parque nacional con nevados eternos, lagunas turquesa y la montaña más alta del Perú. Un paraíso para el trekking.',
    'precio': 200.0,
    'dias': 3,
    'rating': 4.8,
    'altitud': '6768 m',
    'icono': CupertinoIcons.snow,
    'color': const Color(0xFF4FACFE),
    'color2': const Color(0xFF1E3C72),
    'actividades': ['Caminata a la Laguna 69', 'Glaciar Pastoruri', 'Lagunas de Llanganuco'],
  },
  {
    'id': 9,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Kuelap_-_Ao%C3%BBt_2007_-_05.jpg/1280px-Kuelap_-_Ao%C3%BBt_2007_-_05.jpg',
    'nombre': 'Kuélap',
    'region': 'Amazonas',
    'zona': 'Selva',
    'descripcion':
        'Imponente fortaleza de la cultura Chachapoyas construida sobre una montaña. Se llega en un teleférico con vistas increíbles.',
    'precio': 240.0,
    'dias': 2,
    'rating': 4.7,
    'altitud': '3000 m',
    'icono': CupertinoIcons.flag_fill,
    'color': const Color(0xFF8E2DE2),
    'color2': const Color(0xFF4A00E0),
    'actividades': ['Viaje en teleférico', 'Catarata de Gocta', 'Museo de Leymebamba'],
  },
  {
    'id': 10,
    'imagen': 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Rio_Madre_de_Dios%2C_Peru.JPG/1280px-Rio_Madre_de_Dios%2C_Peru.JPG',
    'nombre': 'Tambopata',
    'region': 'Madre de Dios',
    'zona': 'Selva',
    'descripcion':
        'Reserva nacional en plena Amazonía, con una biodiversidad impresionante: guacamayos, monos, caimanes y árboles gigantes.',
    'precio': 380.0,
    'dias': 3,
    'rating': 4.6,
    'altitud': '183 m',
    'icono': CupertinoIcons.tree,
    'color': const Color(0xFF38EF7D),
    'color2': const Color(0xFF0B6E4F),
    'actividades': ['Collpa de guacamayos', 'Lago Sandoval', 'Caminata nocturna en la selva'],
  },
];

/// MAPA: agrupa los destinos por región -> { 'Cusco': [..], 'Ica': [..] }
Map<String, List<Map<String, dynamic>>> destinosPorRegion() {
  final Map<String, List<Map<String, dynamic>>> mapa = {};
  for (final d in destinos) {
    mapa.putIfAbsent(d['region'] as String, () => []).add(d);
  }
  return mapa;
}

Map<String, dynamic> destinoPorId(int id) => destinos.firstWhere((d) => d['id'] == id);

/// Foto de portada para el perfil
const String fotoPortada =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Machu_Picchu%2C_Peru.jpg/1280px-Machu_Picchu%2C_Peru.jpg';

String soles(dynamic precio) => 'S/ ${(precio as double).toStringAsFixed(0)}';
