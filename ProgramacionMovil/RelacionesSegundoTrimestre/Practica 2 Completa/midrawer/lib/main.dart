import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'miDrawer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MiDrawerHome(),
    );
  }
}

class MiDrawerHome extends StatefulWidget {
  const MiDrawerHome({super.key});

  @override
  State<MiDrawerHome> createState() => _MiDrawerHomeState();
}

class _MiDrawerHomeState extends State<MiDrawerHome> {
  // Contenido que mostramos en el body
  String _pageTitle = 'Inicio';
  IconData _pageIcon = Icons.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('miDrawer · $_pageTitle'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),

      // Body con icono y texto 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_pageIcon, size: 90, color: Colors.deepOrange),
            const SizedBox(height: 16),
            Text(
              'Estás en: $_pageTitle',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),

      // Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header 
            Container(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
              color: Colors.deepOrange,
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.deepOrange, size: 30),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Maria Jesus',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('mserser579@g.educaand.es',
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Opciones del menú que cambian de estado al presionarlos
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                setState(() {
                  _pageTitle = 'Inicio';
                  _pageIcon = Icons.home;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Guardados'),
              onTap: () {
                setState(() {
                  _pageTitle = 'Guardados';
                  _pageIcon = Icons.bookmark;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes'),
              onTap: () {
                setState(() {
                  _pageTitle = 'Ajustes';
                  _pageIcon = Icons.settings;
                });
                Navigator.pop(context);
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar drawer'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
