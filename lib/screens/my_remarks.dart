

import 'package:flutter/material.dart';
import '../models/complaint.dart'; // Import the Complaint class
import 'complaint_details_screen.dart';
import 'remarks_dialog.dart';
import '../models/complaint_card.dart'; // Import the ComplaintCard widget

class MyRemarks extends StatefulWidget {
  @override
  _MyRemarksState createState() => _MyRemarksState();
}

class _MyRemarksState extends State<MyRemarks> {
  List<Complaint> MyRemarks = [];
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

    // Replace with actual data fetching logic
    await Future.delayed(Duration(seconds: 0)); // Simulating a delay

    setState(() {
      MyRemarks = mockComplaints();
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
        image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Ffudgeinsurance.com%2Fwater-leak-mitigation%2F&psig=AOvVaw2j6-cc5NHTCv3M9kn7Yoj5&ust=1721756930583000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCPC82MOau4cDFQAAAAAdAAAAABAE',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Remarks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : MyRemarks.isEmpty
              ? Center(child: Text('No remarks to show'))
              : RefreshIndicator(
                  onRefresh: () async {
                    // await fetchNearbyComplaints();
                  },
                  child: ListView.builder(
                    itemCount: MyRemarks.length,
                    itemBuilder: (context, index) {
                      return ComplaintCard(
                        complaint: MyRemarks[index],
                        onDetailsTap: navigateToComplaintDetails,
                        onRemarksTap: showRemarksDialog,
                      );
                    },
                  ),
                ),
    );
  }
}
