import 'package:flutter/material.dart';
import 'package:hemlife/screens/Donor.dart';
import 'package:hemlife/screens/Hospital.dart';

class Donor extends StatefulWidget {
  const Donor({super.key, this.page = 'login'});
  final String page;

  @override
  State<Donor> createState() => _Donor();
}

class _Donor extends State<Donor> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _bloodGroupController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Sansita',
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.person, color: Colors.white, size: 33.0),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _dobController,
                          keyboardType: TextInputType.datetime,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Sansita',
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.calendar_today, color: Colors.white, size: 33.0),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _bloodGroupController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Blood Group',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Sansita',
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.bloodtype, color: Colors.white, size: 33.0),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your blood group';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Sansita',
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.phone, color: Colors.white, size: 33.0),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Email Id',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Sansita',
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.email, color: Colors.white, size: 33.0),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email id';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Sansita',
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.lock, color: Colors.white, size: 33.0),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () {
                          // Handle button tap
                          if (_formKey.currentState!.validate()) {
                            // Add your action here
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BloodRequestListScreen (page: 'login'),
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
}
