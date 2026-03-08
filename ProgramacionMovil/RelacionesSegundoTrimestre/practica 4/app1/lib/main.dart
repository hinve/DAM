import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Punto de entrada de la aplicación
void main() {
  runApp(const MyApp());
}

// Widget principal de la app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Creamos el estado global de la aplicación
      create: (context) => MyAppState(),

      // Aplicación Material
      child: MaterialApp(
        title: 'App 1',

        // Tema general de la app
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),

        // Pantalla principal
        home: MyHomePage(),
      ),
    );
  }
}


// CLASE QUE GUARDA EL ESTADO DE LA APLICACIÓN

class MyAppState extends ChangeNotifier {
  // Palabra actual generada aleatoriamente
  var current = WordPair.random();

  // Método para generar una nueva palabra
  void getNext() {
    current = WordPair.random();
    notifyListeners(); // avisa a la interfaz de que ha cambiado
  }

  // Lista donde guardamos los favoritos
  var favorites = <WordPair>[];

  // Método para añadir o quitar de favoritos
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners(); // actualiza la pantalla
  }
}

// PANTALLA PRINCIPAL CON NAVEGACIÓN


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Índice para saber qué pantalla está seleccionada
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    // Según el índice se decide qué página mostrar
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError("No Widget for $selectedIndex");
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                // Menú lateral de navegación
                child: NavigationRail(
                  // Si la pantalla es grande se muestra extendido
                  extended: constraints.maxWidth >= 600,

                  // Opciones del menú
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favoritos'),
                    ),
                  ],

                  // Índice seleccionado actualmente
                  selectedIndex: selectedIndex,

                  // Cuando se pulsa una opción cambia la pantalla
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),

              // Zona donde se muestra la página seleccionada
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}


// PÁGINA DEL GENERADOR DE PALABRAS


class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Obtenemos el estado global de la app
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    // Elegimos el icono según esté o no en favoritos
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Card grande que muestra la palabra actual
          BigCard(pair: pair),

          const SizedBox(height: 10),

          // Botones de acción
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Botón para añadir/quitar de favoritos
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: const Text('Me gusta'),
              ),

              const SizedBox(width: 10),

              // Botón para generar otra palabra
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// WIDGET QUE MUESTRA LA PALABRA EN UNA CARD GRANDE


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {

    // Obtenemos el tema actual para usar sus colores
    final theme = Theme.of(context);

    // Estilo del texto dentro de la card
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,

      child: Padding(
        padding: const EdgeInsets.all(20),

        // Mostramos la palabra generada
        child: Text(
          pair.asLowerCase,
          style: style,

          // Esto mejora la accesibilidad
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}


// PÁGINA QUE MUESTRA LOS FAVORITOS


class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Accedemos al estado global
    var appState = context.watch<MyAppState>();

    // Si no hay favoritos mostramos un mensaje
    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No jay favoritos aun.'),
      );
    }

    // Si hay favoritos los mostramos en una lista
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),

          // Texto que indica cuántos favoritos hay
          child: Text(
            'Tu tienes ${appState.favorites.length} favoritos:',
          ),
        ),

        // Recorremos la lista de favoritos y los mostramos
        for (var pair in appState.favorites)
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
