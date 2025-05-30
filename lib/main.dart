import 'package:flutter/material.dart';
import 'package:simple_to_do_app/theme/app_theme.dart';

import 'screens/task_list_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
            AppTheme.toggleTheme();
          });
        },
      ),
      theme: AppTheme.lightTheme ,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.isDarkMode ?  ThemeMode.dark : ThemeMode.light,
    );
  }
}