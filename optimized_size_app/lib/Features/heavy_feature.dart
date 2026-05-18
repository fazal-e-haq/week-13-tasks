import 'package:flutter/material.dart';

class HeavyFeature extends StatelessWidget {
  const HeavyFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heavy features')),
      body: const Center(child: Text('Loading')),
    );
  }
}
