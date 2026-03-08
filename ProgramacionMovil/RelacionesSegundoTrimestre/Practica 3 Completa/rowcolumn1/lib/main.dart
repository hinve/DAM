import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'rowcolumn1',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const RowColumnPage(),
    );
  }
}

// Página principal
class RowColumnPage extends StatelessWidget {
  const RowColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text('Probando Columnas y filas'),
        centerTitle: true,
      ),

      // El cuerpo principal usa Columnas
      body: Column(
        children: [
          // Parte superior con texto
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  'Peliculas',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          // Fila con dos peliculas
          Expanded(
            child: Row(
              // Row coloca los widgets en horizontal por filas
              children: [
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 179, 210, 243),
                    child: const Center(
                      child: Text('Titanic'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 144, 187, 233),
                    child: const Center(
                      child: Text('Diario de Noah'),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Otra fila con otros dos colores
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color:  const Color.fromARGB(255, 144, 187, 233),
                    child: const Center(
                      child: Text('Avatar'),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 179, 210, 243),
                    child: const Center(
                      child: Text('Los increibles'),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Parte inferior con pregunta
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  '¿Cual peli es tu favorita?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
