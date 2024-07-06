import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator plugin
import 'dart:math';

class NearbyComplaintsScreen extends StatefulWidget {
  @override
  _NearbyComplaintsScreenState createState() => _NearbyComplaintsScreenState();
}

class _NearbyComplaintsScreenState extends State<NearbyComplaintsScreen> {
  List<Map<String, dynamic>> complaints = [
    {
      'latitude': '28.7041',
      'longitude': '77.1025',
      'address': '123 Street, City',
      'description': 'Water leakage near the main road.'
    },
    {
      'latitude': '28.7042',
      'longitude': '77.1026',
      'address': '456 Avenue, City',
      'description': 'Pipe burst in the residential area.'
    },
    {
      'latitude': '28.7039',
      'longitude': '77.1023',
      'address': '789 Boulevard, City',
      'description': 'Sewage overflow in the park.'
    },
    {
      'latitude': '28.7050',
      'longitude': '77.1030',
      'address': '101 Main Road, City',
      'description': 'Road damage due to heavy rains.'
    },
    {
      'latitude': '28.7055',
      'longitude': '77.1028',
      'address': '555 Circle, City',
      'description': 'Electric pole leaning dangerously.'
    },
    {
      'latitude': '28.7037',
      'longitude': '77.1021',
      'address': '987 Crescent, City',
      'description': 'Tree fallen blocking traffic.'
    },
    {
      'latitude': '28.7052',
      'longitude': '77.1032',
      'address': '222 Square, City',
      'description': 'Broken water pipeline on the street.'
    },
    {
      'latitude': '28.7049',
      'longitude': '77.1027',
      'address': '777 Park Avenue, City',
      'description': 'Potholes causing accidents near the market.'
    },
    {
      'latitude': '28.7044',
      'longitude': '77.1024',
      'address': '333 Garden Lane, City',
      'description': 'Garbage dump overflowing onto the sidewalk.'
    },
    {
      'latitude': '28.7035',
      'longitude': '77.1019',
      'address': '555 Hill Street, City',
      'description': 'Streetlights not working in residential area.'
    },
    {
      'latitude': '28.7058',
      'longitude': '77.1029',
      'address': '999 Avenue of Stars, City',
      'description': 'Building construction debris blocking the road.'
    },
    {
      'latitude': '28.7033',
      'longitude': '77.1017',
      'address': '111 River View, City',
      'description': 'Broken sidewalk causing tripping hazards.'
    },
    {
      'latitude': '28.7060',
      'longitude': '77.1035',
      'address': '777 Skyline Road, City',
      'description': 'Clogged drain leading to waterlogging.'
    },
    {
      'latitude': '28.7031',
      'longitude': '77.1015',
      'address': '444 Lakeview Drive, City',
      'description': 'Missing manhole cover posing danger to pedestrians.'
    },
    {
      'latitude': '28.7053',
      'longitude': '77.1038',
      'address': '666 Sunrise Avenue, City',
      'description': 'Frequent power cuts in the locality.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _sortComplaintsByDistance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Complaints', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: complaints.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplaintDetailScreen(complaint: complaint),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Latitude: ${complaint['latitude']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Longitude: ${complaint['longitude']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Address: ${complaint['address']}'),
                    Text('Description: ${complaint['description']}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _sortComplaintsByDistance() async {
    Position? currentPosition = await _getCurrentLocation();
    if (currentPosition != null) {
      complaints.sort((a, b) {
        double distanceToA = _calculateDistance(
          currentPosition.latitude,
          currentPosition.longitude,
          double.parse(a['latitude']),
          double.parse(a['longitude']),
        );
        double distanceToB = _calculateDistance(
          currentPosition.latitude,
          currentPosition.longitude,
          double.parse(b['latitude']),
          double.parse(b['longitude']),
        );
        return distanceToA.compareTo(distanceToB);
      });
      complaints = complaints.take(10).toList();
      setState(() {});
    } else {
      // Handle location permission denied or other errors
    }
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show dialog to enable them
      bool serviceStatus = await Geolocator.openLocationSettings();
      if (!serviceStatus) {
        // Location services are not enabled, return null
        return null;
      }
    }

    // Check the current location permission status
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Location permission denied
        return null;
      }
    }

    // Get the current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    double a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // Distance in kilometers
  }
}

class ComplaintDetailScreen extends StatelessWidget {
  final Map<String, dynamic> complaint;

  ComplaintDetailScreen({required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Latitude: ${complaint['latitude']}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Longitude: ${complaint['longitude']}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Address: ${complaint['address']}'),
            Text('Description: ${complaint['description']}'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _showRemarksDialog(context),
                child: Text('Remarks'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRemarksDialog(BuildContext context) {
    final _remarksController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(child: Text('Your Remarks', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
              content: TextField(
                controller: _remarksController,
                decoration: InputDecoration(
                  hintText: 'Enter your remarks on the complaint here',
                  errorText: _remarksController.text.trim().isEmpty ? 'Please enter your remarks' : null,
                ),
                maxLines: null,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_remarksController.text.trim().isEmpty) {
                      setState(() {
                        // Show error or handle empty remarks
                      });
                    } else {
                      Navigator.pop(context); // Dismiss the dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Remark made successfully!'),
                        ),
                      );
                    }
                  },
                  child: Text('Submit Remark'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
