import 'package:flutter/material.dart';
import 'package:simple_to_do_app/theme/app_theme.dart';

import 'screens/task_list_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: TaskListScreen(),
    );
  }
}