import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Flutter'),
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
            tooltip: 'Increment',
            onPressed: (){},
            child: const Icon(Icons.add, size: 28),
            ),
          bottomNavigationBar: BottomAppBar(
            color: const Color.fromRGBO(82, 170, 94, 1.0),
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.home, color: Color.fromRGBO(43, 217, 254, 1.0))
                ),
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.favorite, color: Colors.red
                  )
                )
              ],
            )
          ),
        )
      );
    }
}

