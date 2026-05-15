import 'package:flutter/material.dart';
import 'package:optimized_provider_app/Providers/product_provider.dart';
import 'package:optimized_provider_app/Providers/user_provider.dart';
import 'package:optimized_provider_app/Screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(create: (context) => UserProvider(), lazy: true),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: .dark,
        darkTheme: .dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
