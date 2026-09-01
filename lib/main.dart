import 'package:flutter/material.dart';

void main() => runApp(const MiniStore());

class MiniStore extends StatelessWidget {
  const MiniStore({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Store',
      home: const Scaffold(body: Center(child: Text('Welcome to Mini Store.'))),
    );
  }
}
