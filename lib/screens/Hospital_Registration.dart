import 'package:flutter/material.dart';

class HospitalRegistrationScreen extends StatelessWidget {
  const HospitalRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Registration'),
      ),
      body: const Center(
        child: Text('Hospital Registration Form goes here.'),
      ),
    );
  }
}
