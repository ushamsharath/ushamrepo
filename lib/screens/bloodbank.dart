import 'package:flutter/material.dart';

class BloodBankApp extends StatelessWidget {
  const BloodBankApp({super.key, required String page,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Bank Request Form',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const BloodBankForm(),
    );
  }
}

class BloodBankForm extends StatefulWidget {
  const BloodBankForm({super.key,});

  @override
  _BloodBankFormState createState() => _BloodBankFormState();
}

class _BloodBankFormState extends State<BloodBankForm> {
  final _formKey = GlobalKey<FormState>();

  String bloodBankName = '';
  String bloodBankAddress = '';
  String contactPerson = '';
  String contactPhoneNumber = '';
  String emailAddress = '';
  String bloodType = 'A+';
  String unitsOfBlood = '';
  DateTime dateRequired = DateTime.now();
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Blood Bank Information
              TextFormField(
                decoration: const InputDecoration(labelText: 'Blood Bank Name', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => bloodBankName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Blood Bank Address', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => bloodBankAddress = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Person', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => contactPerson = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Phone Number', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => contactPhoneNumber = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email Address', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => emailAddress = value!,
              ),
              const SizedBox(height: 16.0),
              // Blood Request Details
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Blood Type Required', labelStyle: TextStyle(color: Colors.white)),
                value: bloodType,
                items: bloodTypes.map((String type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => bloodType = value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Units of Blood Needed', labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                onSaved: (value) => unitsOfBlood = value!,
              ),
              ListTile(
                title: Text("Date Required: ${dateRequired.toLocal()}".split(' ')[0]),
                trailing: const Icon(Icons.calendar_today, color: Colors.white),
                onTap: _selectDate,
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Urgency Level', labelStyle: TextStyle(color: Colors.white)),
                value: urgencyLevel,
                items: urgencyLevels.map((String level) {
                  return DropdownMenuItem(value: level, child: Text(level));
                }).toList(),
                onChanged: (value) => setState(() => urgencyLevel = value!),
              ),
              const SizedBox(height: 16.0),
              // Patient Information
              TextFormField(
                decoration: const InputDecoration(labelText: 'Patient Name', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => patientName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Patient ID (if any)', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => patientID = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Diagnosis/Reason for Blood Request', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => diagnosis = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Comments/Additional Notes', labelStyle: TextStyle(color: Colors.white)),
                onSaved: (value) => comments = value!,
              ),
              const SizedBox(height: 16.0),
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Request',),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateRequired,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dateRequired) {
      setState(() {
        dateRequired = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process the submitted data
      print('Blood Bank Name: $bloodBankName');
      print('Blood Bank Address: $bloodBankAddress');
      print('Contact Person: $contactPerson');
      print('Contact Phone Number: $contactPhoneNumber');
      print('Email Address: $emailAddress');
      print('Blood Type Required: $bloodType');
      print('Units of Blood Needed: $unitsOfBlood');
      print('Date Required: $dateRequired');
      print('Urgency Level: $urgencyLevel');
      print('Patient Name: $patientName');
      print('Patient ID: $patientID');
      print('Diagnosis/Reason for Blood Request: $diagnosis');
      print('Comments/Additional Notes: $comments');
    }
  }
}
