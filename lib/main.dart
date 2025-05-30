import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static bool isDarkModeEnabled = true;

  const MyApp({super.key});

  static void toggleTheme() {
    isDarkModeEnabled = !isDarkModeEnabled;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(
        onThemeChanged: () {
          setState(() {
            MyApp.toggleTheme();
          });
        },
      ),
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: MyApp.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
    );
  }
}