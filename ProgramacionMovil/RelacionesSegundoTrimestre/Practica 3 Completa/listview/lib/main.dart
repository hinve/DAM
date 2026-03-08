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
      title: 'ListView',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const MyHomePage(title: 'Ejercicio ListView'),
    );
  }
}

// Pantalla principal es Stateful porque la lista va cambiando
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Estado
class _MyHomePageState extends State<MyHomePage> {
  // Aquí guardo los datos de mi lista
  final List<String> _titles = ['Proyecto 1', 'Proyecto 2', 'Proyecto 3'];
  final List<String> _subtitles = [
    'Pendiente de revisar',
    'En progreso',
    'Terminado',
  ];
  final List<IconData> _icons = [
    Icons.checklist,
    Icons.timer,
    Icons.done_all,
  ];

  // Funcion que añade un elemento nuevo a la lista
  void _addNewItem() {
    setState(() {
      final next = _titles.length + 1;
      _titles.add('Proyecto $next');
      _subtitles.add('Nuevo proyecto añadido');
      _icons.add(Icons.add_task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),

      //Uso ListView.builder para crear la lista de forma dinámica
      body: ListView.builder(
        itemCount: _titles.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              // Uso un icono redondo en vez de imagen
              leading: CircleAvatar(
                backgroundColor: Colors.amber.shade100,
                child: Icon(_icons[index], color: Colors.amber.shade900),
              ),

              // Texto principal
              title: Text(_titles[index]),

              // Texto secundario
              subtitle: Text(_subtitles[index]),

            ),
          );
        },
      ),

      // Boton para anadir
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
