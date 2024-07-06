import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hemlife/screens/bloodbank.dart';

class OTPVerificationScreenBloodBank extends StatelessWidget {
  final String email;
  final String name;
  final String address;
  final String mobile;
  final String uid;

  const OTPVerificationScreenBloodBank({
    super.key,
    required this.email,
    required this.name,
    required this.address,
    required this.mobile,
    required this.uid,
  });

  void _checkEmailVerified(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user != null && user.emailVerified) {
      // Store data to Firestore
      await FirebaseFirestore.instance.collection('BloodBank').doc(user.uid).set({
        'name': name,
        'address': address,
        'mobile': mobile,
        'email': email,
        'uid': uid,
      });

      Fluttertoast.showToast(msg: 'Email verified successfully');
      // Navigate to the BloodBankApp with appropriate parameters
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BloodBankApp(uid: uid, page: 'true', bloodGroup: '',),
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
                child: const Text(
                  'Check Verification',
                  style: TextStyle(fontFamily: 'Sansita'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
