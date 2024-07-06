import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hemlife/screens/verification.dart';
import 'package:hemlife/screens/verificationblood.dart';

class SignupScreen1 extends StatefulWidget {
  const SignupScreen1({super.key, required this.page});
  final String page;

  @override
  _SignupScreen1State createState() => _SignupScreen1State();
}

class _SignupScreen1State extends State<SignupScreen1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _signup() async {
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();
    String mobile = _mobileController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (name.isEmpty || address.isEmpty || mobile.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill all the fields', Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        print('User created: ${user.uid}');
        await _firestore.collection('BloodBank').doc(user.uid).set({
          'name': name,
          'address': address,
          'mobile': mobile,
          'email': email,
          'uid': user.uid,
        });

        await user.sendEmailVerification();
        _showSnackBar('Signup Successful, please verify your email.', Colors.green);
        print('Verification email sent to: $email');

        print('Navigating to OTP verification screen'); // Debug print

        // Ensure context is still valid before navigating
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreenBloodBank(
              email: email,
              name: name,
              // Adjust based on your requirements
               // Adjust based on your requirements
               address: '', mobile: '', uid: '', 
            ),
          ),
        );
      } else {
        print('User is null');
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      _showSnackBar('Signup Failed: ${e.message}', Colors.red);
    } catch (e) {
      print('Exception: $e');
      _showSnackBar('An error occurred: ${e.toString()}', Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 17, 5),
        title: const Center(
          child: Text(
            'Blood Requests',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Name of the BloodBank',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Sansita',
                  ),
                  prefixIcon: Icon(
                    Icons.local_hospital,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _addressController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Sansita',
                  ),
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _mobileController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Sansita',
                  ),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Sansita',
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Sansita',
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                          fontFamily: 'Sansita',
                          color: Colors.blue,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
