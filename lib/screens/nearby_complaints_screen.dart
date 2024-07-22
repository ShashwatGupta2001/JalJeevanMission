import 'package:flutter/material.dart';
import '../models/complaint.dart'; // Import the Complaint class
import 'complaint_details_screen.dart';
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

    // Replace with actual data fetching logic
    await Future.delayed(Duration(seconds: 0)); // Simulating a delay

    setState(() {
      nearbyComplaints = mockComplaints();
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
        user_remarks: "Complaint located.",
        Complaint_status: 1      
      ),
      Complaint(
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfAYeEwP5THuOCiIlp8R3W0mUfqBnNvAj2Gg&s',
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
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Nearby Complaints', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : nearbyComplaints.isEmpty
              ? Center(child: Text('No complaints nearby'))
              : RefreshIndicator(
                  onRefresh: () async {
                    // await fetchNearbyComplaints();
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
