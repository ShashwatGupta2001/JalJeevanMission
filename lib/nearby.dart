import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator plugin
import 'dart:math';
import 'complaint_details_screen.dart'; // Import the Complaint class
import '../models/complaint.dart';
import 'remarks_dialog.dart';
import '../models/complaint_card.dart'; // Import the ComplaintCard widget

class NearbyComplaintsScreen extends StatefulWidget {
  @override
  _NearbyComplaintsScreenState createState() => _NearbyComplaintsScreenState();
}

class _NearbyComplaintsScreenState extends State<NearbyComplaintsScreen> {
  List<Complaint> nearbyComplaints = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchNearbyComplaints();
  }

  void fetchNearbyComplaints() async {
    setState(() {
      isLoading = true;
    });

    // Simulating a delay for fetching data
    await Future.delayed(Duration(seconds: 0));

    List<Complaint> fetchedComplaints = mockComplaints();
    Position? currentPosition = await _getCurrentLocation();
    if (currentPosition != null) {
      fetchedComplaints.sort((a, b) {
        double distanceToA = _calculateDistance(
          currentPosition.latitude,
          currentPosition.longitude,
          double.parse(a.latitude),
          double.parse(a.longitude),
        );
        double distanceToB = _calculateDistance(
          currentPosition.latitude,
          currentPosition.longitude,
          double.parse(b.latitude),
          double.parse(b.longitude),
        );
        return distanceToA.compareTo(distanceToB);
      });
      fetchedComplaints = fetchedComplaints.take(10).toList();
    }

    setState(() {
      nearbyComplaints = fetchedComplaints;
      isLoading = false;
    });
  }

  List<Complaint> mockComplaints() {
    // Replace this with actual data fetching logic
    return [
       Complaint(
        image: 'https://media.istockphoto.com/id/1074493878/photo/detail-of-broken-pipe.jpg?s=612x612&w=0&k=20&c=g85jEYVmzVyb3Mpm6u75nZGLgoeAnXX9g077WxvFmjg=',
        latitude: '28.7041',
        longitude: '77.1025',
        address: 'G66M+W5J, Kalyanpur, Kanpur, Uttar Pradesh 208016',
        description:
            'Water leakage is the accidental release of water from a plumbing system, such as pipes, tanks, faucets, or fittings.',
        user_remarks: "Complaint has been located.",
        Complaint_status: 1      
      ),
      Complaint(
        image: 'data:image/jpeg;base64,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',
        latitude: '28.6139',
        longitude: '77.2090',
        address: 'Connaught Place, New Delhi, Delhi 110001',
        description:
            'Pothole on the road causing traffic congestion and potential accidents.',
        user_remarks: "Complaint has been located.",
        Complaint_status: 2    
      ),
      Complaint(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRArkQHe1RCXwixXKw0cXcdCLyidKYS3y3nZg&s',
        latitude: '19.0760',
        longitude: '72.8777',
        address: ' 56/78, 14thA Cross, 2nd Main, Garden Layout, JP Nagar 7th Phase. Landmark: Behind Sparsh Supermarket.',
        description:
            'Garbage overflow issue at the local market, affecting cleanliness.',
        user_remarks: "Team has been sent.",
        Complaint_status: 3       

      ),
    ];
  }

  void navigateToComplaintDetails(Complaint complaint) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComplaintDetailsScreen(complaint: complaint),
      ),
    );
  }

  void showRemarksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return RemarksDialog();
      },
    );
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool serviceStatus = await Geolocator.openLocationSettings();
      if (!serviceStatus) {
        return null;
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return null;
      }
    }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Complaints', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : nearbyComplaints.isEmpty
          ? Center(child: Text('No complaints nearby'))
          : RefreshIndicator(
        onRefresh: () async {
          fetchNearbyComplaints();
        },
        child: ListView.builder(
          itemCount: nearbyComplaints.length,
          itemBuilder: (context, index) {
            return ComplaintCard(
              complaint: nearbyComplaints[index],
              onDetailsTap: navigateToComplaintDetails,
              onRemarksTap: showRemarksDialog,
            );
          },
        ),
      ),
    );
  }
}