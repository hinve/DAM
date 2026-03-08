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
      title: 'Stack',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const MyHomePage(title: 'Stack - Ejercicio 7'),
    );
  }
}

// Pantalla principal
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),

      // Centro el Stack
      body: Center(
        child: SizedBox(
          width: 320,
          height: 320,

          // STACK
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Fondo principal
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(180, 128, 203, 196),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),

              // Caja intermedia (posicionada)
              Positioned(
                top: 22,
                left: 22,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(140, 63, 81, 181),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                ),
              ),

              // Caja superior semitransparente
              Positioned(
                bottom: 28,
                right: 28,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(90, 0, 0, 0),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      width: 2,
                      color: const Color.fromARGB(150, 255, 255, 255),
                    ),
                  ),

                  child: const Center(
                    child: Text(
                      'Stack + Positioned',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // Badge arriba a la derecha
              const Positioned(
                top: 12,
                right: 12,
                child: CircleAvatar(
                  radius: 18,
                  child: Text('7'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
