import 'package:flutter/material.dart';

// Punto de entrada de la aplicación
void main() => runApp(const MyApp());

// Widget principal de la app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita el banner de debug
      title: 'row1',
      theme: ThemeData(
        useMaterial3: true, // Uso Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: const Row1Page(),
    );
  }
}

class Row1Page extends StatefulWidget {
  const Row1Page({super.key});

  @override
  State<Row1Page> createState() => _Row1PageState();
}

class _Row1PageState extends State<Row1Page> {
  int _selectedIndex = 0; // Índice del BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme; // Colores del tema

    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: const Text('row1 · Row con Expanded'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

      // Cuerpo principal de la pantalla
      body: Row(
        // Row  que coloca los widgets en horizontal
        children: [
          Expanded(
            // Expanded hace ocupen el mismo espacio todos
            child: Container(
              margin: const EdgeInsets.all(6), 
              padding: const EdgeInsets.all(16), 
              decoration: BoxDecoration(
                color: Colors.cyan.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('Maria Jesus'),
              ),
            ),
          ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Raquel')),
            ),
          ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Eliana')),
            ),
          ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan.shade500,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Pilar')),
            ),
          ),
        ],
      ),

      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Elemento seleccionado
        selectedItemColor: colors.primary,
        onTap: (index) {
          // Cambia el índice cuando se pulsa
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_week),
            label: 'Row',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.palette),
            label: 'Color',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
