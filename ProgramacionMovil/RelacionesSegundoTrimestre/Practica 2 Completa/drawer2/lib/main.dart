import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'drawer2',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const Drawer2Home(),
    );
  }
}

class Drawer2Home extends StatefulWidget {
  const Drawer2Home({super.key});

  @override
  State<Drawer2Home> createState() => _Drawer2HomeState();
}

class _Drawer2HomeState extends State<Drawer2Home> {
  // Texto que cambia en el body
  String _message = 'Eligir una opción en el Drawer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('drawer2 (cambia contenido)'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      // Body que va a cambiar según la opción elegida
      body: Center(
        child: Text(
          _message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.brown),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Menú de ejemplos',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                  SizedBox(height: 8),
                  Text('Cambia el texto del body',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('Mostrar texto'),
              onTap: () {
                setState(() {
                  _message = 'Has elegido: Mostrar texto';
                });
                Navigator.pop(context); // cerrar drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Mostrar favorito'),
              onTap: () {
                setState(() {
                  _message = 'Has elegido: Favorito';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Mostrar información'),
              onTap: () {
                setState(() {
                  _message = 'Has elegido: Información';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
