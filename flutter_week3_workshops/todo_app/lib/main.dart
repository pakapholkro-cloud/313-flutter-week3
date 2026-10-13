import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const TodoApp());
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'To-do List',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const HomeScreen(),
  );
}
