import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Quita el banner DEBUG
      debugShowCheckedModeBanner: false,
      title: 'AppBar 1',

      // Tema de la app
      theme: ThemeData(
        // Color base
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        //Activo material 3
        useMaterial3: true,
      ),

      // Pantalla principal
      home: const HomePage(),
    );
  }
}

/// PANTALLA PRINCIPAL (StatefulWidget)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //estado del contador
  int _counter = 0;

  /// Incrementa el contador
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  /// BUILD: construye el árbol de widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // APPBAR
      appBar: AppBar(
        //color de fondo
        backgroundColor: Colors.deepPurple,
        //color del texto e iconos
        foregroundColor: Colors.white,
        //titulo centrado
        centerTitle: true,

        // Texto del título
        title: const Text(
          'AppBar - 1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // BODY
      body: Center(
        child: Column(
          //centrado vertical
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Veces que has pulsado el boton:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            // Texto que muestra el estado
            Text(
              '$_counter',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),


      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        //cuando se pulsa incrementa el contador
        onPressed: _incrementCounter,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
