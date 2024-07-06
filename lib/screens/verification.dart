import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hemlife/screens/Donor.dart'; // Import your BloodRequestListScreen

class OTPVerificationScreen extends StatelessWidget {
  final String email;
  final String name;
  final String dob;
  final String bloodGroup;
  final String phone;

  const OTPVerificationScreen({
    super.key,
    required this.email,
    required this.name,
    required this.dob,
    required this.bloodGroup,
    required this.phone,
  });

  void _checkEmailVerified(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user != null && user.emailVerified) {
      // Store data to Firestore if needed
      // Example: FirebaseFirestore.instance.collection('donors').doc(user.uid).set({
      //   'name': name,
      //   'dob': dob,
      //   'bloodGroup': bloodGroup,
      //   'phone': phone,
      //   'email': email,
      // });

      Fluttertoast.showToast(msg: 'Email verified successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BloodRequestListScreen(
            page: 'true',
            email: email, bloodRequests: const [], donorBloodType: '',
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Email not verified yet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 17, 5),
        title: const Center(
          child: Text(
            'Verify Email',
            style: TextStyle(
              fontFamily: 'Sansita',
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 189, 17, 5),
              Color.fromARGB(255, 34, 34, 107),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Verification email sent to $email.',
                style: const TextStyle(
                  fontFamily: 'Sansita',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _checkEmailVerified(context),
                child: const Text('Check Verification',
                style: TextStyle(fontFamily: 'Sansita'),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}