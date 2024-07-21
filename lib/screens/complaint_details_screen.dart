import 'package:flutter/material.dart';
import '../models/complaint.dart'; // Import the Complaint class
import 'remarks_dialog.dart';
import '../map.dart';
class ComplaintDetailsScreen extends StatelessWidget {
  final Complaint complaint;
  
  ComplaintDetailsScreen({required this.complaint,});
  
  void showRemarksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeOut,
          ),
          child: RemarksDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            complaint.image,
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                buildDetailTile('Latitude', complaint.latitude),
                buildDetailTile('Longitude', complaint.longitude),
                buildDetailTile('Address', complaint.address),
                buildDetailTile('description', complaint.description),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Expanded(
            child: ElevatedButton(
              onPressed: () => _showRemarksDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
               padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),),
              child: Text("View All Remarks"),
            ),
          ),
          SizedBox(width: 8), // Add spacing between buttons
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(
                      latitude: double.parse(complaint.latitude),
                            longitude: double.parse(complaint.longitude), // Replace with your longitude
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), ),
              child: Text("View this on Map"),
            ),
          ),
          SizedBox(width: 8), // Add spacing between buttons
          Expanded(
            child: ElevatedButton(
              
              onPressed: () => showRemarksDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white,
                 padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), 
              ),
              child: Text("Update Your Remark"),
            ),
          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  Widget buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
    );
  }
  void _showRemarksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('All Remarks'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(label: Text('User Name')),
                DataColumn(label: Text('Remarks')),
              ],
              rows: List.generate(20, (index) { // Generate sample data
                return DataRow(cells: [
                  DataCell(Text('User ${index + 1}')),
                  DataCell(Text('Remark ${index + 1}')),
                ]);
              }),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  
}
