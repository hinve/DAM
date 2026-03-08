import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFFFF3E0);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("Cards Pagina"),
        backgroundColor: bg,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Tipos de cards",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),

          //Card básica
          _basicCard(),

          const SizedBox(height: 16),

          // Card con imagen y contenido
          _imageCard(),

          const SizedBox(height: 16),

          // Card interactiva con tap y botones)
          _actionCard(context),
        ],
      ),
    );
  }

  // Card básica 
  Widget _basicCard() {
    return Card(
      elevation: 2,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Esto es una card basica",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Card con imagen y texto
  Widget _imageCard() {
    return Card(
      // recorta la imagen respetando bordes
      clipBehavior: Clip.antiAlias, 
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen superior
          Image.network(
            "https://images.unsplash.com/photo-1604715686140-d5bef96c8b9d?q=80&w=736&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            height: 170,
            fit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Card con imagen",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Aquí agrupamos una imagen, un título y una pequeña descripción. "
                  "Vemos una imagen de un paisaje",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Card completa: tap + botones
  Widget _actionCard(BuildContext context) {
    return InkWell(
      // InkWell permite “efecto splash” al pulsar
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Has pulsado la card (onTap)")),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera personalizada
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Card interactiva",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Incluye onTap y botones de acción",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert, color: Colors.black54),
                ],
              ),

              const SizedBox(height: 14),

              const Text(
                "Este tipo de card se usa mucho en feeds: puedes tocar toda la tarjeta "
                "para navegar o ver detalles, y también tener botones para acciones rápidas.",
              ),

              const SizedBox(height: 14),

              // Botones al final (acciones típicas)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Acción: CANCELAR")),
                      );
                    },
                    child: const Text("CANCELAR"),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Acción: VER MÁS")),
                      );
                    },
                    child: const Text("VER MÁS"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
