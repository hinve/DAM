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
      debugShowCheckedModeBanner: false, // quito el banner de debug
      title: 'Ejercicio 10 - GridView + Navegación',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const HomeGridPage(), // aquí pongo el menú en forma de GridView
    );
  }
}


// MENÚ CON GRIDVIEW 
class HomeGridPage extends StatelessWidget {
  const HomeGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Creo una lista con la info de cada tarjeta del Grid
    final options = [
      (
        title: 'Ejemplo Row',
        subtitle: 'Expanded en horizontal',
        icon: Icons.view_week,
        page: const RowPage(),
      ),
      (
        title: 'Ejemplo Column',
        subtitle: 'Expanded en vertical',
        icon: Icons.view_column,
        page: const ColumnPage(),
      ),
      (
        title: 'Row + Column',
        subtitle: 'Combinación (pelis)',
        icon: Icons.grid_view,
        page: const RowColumnPage(),
      ),
    ];

    return Scaffold(
      // AppBar del menú
      appBar: AppBar(
        title: const Text('Menú (GridView)'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

      // Con GridView.count fijo el número de columnas (2)
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2, // 2 columnas
          mainAxisSpacing: 12, // separación vertical
          crossAxisSpacing: 12, // separación horizontal
          childAspectRatio: 1.05, // forma de las tarjetas
          children: [
            // Creo cada tarjeta a partir de la lista de options
            for (final opt in options)
              InkWell(
                // InkWell da efecto toque
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  // Navego a otra pantalla con Navigator.push
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => opt.page),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.outlineVariant),
                  ),
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(opt.icon, size: 46, color: colors.primary),
                      const SizedBox(height: 10),
                      Text(
                        opt.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        opt.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),

      // Botón para volver rápido arriba
      floatingActionButton: FloatingActionButton(
        tooltip: 'Info',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pulsa una tarjeta para abrir su pantalla'),
            ),
          );
        },
        child: const Icon(Icons.info_outline),
      ),
    );
  }
}


// PANTALLA 1: ROW - Ejercicio 4

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
        title: const Text('row1 - Row con Expanded'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

     
      body: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade200,
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
                color: Colors.deepOrange.shade300,
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
                color: Colors.deepOrange.shade400,
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
                color: Colors.deepOrange.shade500,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Pilar')),
            ),
          ),
        ],
      ),

      // BottomNavigationBar 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: colors.primary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // cambio la selección
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
        title: const Text('column1 - Column con Expanded'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

   
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.deepOrange.shade100,
              child: const Center(child: Text('Maria Jesus')),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.deepOrange.shade200,
              child: const Center(child: Text('Raquel')),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.deepOrange.shade300,
              child: const Center(child: Text('Eliana')),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.deepOrange.shade400,
              child: const Center(child: Text('Pilar')),
            ),
          ),
        ],
      ),

      // BottomNavigationBar 
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
        title: const Text('rowcolumn1 - Row + Column'),
        centerTitle: true,
      ),

      // Yo mantengo tu diseño de películas
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
