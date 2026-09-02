import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'store.dart';
import 'main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Luminous Living',
        debugShowCheckedModeBanner: false,
        theme: luminousTheme(),
        home: const MainScreen(),
      ),
    );
  }
}
