
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'miAppBar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),

      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  // Variable del contador
  int _counter = 0;

  // Incrementa el contador
  void _incrementCounter() {
    setState(() => _counter++);
  }

  // Resetea el contador
  void _resetCounter() {
    setState(() => _counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        // Centra el título
        centerTitle: true,

        // Texto del título
        title: const Text(
          'miAppBar – Material 3',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),


        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,

        // Color de la sombra
        shadowColor: Colors.grey,

        // Elevación cuando hay scroll debajo
        scrolledUnderElevation: 20.0,

        // Botón izquierdo de la AppBar
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menú',
          onPressed: () {
            // mensaje inferior
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Botón de menú pulsado'),
              ),
            );
          },
        ),

        // Botones a la derecha del AppBar
        actions: <Widget>[
          // Botón de búsqueda
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            tooltip: 'Buscar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Botón de búsqueda pulsado'),
                ),
              );
            },
          ),

          // Botón para resetear el contador
          IconButton(
            icon: const Icon(Icons.loop, color: Colors.white),
            tooltip: 'Reset',
            onPressed: _resetCounter,
          ),

          // Menú desplegable
          PopupMenuButton<String>(
            iconColor: Colors.white,
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opción seleccionada: $value')),
              );
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'Opción 1',
                child: Text('Opción 1'),
              ),
              PopupMenuItem(
                value: 'Opción 2',
                child: Text('Opción 2'),
              ),
            ],
          ),
        ],

        // Fondo degradado del AppBar
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF455A64),
                Color(0xFF78909C),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Cambia el color de los iconos del sistema
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // BODY
      body: ListView.builder(
        // Número de elementos de la lista
        itemCount: 25,

        itemBuilder: (context, index) {
          // Primer elemento: información y contador
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Contador actual: $_counter\n'
                'Haz scroll para ver el AppBar.',
              ),
            );
          }

          // Elementos normales de la lista
          return ListTile(
            title: Text('Elemento $index'),
            subtitle: const Text('Subtítulo'),
            leading: const Icon(Icons.account_circle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        },
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
