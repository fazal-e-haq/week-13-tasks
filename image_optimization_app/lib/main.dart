import 'package:flutter/material.dart';
import 'package:image_optimization_app/Screens/image_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: .dark(),
      themeMode: .dark,
      home: const ImageViewScreen(),
    );
  }
}
