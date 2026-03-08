import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quito el banner de debug
      title: 'column1',
      theme: ThemeData(
        useMaterial3: true, 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Column1Page(), 
    );
  }
}

// Página principal de la app
class Column1Page extends StatefulWidget {
  const Column1Page({super.key});

  @override
  State<Column1Page> createState() => _Column1PageState();
}

class _Column1PageState extends State<Column1Page> {

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text('Usando columnas'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

      // Cuerpo de la app
      body: Column(
        // Column coloca los widgets en forma de columna
        children: [
          Expanded(
            // Expanded hace que este contenedor ocupe su parte del espacio
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.deepPurple.shade100,
              child: const Center(
                child: Text('Maria Jesus'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.deepPurple.shade200,
              child: const Center(
                child: Text('Raquel'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.deepPurple.shade300,
              child: const Center(
                child: Text('Eliana'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.deepPurple.shade400,
              child: const Center(
                child: Text('Pilar'),
              ),
            ),
          ),
        ],
      ),

      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_column),
            label: 'Columnas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'Capas',
          ),
        ],
      ),
    );
  }
}
