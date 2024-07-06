import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BloodBankApp(page: '', bloodGroup: '', uid: '',));
}

class BloodBankApp extends StatelessWidget {
  const BloodBankApp({super.key, required String page, required String bloodGroup, required String uid});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BloodBankRequestForm(),
    );
  }
}

class BloodBankRequestForm extends StatefulWidget {
  const BloodBankRequestForm({super.key});

  @override
  _BloodBankRequestFormState createState() => _BloodBankRequestFormState();
}

class _BloodBankRequestFormState extends State<BloodBankRequestForm> {
  final _formKey = GlobalKey<FormState>();


  String bloodBankName = '';
  String bloodBankAddress = '';
  String contactPerson = '';
  String contactPhoneNumber = '';
  String emailAddress = '';
  String bloodType = 'A+';
  String unitsOfBlood = '';
  String dateRequired = '';
  String urgencyLevel = 'Routine';
  String patientName = '';
  String patientID = '';
  String diagnosis = '';
  String comments = '';

  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<String> urgencyLevels = ['Routine', 'Urgent', 'Emergency'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blood Bank Request Form',
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
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 189, 17, 5),
              Color.fromARGB(255, 34, 34, 107),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _buildTextFormField('Blood Bank Name', (value) => bloodBankName = value!),
                _buildTextFormField('Blood Bank Address', (value) => bloodBankAddress = value!),
                _buildTextFormField('Contact Person', (value) => contactPerson = value!),
                _buildTextFormField('Contact Phone Number', (value) => contactPhoneNumber = value!, keyboardType: TextInputType.phone),
                _buildTextFormField('Email Address', (value) => emailAddress = value!, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16.0),
                _buildDropdownFormField('Blood Type Required', bloodTypes, bloodType, (value) => setState(() => bloodType = value!)),
                _buildTextFormField('Units of Blood Needed', (value) => unitsOfBlood = value!, keyboardType: TextInputType.number),
                _buildTextFormField('Date Required', (value) => dateRequired = value!),
                _buildDropdownFormField('Urgency Level', urgencyLevels, urgencyLevel, (value) => setState(() => urgencyLevel = value!)),
                const SizedBox(height: 16.0),
                _buildTextFormField('Patient Name', (value) => patientName = value!),
                _buildTextFormField('Patient ID', (value) => patientID = value!),
                _buildTextFormField('Diagnosis', (value) => diagnosis = value!),
                _buildTextFormField('Additional Comments', (value) => comments = value!),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _submitForm();
                    }
                  },
                  child: const Text('Submit Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String labelText, Function(String?) onSaved, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Sansita',
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
        keyboardType: keyboardType,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildDropdownFormField(String labelText, List<String> items, String value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Sansita',
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            icon: const Icon(Icons.arrow_downward, color: Colors.white),
            dropdownColor: Colors.blue,
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            onChanged: onChanged,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    final requestData = {
      'bloodBankName': bloodBankName,
      'bloodBankAddress': bloodBankAddress,
      'contactPerson': contactPerson,
      'contactPhoneNumber': contactPhoneNumber,
      'emailAddress': emailAddress,
      'bloodType': bloodType,
      'unitsOfBlood': unitsOfBlood,
      'dateRequired': dateRequired,
      'urgencyLevel': urgencyLevel,
      'patientName': patientName,
      'patientID': patientID,
      'diagnosis': diagnosis,
      'comments': comments,
    };

    try {
      // Log requestData to debug console
      print('Submitting request with data: $requestData');

      // Add document to Firestore
      await FirebaseFirestore.instance.collection('bloodRequests').add(requestData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Blood bank request submitted'),
          duration: Duration(seconds: 2),
        ),
      );

      // Clear form fields after successful submission
      _formKey.currentState!.reset();
      setState(() {
        bloodBankName = '';
        bloodBankAddress = '';
        contactPerson = '';
        contactPhoneNumber = '';
        emailAddress = '';
        bloodType = 'A+';
        unitsOfBlood = '';
        dateRequired = '';
        urgencyLevel = 'Routine';
        patientName = '';
        patientID = '';
        diagnosis = '';
        comments = '';
      });
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit request: $e'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Log the error for debugging
      print('Error submitting request: $e');
    }
  }
}
