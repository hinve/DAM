import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BottomSheet Persistente',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(),
    );
  }
}

/// Pantalla principal
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomSheet Persistente'),
        centerTitle: true,
      ),

      body: Center(
        child: Builder(
          // El builder es necesario para usar showBottomSheet
          builder: (context) => ElevatedButton(
            child: const Text('Mostrar BottomSheet'),
            onPressed: () {
              // Muestra un BottomSheet PERSISTENTE
              showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 180,
                    color: Colors.orange.shade200,
                    child: const Center(
                      child: Text(
                        'Esto es un BottomSheet PERSISTENTE',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
