import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'drawer1',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeDrawer1(),
    );
  }
}

class HomeDrawer1 extends StatelessWidget {
  const HomeDrawer1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar: si hay drawer, aparece el botón utomáticamente
      appBar: AppBar(
        title: const Text('drawer1'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      // Contenido principal
      body: const Center(
        child: Text(
          'Ejemplo 1: Drawer básico',
          style: TextStyle(fontSize: 20),
        ),
      ),

      // Drawer lateral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // importante para que el header llegue arriba
          children: [
            // Header con datos de usuario
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              accountName: Text('Maria Jesus'),
              accountEmail: Text('mserser579@g.educaand.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('M', style: TextStyle(fontSize: 26)),
              ),
            ),

            // Cada opción del menú es un ListTile
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context); // cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Cursos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(), // separador visual
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Salir'),
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
