import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/complaint.dart'; // Import the Complaint class
import '../map.dart';
import 'progress.dart';
class ComplaintCard extends StatelessWidget {
  final Complaint complaint;
  final void Function(Complaint) onDetailsTap;
  final void Function(BuildContext) onRemarksTap;

  ComplaintCard({
    required this.complaint,
    required this.onDetailsTap,
    required this.onRemarksTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onDetailsTap(complaint),
      
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 5,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      complaint.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
               
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    complaint.address,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),
                  Text(
                    complaint.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
             
                  SizedBox(height: 6),
                  Text(
                    "Your Remark : "+complaint.user_remarks,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                 SizedBox(height: 6),
                ComplaintProgress(currentStage: complaint.Complaint_status),
                SizedBox(height: 6),
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
              
              onPressed: () => onRemarksTap(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white,
                 padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), 
              ),
              child: Text("Update Remark"),
            ),
          ),
        ],
      ),
                ],
              ),
            ),
          ],
        ),
      ),
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