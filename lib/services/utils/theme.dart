import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white38,
  hintColor: Colors.blueAccent,
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        WidgetStateProperty.all(Colors.blue), // Thumb color when enabled
    trackColor: WidgetStateProperty.all(
        Colors.blue.withOpacity(0.4)), // Track color when enabled
    overlayColor: WidgetStateProperty.all(
        Colors.blue.withOpacity(0.2)), // Overlay color when pressed
    thumbIcon: WidgetStateProperty.all(
        const Icon(Icons.light_mode, color: Colors.white) // Icon color
        ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
  ),
  iconTheme: const IconThemeData(
    color: Colors.blue,
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.grey[800],
  hintColor: Colors.tealAccent,
  scaffoldBackgroundColor: Colors.black,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.teal,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.teal,
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        WidgetStateProperty.all(Colors.teal), // Thumb color when enabled
    trackColor: WidgetStateProperty.all(
        Colors.teal.withOpacity(0.4)), // Track color when enabled
    overlayColor: WidgetStateProperty.all(
        Colors.teal.withOpacity(0.2)), // Overlay color when pressed
    thumbIcon: WidgetStateProperty.all(
        const Icon(Icons.nightlight_round, color: Colors.white) // Icon color
        ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  iconTheme: const IconThemeData(
    color: Colors.tealAccent,
  ),
);
