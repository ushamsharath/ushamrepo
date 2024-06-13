import 'package:flutter/material.dart';
import 'package:hemlife/screens/Donor.dart';
import 'package:hemlife/screens/Hospital.dart';
import 'package:hemlife/screens/bloodbank.dart';
import 'package:hemlife/screens/management.dart';
import 'package:hemlife/screens/splashscreen.dart';
import 'package:hemlife/signin.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hemlife',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF49B6F3)),
        useMaterial3: true,
      ),
      home: const SplashScreen()
    );
  }
}

