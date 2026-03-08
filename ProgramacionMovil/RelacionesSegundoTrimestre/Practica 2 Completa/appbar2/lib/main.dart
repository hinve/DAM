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
      title: 'AppBar 2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}


/// PANTALLA PRINCIPAL
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  /// Incrementa el contador 
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  /// BUILD: construcción del árbol de widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      // APPBAR
      appBar: AppBar(
        // título
        title: const Text('AppBar - 2'),

        // centra el titulo horizontalmente
        centerTitle: true,

        // espacio horizontal alrededor del título elimina el margen extra
        titleSpacing: 0.0,

        // altura de la AppBar
        toolbarHeight: 70,

        // opacidad del contenido (texto e iconos)
        toolbarOpacity: 0.9,

        // bordes redondeados solo abajo
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),

        // elimina la sombra
        elevation: 0,

        // color de fondo de la AppBar
        backgroundColor: Colors.teal,

        // color del texto e iconos
        foregroundColor: Colors.white,
      ),


      // BODY
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Veces que has pulsado el boton:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            // Texto del contador
            Text(
              '$_counter',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),

      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
