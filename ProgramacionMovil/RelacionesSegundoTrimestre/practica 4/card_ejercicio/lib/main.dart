import 'package:flutter/material.dart';

void main() {
  // Arrancamos la app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galería de Cantantes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const SingerGalleryScreen(),
    );
  }
}

class SingerGalleryScreen extends StatelessWidget {
  const SingerGalleryScreen({super.key});

  // Lista de datos para cada card.
  // Aquí guardo: nombre, estilo, imagen y una canción recomendada.
  // Uso map como en el ejemplo
  final List<Map<String, String>> singers = const [
    {
      "nombre": "Nathy Peluso",
      "genero": "Urbano / Pop",
      "cancion": "BZRP Music Sessions",
      "imagen": "https://adg-fad.org/wp-content/uploads/2021/03/aaffdigitalcalambrenathypeluso-1200x1200.jpg"
    },
    {
      "nombre": "Rosalía",
      "genero": "Flamenco Pop",
      "cancion": "SAOKO",
      "imagen": "https://hips.hearstapps.com/hmg-prod/images/rosalia-entrevista-elle-1592828849.jpg?crop=1.00xw:0.847xh;0,0.106xh&resize=1200:*"
    },
    {
      "nombre": "Bad Bunny",
      "genero": "Reggaetón",
      "cancion": "Tití Me Preguntó",
      "imagen": "https://s1.abcstatics.com/media/cultura/2019/01/05/bunny2-kQKG--1248x698@abc.jpg"
    },
    {
      "nombre": "Shakira",
      "genero": "Pop Latino",
      "cancion": "Hips Don’t Lie",
      "imagen": "https://hips.hearstapps.com/hmg-prod/images/elle-22-09-05-20706-1bis-c2101-r2048675-1663739622.jpg?resize=768:*"
    },
    {
      "nombre": "Lia Kali",
      "genero": "Rap, soul y reggae",
      "cancion": "Que te debo",
      "imagen": "http://vein.es/wp-content/uploads/2024/10/Lia-Kali.jpg"
    },
    {
      "nombre": "Aitana",
      "genero": "Pop",
      "cancion": "Mon Amour",
      "imagen": "https://hips.hearstapps.com/hmg-prod/images/aitana-6874f97f0dff3.jpg?resize=980:*"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text("Galería de Cantantes"),
      ),

      // Un padding general para que no quede pegado a los bordes
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        // GridView.builder crea las cards según se necesiten
        child: GridView.builder(
          itemCount: singers.length,

          // Aquí defino cómo se comporta el grid (columnas, espaciado, tamaño)
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columnas
            crossAxisSpacing: 8, // espacio horizontal
            mainAxisSpacing: 8, // espacio vertical
            childAspectRatio: 0.78, // relación ancho/alto (para que se parezca al ejemplo)
          ),

          // Este builder construye cada card usando el índice
          itemBuilder: (context, index) {
            final singer = singers[index];

            // GestureDetector detecta gestos usamos onTap
            return GestureDetector(
              onTap: () {
                // Si pulsamos mostramos un mensaje con el nombre del cantante
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Has pulsado: ${singer['nombre']}"),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },

              // Contenido de la card
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // recorta la imagen con los bordes redondos
                clipBehavior: Clip.antiAlias, 

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Parte de arriba
                    Expanded(
                      child: Image.network(
                        singer["imagen"]!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),

                    // Parte de abajo
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            singer["nombre"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            singer["genero"]!,
                            style: const TextStyle(color: Colors.black54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Tema: ${singer["cancion"]!}",
                            style: const TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
