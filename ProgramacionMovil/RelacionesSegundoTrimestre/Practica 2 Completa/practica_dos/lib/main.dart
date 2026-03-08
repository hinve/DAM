import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// ROOT DE LA APLICACIÓN
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Práctica 2 Scaffold',
      theme: ThemeData(
        useMaterial3: true, 
      ),
      home: const HomePage(),
    );
  }
}


/// HOME PAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;          // Estado del contador
  int _selectedIndex = 0;    // Estado del BottomNavigationBar

  /// Incrementa el contador (FAB y BottomNavigationBar)
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// Cambia la pestaña seleccionada en el BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Con el metodo build construimos el arbol de widgets

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // APPBAR
      appBar: AppBar(
        //texto centrado
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Colors.cyan.shade300,
        title: const Text(
          'Práctica Scaffold',
          style: TextStyle(
            //texto en negrita
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),


      // DRAWER (menú lateral)
      drawer: SizedBox(
        //ancho del drawer
        width: 280,
        //proporciona el panel lateral deslizable
        child: Drawer(
          //permite contenido desplazable
          child: ListView(
            //elimina el padding automatico superior para que quede bien alineado
            padding: EdgeInsets.zero,
            //lista de widget hijos del drawer
            children: [
              //cabecera
              DrawerHeader(
                //decoracion
                decoration: BoxDecoration(color: Colors.cyan.shade300),
                //contenido de la cabecera
                child: const Text(
                  'Menú',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              //primer item del drawer
              ListTile(
                //icono a la izq del texto
                leading: const Icon(Icons.add),
                title: const Text('Incrementar contador'),
                //icono a la derecha(indica la accion)
                trailing: const Icon(Icons.chevron_right),
                //acciona al pulsar el item
                onTap: () {
                  //cambia el estado de la app (contador)
                  _incrementCounter();
                  //cierra el drawer tras la accion
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Resetear contador'),
                onTap: () {
                  setState(() => _counter = 0);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),

      // BODY
      //Container se usa para anadir estilos o bordes
      body: Container(
        // hace que el contenedor ocupe todo el espacio de la pantalla disponible
        width: double.infinity,
        //Aqui va la decoracion del contenedor
        decoration: const BoxDecoration(
          //consigo el degradado en el fondo
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.greenAccent],
            //punto donde empieza el degradado
            begin: Alignment.topLeft,
            //punto donde termina el degradado
            end: Alignment.bottomRight,
          ),
        ),
        //Column coloca sus hijos uno encima del otro en una posicion vertical
        child: Column(
          //centra todos los hijos de la columna
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //imagen 
            Image.network(
              'https://png.pngtree.com/png-clipart/20230914/original/pngtree-bird-vector-png-image_12154107.png',
              width: 120,
            ),
            //espacio vertical entre elementos
            const SizedBox(height: 20),
            //texto descriptivo
            const Text(
              'Número de pulsaciones:',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            //texto del contador
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            //otro espacio vertical entre elementos
            const SizedBox(height: 20),
            //otra imagen
            Image.network(
              'https://png.pngtree.com/png-clipart/20221002/original/pngtree-flying-birds-vector-illustration-png-image_8652072.png',
              width: 120,
            ),
          ],
        ),
      ),


      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        //cuando se pulsa el boton llama a incrementCounter()
        onPressed: _incrementCounter,
        backgroundColor: Colors.cyan,
        //es un widget de presentacion
        child: const Icon(Icons.touch_app),
      ),
      floatingActionButtonLocation:
          //modifica la posicion a centrado horizontalmente en la parte inferior
          FloatingActionButtonLocation.centerFloat,


      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        //Cuando hay 4 o mas items se debe usar fixed
        type: BottomNavigationBarType.fixed,
        //controla que el icono aparece como activo
        currentIndex: _selectedIndex,
        //se ejecuta al pulsar un item
        onTap: _onItemTapped,
        //color del item cuando se selecciona
        selectedItemColor: Colors.cyan,
        //color del item cuando no esta seleccionado
        unselectedItemColor: Colors.grey,
        //lista de items
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: 'Sumar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}
