import 'package:flutter/material.dart';
import 'package:optimized_size_app/Features/heavy_feature.dart'
    deferred as heavy;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future openFeature(BuildContext context) async {
    await heavy.loadLibrary();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => heavy.HeavyFeature()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => openFeature(context),
          child: Text('Open Feature'),
        ),
      ),
    );
  }
}
