import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hemlife/screens/management.dart';
import 'package:hemlife/screens/welcomescreen.dart'; // Ensure this import is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dropAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _blastAnimation;
  late Animation<Color?> _backgroundColorAnimation; // Animation for background color
  late Animation<double> _scatteringAnimation; // Animation for scattering effect
  bool _isBlastComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Extended duration
      vsync: this,
    );
    _dropAnimation = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _blastAnimation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Background color animation
    _backgroundColorAnimation = ColorTween(
      begin: Colors.transparent, // Start with transparent color
      end: const Color.fromARGB(255, 130, 13, 5) // End with red color
    ).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0)), // Starts after drop animation
    );

    // Scattering animation
    _scatteringAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1.0)), // Starts after background color animation
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isBlastComplete = true;
        });
        // Print debug statement
        print('Animation completed, navigating to WelcomeScreen');
        // Navigate to the WelcomeScreen after a short delay to show the final state
        Timer(const Duration(seconds: 1), () {
          // Ensure context is valid and Navigator is used correctly
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const UserSelectionScreen()),
            );
          } else {
            // Print debug statement if context is invalid
            print('Context is not valid for navigation');
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color animation
          AnimatedBuilder(
            animation: _backgroundColorAnimation,
            builder: (context, child) {
              return Container(
                color: _backgroundColorAnimation.value,
                child: child,
              );
            },
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height / 2 + _dropAnimation.value,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: _isBlastComplete
                    ? CustomPaint(
                        painter: BlastPainter(_blastAnimation.value),
                      )
                    : child!,
              );
            },
            child: const Icon(
              Icons.opacity,
              size: 50.0,
              color:Color.fromARGB(255, 130, 13, 5) ,
            ),
          ),
          // Hemlife text animation
          AnimatedBuilder(
            animation: _scatteringAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _scatteringAnimation.value,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    MediaQuery.of(context).size.height *
                        (1 - _scatteringAnimation.value),
                  ),
                  child: child,
                ),
              );
            },
            // Conditionally render Hemlife text
            child: _isBlastComplete
                ? Center(
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: const Text(
                        'HEMLIFE',
                        style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                          fontFamily: 'Sansita',
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class BlastPainter extends CustomPainter {
  final double radius;

  BlastPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 130, 13, 5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(const Offset(0, 0), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
