import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita el banner DEBUG
      title: 'floatingActionButton1',
      theme: ThemeData(
        useMaterial3: true, // Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const MyHomePage(title: 'floatingActionButton1'),
    );
  }
}


/// Es Stateful porque el contador cambia

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Estado: contador

  // Suma 1
  void _increment() {
    setState(() => _counter++);
  }

  // Resta 1
  void _decrement() {
    setState(() => _counter--);
  }

  // Pone el contador al valor que indiques
  void _setCounter(int value) {
    setState(() => _counter = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //contador
            Text(
              '$_counter',
              style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            //texto
            const Text(
              'Pulsaciones del botón',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),


      // FLOATING ACTION BUTTON
      // Incrustado en el centro del BottomAppBar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        // Se pueden indicar otros tamanos:
        // - Small: FloatingActionButton.small(...)
        // - Large: FloatingActionButton.large(...)
        // - Extended: FloatingActionButton.extended(...)
        onPressed: _increment, // suma 1
        tooltip: 'Sumar 1',
        backgroundColor: colors.secondary,
        foregroundColor: colors.onSecondary,
         //para que el boton sea redondo
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),


      // BOTTOM APP BAR
      bottomNavigationBar: BottomAppBar(

        shape: const CircularNotchedRectangle(),
        color: colors.primary,
        height: 64,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'Reset',
              onPressed: () => _setCounter(0),
              icon: Icon(Icons.refresh, color: colors.onPrimary),
            ),


            //Se crea un hueco para el boton
            const SizedBox(width: 40),

            //Boton para sumar
            IconButton(
              tooltip: 'Restar',
              onPressed: _decrement,
              icon: Icon(Icons.remove, color: colors.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
