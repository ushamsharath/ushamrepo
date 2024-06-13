import 'package:flutter/material.dart';

class BloodBankRegistrationScreen extends StatelessWidget {
  const BloodBankRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Bank Registration'),
      ),
      body: const Center(
        child: Text('Blood Bank Registration Form goes here.'),
      ),
    );
  }
}
