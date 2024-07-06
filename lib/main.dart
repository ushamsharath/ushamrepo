
import 'package:flutter/material.dart';
//import 'package:bloc_flutter/features/home/ui/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hemlife/screens/Donor.dart';
import 'package:hemlife/screens/bloodbank.dart';
import 'package:hemlife/screens/donor2.dart';
import 'package:hemlife/screens/sigin2.dart';
import 'package:hemlife/screens/splashscreen.dart';
import 'package:hemlife/signin.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        /*theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
        ),*/
        home: SplashScreen ());
  }
}