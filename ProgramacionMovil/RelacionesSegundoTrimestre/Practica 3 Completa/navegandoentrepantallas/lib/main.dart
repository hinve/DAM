import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// App principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // quito el banner
      title: 'Ejercicio 9 - Navegando entre pantallas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),

      // Pantalla inicial
      home: const RowPage(),
    );
  }
}

// DRAWER 
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.currentScreen});

  // Esto lo uso para saber dónde estoy
  final String currentScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // para que el header llegue arriba del todo
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.menu, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  'Menú de navegación',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Ejercicio 9',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // Opción 1 -> pantalla Row
          ListTile(
            leading: const Icon(Icons.view_week),
            title: const Text('Ejemplo Row - ejercicio 4'),
            onTap: () {
              // Si ya estoy ahí, solo cierro el drawer
              if (currentScreen == 'row') {
                Navigator.pop(context);
                return;
              }
              // Cambio de pantalla quitando la actual
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RowPage()),
              );
            },
          ),

          // Opción 2 -> pantalla Column
          ListTile(
            leading: const Icon(Icons.view_column),
            title: const Text('Ejemplo Column - Ejercicio 5'),
            onTap: () {
              if (currentScreen == 'column') {
                Navigator.pop(context);
                return;
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ColumnPage()),
              );
            },
          ),

          // Opción 3 -> pantalla Row+Column
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('Ejemplo Row + Column - Ejercicio 6'),
            onTap: () {
              if (currentScreen == 'rowcolumn') {
                Navigator.pop(context);
                return;
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RowColumnPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}


// PANTALLA 1: ROW Ejercicio 4
class RowPage extends StatefulWidget {
  const RowPage({super.key});

  @override
  State<RowPage> createState() => _RowPageState();
}

class _RowPageState extends State<RowPage> {
  int _selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Row - Ejercicio 4'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

      // Drawer para navegar a las otras pantallas
      drawer: const MyDrawer(currentScreen: 'row'),

      body: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Maria Jesus')),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade300,
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
                color: Colors.blueGrey.shade400,
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
                color: Colors.blueGrey.shade500,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Pilar')),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: colors.primary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // aquí solo cambio la selección
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.view_week), label: 'Row'),
          BottomNavigationBarItem(icon: Icon(Icons.palette), label: 'Color'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
        ],
      ),
    );
  }
}

// PANTALLA 2: COLUMN - Ejercicio 5
class ColumnPage extends StatelessWidget {
  const ColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Column - Ejercicio 5'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

      drawer: const MyDrawer(currentScreen: 'column'),

      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.shade100,
              child: const Center(child: Text('Maria Jesus')),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.shade200,
              child: const Center(child: Text('Raquel')),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.shade300,
              child: const Center(child: Text('Eliana')),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.shade400,
              child: const Center(child: Text('Pilar')),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colors.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.view_column), label: 'Columnas'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Capas'),
        ],
      ),
    );
  }
}

// PANTALLA 3: ROW + COLUMN - Ejercicio 6
class RowColumnPage extends StatelessWidget {
  const RowColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row + Column - Ejercicio 6'),
        centerTitle: true,
      ),

      drawer: const MyDrawer(currentScreen: 'rowcolumn'),

      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  'Películas',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 243, 191, 209),
                    child: const Center(child: Text('Titanic')),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 234, 154, 181),
                    child: const Center(child: Text('Diario de Noah')),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 234, 154, 181),
                    child: const Center(child: Text('Avatar')),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(255, 243, 191, 209),
                    child: const Center(child: Text('Los increíbles')),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  '¿Cuál peli es tu favorita?',
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
