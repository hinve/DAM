import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Para SVG
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Para iconos externos

void main() {
  runApp(const MyApp());
}

// App principal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multimedia e Iconos',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const MultimediaPage(),
    );
  }
}

// Pantalla principal
class MultimediaPage extends StatelessWidget {
  const MultimediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(

      // barra superior
      appBar: AppBar(
        title: const Text('Ejercicio Multimedia'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        actions: const [
          //Iconos de material
          Icon(Icons.search),
          SizedBox(width: 12),
          Icon(Icons.notifications), 
          SizedBox(width: 12),
        ],
      ),

      // CUERPO CON 3 IMÁGENES
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Imagen mediante enlace
            Image.network(
              'https://st2.depositphotos.com/3337459/46488/v/450/depositphotos_464882754-stock-illustration-abstract-face-butterfly-one-line.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            // Imagen en local jpg
            Image.asset(
              'assets/img/foto.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 20),

            // Imagen svg en local
            SvgPicture.asset(
              'assets/img/icono.svg',
              width: 120,
              height: 120,
            ),
          ],
        ),
      ),

      // BOTTOM BAR CON ICONOS FONT AWESOME
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colors.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.github), // Icono externo
            label: 'GitHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.image), // Icono externo
            label: 'Media',
          ),
        ],
      ),
    );
  }
}
