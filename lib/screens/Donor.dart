import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BloodRequestListScreen extends StatefulWidget {
  const BloodRequestListScreen({super.key, required String page});

  @override
  _BloodRequestListScreenState createState() => _BloodRequestListScreenState();
}

class _BloodRequestListScreenState extends State<BloodRequestListScreen> {
  // Placeholder list of blood requests
  final List<BloodRequest> _bloodRequests = [
    BloodRequest(
      requestType: BloodRequestType.Hospital,
      requestDetails: 'Hospital A needs A+ blood urgently',
    ),
    BloodRequest(
      requestType: BloodRequestType.BloodBank,
      requestDetails: 'Blood Bank B needs B- blood for surgery' 
    ),
    BloodRequest(
      requestType: BloodRequestType.Hospital,
      requestDetails: 'Hospital C needs O- blood for patient',
    ),
  ];

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
        child: ListView.builder(
          itemCount: _bloodRequests.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _bloodRequests[index].requestDetails,
                style: const TextStyle(
                  color: Colors.white, // Change the color of the request details text to white
                ),
              ),
              subtitle: Text(
                _bloodRequests[index].requestType == BloodRequestType.Hospital
                    ? 'From: Hospital'
                    : 'From: Blood Bank',
                style: const TextStyle(color: Colors.white),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle accept action
                      _handleAccept(_bloodRequests[index]);
                    },
                    child: const Text('Accept'),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle reject action
                      _handleReject(_bloodRequests[index]);
                    },
                    child: const Text('Reject'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleAccept(BloodRequest request) {
    // Placeholder function for handling accept action
    print('Accepted request: ${request.requestDetails}');
  }

  void _handleReject(BloodRequest request) {
    // Placeholder function for handling reject action
    print('Rejected request: ${request.requestDetails}');
  }
}

enum BloodRequestType {
  Hospital,
  BloodBank,
}

class BloodRequest {
  final BloodRequestType requestType;
  final String requestDetails;

  BloodRequest({
    required this.requestType,
    required this.requestDetails,
  });
}
