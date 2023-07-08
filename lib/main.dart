import 'package:flutter/material.dart';
import 'package:flutter_shop/home_screen.dart';
import 'package:flutter_shop/card_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<CartProvider>(
      create: (_) => CartProvider(),
      child: App(),
    ),
  );
}


class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shop',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 183, 27)),
      ),
      home: const HomeScreen(title: 'Flutter Shop Home'),
    );
  }
}