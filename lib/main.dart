import 'package:flutter/material.dart';
import 'shop_profile_screen.dart';

void main() {
  runApp(const ViptoApp());
}

class ViptoApp extends StatelessWidget {
  const ViptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vipto - Shop Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFF6B35),
        scaffoldBackgroundColor: const Color(0xFFF7F7F9),
        fontFamily: 'Roboto',
      ),
      home: const ShopProfileScreen(),
    );
  }
}
