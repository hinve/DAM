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
      title: 'miBottomNavigationBar',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;        // contador
  int _selectedIndex = 0; // pestaña seleccionada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APPBAR
      appBar: AppBar(
        title: const Text('miBottomNavigationBar'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),

      // BODY
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Valor del contador:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION BAR 
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,

        // Cuando se pulsa un botón
        onTap: (index) {
          setState(() {
            _selectedIndex = index;

            if (index == 0) {
              _counter = 0;        // Reset
            } else if (index == 1) {
              _counter--;          // Restar
            } else if (index == 2) {
              _counter++;          // Sumar
            }
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'Reset',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove),
            label: '-1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '+1',
          ),
        ],
      ),
    );
  }
}
