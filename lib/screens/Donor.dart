import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BloodRequestListApp());
}

class BloodRequestListApp extends StatelessWidget {
  const BloodRequestListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  Future<void> _signInAnonymously(BuildContext context) async {
    await FirebaseAuth.instance.signInAnonymously();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BloodRequestListScreen(
          page: 'donor',
          email: 'donor@example.com',
          donorBloodType: 'A+',
          bloodRequests: [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _signInAnonymously(context);
          },
          child: const Text('Sign In Anonymously'),
        ),
      ),
    );
  }
}

class BloodRequestListScreen extends StatefulWidget {
  final String page;
  final String email;
  final String donorBloodType;
  final List bloodRequests;

  const BloodRequestListScreen({super.key, 
  
    required this.page,
    required this.email,
    required this.donorBloodType,
    required this.bloodRequests,
  });

  @override
  _BloodRequestListScreenState createState() => _BloodRequestListScreenState();
}

class _BloodRequestListScreenState extends State<BloodRequestListScreen> {
  final List<BloodRequest> _bloodRequests = [];
  final List<HospitalBloodRequest> _hospitalBloodRequests = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchBloodRequests();
    _fetchHospitalBloodRequests();
  }

  Future<void> _fetchBloodRequests() async {
    try {
      QuerySnapshot bloodRequestsSnapshot = await FirebaseFirestore.instance
          .collection('bloodRequests')
          .get();

      if (bloodRequestsSnapshot.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      List<BloodRequest> bloodRequests = [];

      bloodRequests.addAll(bloodRequestsSnapshot.docs.map((doc) {
        return BloodRequest(
          bloodBankName: doc['bloodBankName'] ?? 'Unknown',
          bloodBankAddress: doc['bloodBankAddress'] ?? 'Unknown',
          requestDetails: doc.data() as Map<String, dynamic>,
        );
      }));

      setState(() {
        _bloodRequests.addAll(bloodRequests);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching blood requests: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchHospitalBloodRequests() async {
    try {
      QuerySnapshot hospitalBloodRequestsSnapshot = await FirebaseFirestore.instance
          .collection('hospitalBloodRequests')
          .get();

      if (hospitalBloodRequestsSnapshot.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      List<HospitalBloodRequest> hospitalBloodRequests = [];

      hospitalBloodRequests.addAll(hospitalBloodRequestsSnapshot.docs.map((doc) {
        return HospitalBloodRequest(
          hospitalName: doc['hospitalName'] ?? 'Unknown',
          hospitalAddress: doc['hospitalAddress'] ?? 'Unknown',
          requestDetails: doc.data() as Map<String, dynamic>,
        );
      }));

      setState(() {
        _hospitalBloodRequests.clear(); // Clear existing data before updating
        _hospitalBloodRequests.addAll(hospitalBloodRequests); // Add new data
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching hospital blood requests: $e';
        _isLoading = false;
      });
    }
  }

  void _showRequestDetails(BloodRequest request) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Blood Bank: ${request.requestDetails['bloodBankName']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Blood Bank Address: ${request.requestDetails['bloodBankAddress']}'),
                const SizedBox(height: 10),
                ...request.requestDetails.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text('${entry.key}: ${entry.value}'),
                  );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _handleAccept(request);
                        Navigator.pop(context);
                      },
                      child: const Text('Accept'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _handleReject(request);
                        Navigator.pop(context);
                      },
                      child: const Text('Reject'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showHospitalRequestDetails(HospitalBloodRequest request) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hospital: ${request.requestDetails['hospitalName']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Hospital Address: ${request.requestDetails['hospitalAddress']}'),
                const SizedBox(height: 10),
                ...request.requestDetails.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text('${entry.key}: ${entry.value}'),
                  );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _handleHospitalAccept(request);
                        Navigator.pop(context);
                      },
                      child: const Text('Accept'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _handleHospitalReject(request);
                        Navigator.pop(context);
                      },
                      child: const Text('Reject'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleAccept(BloodRequest request) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted request from: ${request.bloodBankName}'),
        duration: const Duration(seconds: 2),
      ),
    );
    // Implement logic to handle acceptance in Firestore if needed
  }

  void _handleReject(BloodRequest request) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rejected request from: ${request.bloodBankName}'),
        duration: const Duration(seconds: 2),
      ),
    );
    // Implement logic to handle rejection in Firestore if needed
  }

  void _handleHospitalAccept(HospitalBloodRequest request) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted request from: ${request.hospitalName}'),
        duration: const Duration(seconds: 2),
      ),
    );
    // Implement logic to handle acceptance for hospital requests in Firestore if needed
  }

  void _handleHospitalReject(HospitalBloodRequest request) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rejected request from: ${request.hospitalName}'),
        duration: const Duration(seconds: 2),
      ),
    );
    // Implement logic to handle rejection for hospital requests in Firestore if needed
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _bloodRequests.length + _hospitalBloodRequests.length,
                    itemBuilder: (context, index) {
                      if (index < _bloodRequests.length) {
                        return ListTile(
                          title: Text(
                            'From Blood Bank: ${_bloodRequests[index].bloodBankName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Blood Bank Address: ${_bloodRequests[index].bloodBankAddress}\nTap for more details',
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () => _showRequestDetails(_bloodRequests[index]),
                        );
                      } else {
                        int hospitalIndex = index - _bloodRequests.length;
                        return ListTile(
                          title: Text(
                            'From Hospital: ${_hospitalBloodRequests[hospitalIndex].hospitalName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Hospital Address: ${_hospitalBloodRequests[hospitalIndex].hospitalAddress}\nTap for more details',
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () => _showHospitalRequestDetails(_hospitalBloodRequests[hospitalIndex]),
                        );
                      }
                    },
                  ),
      ),
    );
  }
}

class BloodRequest {
  final String bloodBankName;
  final String bloodBankAddress;
  final Map<String, dynamic> requestDetails;

  BloodRequest({
    required this.bloodBankName,
    required this.bloodBankAddress,
    required this.requestDetails,
  });
}

class HospitalBloodRequest {
  final String hospitalName;
  final String hospitalAddress;
  final Map<String, dynamic> requestDetails;

  HospitalBloodRequest({
    required this.hospitalName,
    required this.hospitalAddress,
    required this.requestDetails,
  });
}
