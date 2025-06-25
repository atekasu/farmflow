import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:farmflow/screen/homescreen.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 33, 150, 243),
  ),
  brightness: Brightness.light,
  //textTheme: GoogleFonts.robotoTextTheme(),
  textTheme: const TextTheme(),
);
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Homescreen(),
      //デバックバナーを表示
      debugShowCheckedModeBanner: false,
      //フォントをGoogle Fontsで設定
    );
  }
}
