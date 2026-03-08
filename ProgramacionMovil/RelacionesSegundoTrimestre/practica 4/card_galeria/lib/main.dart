import 'package:flutter/material.dart';

void main() {
  // Arranca la app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // quita el banner DEBUG
      title: 'Cards de Cantantes',
      theme: ThemeData(
        //tema con Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const SingerLayoutScreen(),
    );
  }
}

class SingerLayoutScreen extends StatelessWidget {
  const SingerLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text('Cantantes en Cards'),
      ),

      // Cuerpo con padding y scroll 
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // FILA CON 2 CARDS 
              Row(
                children: [
                  Expanded(
                    child: buildSingerCard(
                      name: 'Nathy Peluso',
                      extra: 'Urbano / Pop',
                      icon: Icons.mic,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildSingerCard(
                      name: 'Rosalía',
                      extra: 'Flamenco Pop',
                      icon: Icons.music_note,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),


              // FILA CON 3 CARDS
              Row(
                children: [
                  Expanded(
                    child: buildSingerCard(
                      name: 'Bad Bunny',
                      extra: 'Reggaetón',
                      icon: Icons.headphones,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildSingerCard(
                      name: 'Shakira',
                      extra: 'Pop Latino',
                      icon: Icons.audiotrack,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildSingerCard(
                      name: 'Quevedo',
                      extra: 'Urbano',
                      icon: Icons.album,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),


              // DISTRIBUCIÓN CON WRAP
              Wrap(
                // espacio horizontal entre cards
                spacing: 10, 
                // espacio vertical cuando salta a la siguiente línea 
                runSpacing: 10, 
                children: List.generate(
                  singerList.length,
                  (index) => SizedBox(
                    // para que haya dos card por fila.
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    child: buildSingerCard(
                      name: singerList[index].name,
                      extra: singerList[index].genre,
                      icon: singerList[index].icon,
                      color: singerList[index].color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // funcion que crea una card personalizada
  Widget buildSingerCard({
    required String name,
    required String extra,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      // sombra de la card
      elevation: 4,
      shape: RoundedRectangleBorder(
        // bordes redondeados
        borderRadius: BorderRadius.circular(12), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          // la card se ajusta al contenido
          mainAxisSize: MainAxisSize.min, 
          children: [
            // Icono grande arriba
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),

            // Nombre del cantante
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // Genero musical
            Text(
              extra,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// Lista para el wrap que hace mas facil cambiar de cantantes
class SingerInfo {
  final String name;
  final String genre;
  final IconData icon;
  final Color color;

  const SingerInfo({
    required this.name,
    required this.genre,
    required this.icon,
    required this.color,
  });
}

// Se puede cambiar, añadir o quitar cantantes aquí
const List<SingerInfo> singerList = [
  SingerInfo(
    name: "Aitana",
    genre: "Pop",
    icon: Icons.queue_music,
    color: Colors.pink,
  ),
  SingerInfo(
    name: "C. Tangana",
    genre: "Rap / Urbano",
    icon: Icons.speaker,
    color: Colors.brown,
  ),
  SingerInfo(
    name: "Dua Lipa",
    genre: "Pop Internacional",
    icon: Icons.library_music,
    color: Colors.indigo,
  ),
  SingerInfo(
    name: "Bizarrap",
    genre: "Producer",
    icon: Icons.graphic_eq,
    color: Colors.teal,
  ),
  SingerInfo(
    name: "Karol G",
    genre: "Urbano",
    icon: Icons.mic_external_on,
    color: Colors.deepOrange,
  ),
  SingerInfo(
    name: "Rauw Alejandro",
    genre: "Reggaetón",
    icon: Icons.headset_mic,
    color: Colors.blueGrey,
  ),
];
