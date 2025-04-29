import 'package:flutter/material.dart';
import 'login_screen.dart';



void main() {
  runApp(const MiniPayApp());
}

class MiniPayApp extends StatelessWidget {
  const MiniPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MiniPay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
