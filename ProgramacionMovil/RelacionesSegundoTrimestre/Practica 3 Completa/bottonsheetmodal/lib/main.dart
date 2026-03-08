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
      title: 'BottomSheet Modal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
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
        title: const Text('BottomSheet Modal'),
        centerTitle: true,
      ),

      // Contenido principal
      body: Center(
        child: ElevatedButton(
          child: const Text('Abrir BottomSheet'),
          onPressed: () {
            // BottomSheet MODAL
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'Esto es un BottomSheet MODAL',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
