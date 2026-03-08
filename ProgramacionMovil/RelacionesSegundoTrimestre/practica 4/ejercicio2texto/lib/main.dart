import 'package:flutter/material.dart';

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
      title: 'richtext_navegacion',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const HomeMenuPage(),
    );
  }
}

// Menú principal con botones para navegar
class HomeMenuPage extends StatelessWidget {
  const HomeMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('RichText y Navegación'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

      // Dos botones para ir a 2 pantallas
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: const Text('VESTIDOS'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrecioVestidos()),
                );
              },
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: const Text('CAMISETAS'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrecioCamisetas()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla 1: precio con estilos vestidos
class PrecioVestidos extends StatelessWidget {
  const PrecioVestidos({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vestido de flores · Precio'),
        centerTitle: true,
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 22, color: colors.onSurface),
            children: const [
              TextSpan(text: 'Antes: '),
              TextSpan(
                text: '29,99€',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(text: '  ·  Ahora: '),
              TextSpan(
                text: '19,99€',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla 2: precio con estilos camisetas
class PrecioCamisetas extends StatelessWidget {
  const PrecioCamisetas({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camisetas · Precios'),
        centerTitle: true,
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 22, color: colors.onSurface),
            children: const [
              TextSpan(text: 'Antes: '),
              TextSpan(
                text: '19,99€',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(text: '  ·  Ahora: '),
              TextSpan(
                text: '9,99€',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
