import 'package:flutter/material.dart';

class ButtonsScreen extends StatelessWidget {
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Color de fondo
    const bg = Color(0xFFE8F5E9);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text("Botones"),
      ),
      body: Center(
        // Limito el ancho para que quede como si fuera una columna
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                //ELEVATED
                _spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: null, 
                    child: const Text("ElevatedButton deshabilitado"),
                  ),
                ),
                _spacer(sm: true),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: const Text("ElevatedButton normal"),
                  ),
                ),
                _spacer(sm: true),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.save),
                    label: const Text("ElevatedButton con icono"),
                  ),
                ),

                // FILLED
                _spacer(big: true),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: null,
                    child: const Text("FilledButton deshabilitado"),
                  ),
                ),
                _spacer(sm: true),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text("FilledButton normal"),
                  ),
                ),
                _spacer(sm: true),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.save),
                    label: const Text("FilledButton con icono"),
                  ),
                ),

                //FILLED TONAL
                _spacer(big: true),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonal(
                    onPressed: () {},
                    child: const Text("FilledButton tonal"),
                  ),
                ),
                _spacer(sm: true),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonalIcon(
                    onPressed: () {},
                    icon: const Icon(Icons.save),
                    label: const Text("FilledButton tonal icon"),
                  ),
                ),

                //OUTLINED
                _spacer(big: true),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: null,
                    child: const Text("OutlinedButton deshabilitado"),
                  ),
                ),
                _spacer(sm: true),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("OutlinedButton normal"),
                  ),
                ),
                _spacer(sm: true),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.save),
                    label: const Text("OutlinedButton con icono"),
                  ),
                ),

                //TEXT
                _spacer(big: true),
                TextButton(
                  onPressed: null,
                  child: const Text("TextButton deshabilitado"),
                ),
                _spacer(sm: true),
                TextButton(
                  onPressed: () {},
                  child: const Text("TextButton normal"),
                ),
                _spacer(sm: true),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                  label: const Text("TextButton con icono"),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Separadores para que quede parecido al ejemplo
  Widget _spacer({bool sm = false, bool big = false}) {
    if (big) return const SizedBox(height: 26);
    if (sm) return const SizedBox(height: 10);
    return const SizedBox(height: 14);
  }
}
