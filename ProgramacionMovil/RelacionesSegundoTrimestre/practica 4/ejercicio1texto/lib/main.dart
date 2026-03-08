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
      debugShowCheckedModeBanner: false, // quito el banner
      title: 'richtext_row',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const RichTextRowPage(),
    );
  }
}

// Pantalla con Row y RichText
class RichTextRowPage extends StatelessWidget {
  const RichTextRowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('RichText + Row'),
        centerTitle: true,
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),

      // Pongo dos ejemplos en una Row
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Columna izquierda 
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 18, color: colors.onSurface),
                      children: const [
                        TextSpan(text: 'Maria Jesus '),
                        TextSpan(
                          text: '31 Años',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                          ),
                        ),
                        TextSpan(text: '\nRaquel '),
                        TextSpan(
                          text: '25 Años',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Columna derecha (Ejemplo 2)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.surfaceVariant,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 18, color: colors.onSurface),
                      children: const [
                        TextSpan(text: 'Somos estudiantes de '),
                        TextSpan(
                          text: '2º de Desarrollo de Aplicaciones Multiplataforma',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '\ny estamos aprenciendo sobre '),
                        TextSpan(
                          text: 'Flutter',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
