import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Widget principal de la app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'appConTabBar',

      // Configuro el tema con Material 3
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 200, 230, 210)),
      ),

      // DefaultTabController es el que controla las pestañas
      home: const DefaultTabController(
        //Numero de pestanas
        length: 4,
        //Pantalla principal 
        child: HomeTabs(), 
      ),
    );
  }
}

// Pantalla principal que contiene el TabBar y TabBarView
class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      // Barra superior con el TabBar
      appBar: AppBar(
        title: const Text('App con TabBar'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,

        // Pestañas de navegación
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Inicio'),
            Tab(icon: Icon(Icons.message), text: 'Mensajes'),
            Tab(icon: Icon(Icons.star), text: 'Favoritos'),
            Tab(icon: Icon(Icons.settings), text: 'Ajustes'),
          ],
        ),
      ),

      // Cambia el contenido según la pestaña seleccionada
      body: const TabBarView(
        children: [
          ContenidoInicio(),
          ContenidoMensajes(),
          ContenidoFavoritos(),
          ContenidoAjustes(),
        ],
      ),
    );
  }
}


// WIDGETS DE CADA PESTAÑA

// Contenido de la pestaña Inicio
class ContenidoInicio extends StatelessWidget {
  const ContenidoInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // Texto centrado
      child: Text(
        'Hola! esta es la pestana de inicio de la App de Maria Jesus',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Contenido de la pestaña Mensajes
class ContenidoMensajes extends StatelessWidget {
  const ContenidoMensajes({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de mensajes de ejemplo
    final mensajes = const [
      'Hola soy Maria Jesus',
      'Me encanta crear App con Flutter',
      'Voy a trabajar duro para conseguir mis objetivos',
    ];

    // ListView dinámico que muestra los mensajes
    return ListView.builder(
      itemCount: mensajes.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.message_outlined),
          title: Text('Mensaje ${index + 1}'),
          subtitle: Text(mensajes[index]),
        );
      },
    );
  }
}

// Contenido de la pestaña Favoritos
class ContenidoFavoritos extends StatelessWidget {
  const ContenidoFavoritos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),

      // Column para organizar varias tarjetas
      child: Column(
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.star),
              title: Text('Flutter'),
              subtitle: Text('Mi framework favorito para la creacion de App'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.star),
              title: Text('Dart'),
              subtitle: Text('El lenguaje que usa Flutter'),
            ),
          ),
        ],
      ),
    );
  }
}

// Contenido de la pestaña Ajustes
class ContenidoAjustes extends StatelessWidget {
  const ContenidoAjustes({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de opciones de configuración
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.palette_outlined),
          title: Text('Tema'),
          subtitle: Text('Opciones de apariencia'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.notifications_outlined),
          title: Text('Notificaciones'),
          subtitle: Text('Activar o desactivar avisos'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Acerca de'),
          subtitle: Text('Información de la app'),
        ),
      ],
    );
  }
}

