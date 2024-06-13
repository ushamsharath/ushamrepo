import 'package:flutter/material.dart';
import 'package:hemlife/screens/Hospital.dart';
// Ensure this path is correct

class Hospital extends StatefulWidget {
  const Hospital({super.key, required this.page});  
  final String page;

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _uniqueCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _uniqueCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 17, 5),
        title: const Center(
          child: Text(
            'Hemlife',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sansita',
            ),
          ),
        ),
        automaticallyImplyLeading: false,
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      _buildTextFormField(
                        controller: _nameController,
                        label: 'Name of the hospital',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your hospital name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextFormField(
                        controller: _uniqueCodeController,
                        label: 'Unique Code',
                        icon: Icons.code,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the unique code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextFormField(
                        controller: _phoneController,
                        label: 'Mobile Number',
                        icon: Icons.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextFormField(
                        controller: _emailController,
                        label: 'Email Id',
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email id';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextFormField(
                        controller: _passwordController,
                        label: 'Password',
                        icon: Icons.lock,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BloodRequestApp(page: 'login'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 60.0,
                          width: 215.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Color(0xff49B6F3),
                                fontSize: 21.0,
                                fontFamily: 'Sansita',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
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

  Padding _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: 'Sansita',
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(icon, color: Colors.white, size: 33.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(65.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 4.3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(65.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 4.0,
            ),
          ),
          errorStyle: const TextStyle(color: Color.fromARGB(255, 254, 251, 251)),
        ),
        cursorColor: Colors.white,
        validator: validator,
      ),
    );
  }
}
