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
      title: 'AppBar 3',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const HomePage(),
    );
  }
}

/// PANTALLA PRINCIPAL
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // APPBAR
      appBar: AppBar(
        title: const Text(
          "AppBar - 3",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        // Estilo
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        //sombra
        elevation: 6.0,

        // Botón izquierdo de la appbar (leading)
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menú',
          onPressed: () {
            //muestra un mensaje inferior temporal
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Botón de menú pulsado'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),

        // Botones derechos (actions)
        actions: <Widget>[
          //primer boton
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Información',
            onPressed: () {
              //muestra un cuadro de dialogo
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Información'),
                  content: const Text(
                    'Ejemplo de AppBar con acciones y botón leading.',
                  ),
                  actions: [
                    TextButton(
                      //cierra el dialogo
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
          //segundo boton
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Ajustes',
            onPressed: () {
              //muestra un mensaje inferior temporal
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Botón de ajustes pulsado'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],

        // CAambia el color de los iconos del sistema (hora, bateria, wifi)
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),


      // BODY
      body: const Center(
        child: Text(
          "AppBar - 3",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
