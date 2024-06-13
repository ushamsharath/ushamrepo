 import 'package:flutter/material.dart';
import 'package:hemlife/signin.dart';
import 'package:lottie/lottie.dart';
// Import the GetOTPScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required String userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hemlife',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Sansita',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 189, 17, 5),
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 250),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the GetOTPScreen with page set to 'register'
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Donor(page: 'register')),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 47),
                              const Text(
                                'Register',
                                style: TextStyle(
                                  fontFamily: 'Sansita',
                                  fontSize: 45,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 27),
                              SizedBox(
                                height: 75,
                                width: 75,
                                child: Lottie.asset(
                                  'assets/register.json',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          // Navigate to the GetOTPScreen with page set to 'login'
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Donor(page: 'login')),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 65),
                              const Text(
                                'Signin',
                                style: TextStyle(
                                  fontFamily: 'Sansita',
                                  fontSize: 45,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 27),
                              SizedBox(
                                height: 75,
                                width: 75,
                                child: Lottie.asset(
                                  'assets/signin.json',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Elevate your experience and unlock exclusive features by registering or signing in with your credentials today!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Sansita',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}