import 'package:farmflow/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
  scaffoldBackgroundColor: const Color(0xFFE0E0E0),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF3482FF),
    brightness: Brightness.light,
    secondary: Color.fromARGB(255, 243, 206, 45),
    error: Colors.red,
  ),
  cardTheme: const CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
);
void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: const Homescreen());
  }
}
