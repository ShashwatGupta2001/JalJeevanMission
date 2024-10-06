class Complaint {
  final String image;
  final String latitude;
  final String longitude;
  final String address;
  final String description;
  final String user_remarks;
   int Complaint_status;
  Complaint({
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.description,
    required this.user_remarks,
    required this.Complaint_status,
  });
   factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      description: json['description'],
      user_remarks: json['user_remarks'],
      Complaint_status: json['Complaint_status'],
    );
  }
}