import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'screens/my_complaints.dart';
import 'screens/my_remarks.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = 'Atishay Jain';
  String phonenumber = '+916261691496';
  final _formKey = GlobalKey<FormState>();
  final _numberFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    // appBar: AppBar(
    //   title: Row(
    //     children: [
    //       Text(''),
    //       Image.asset(
    //         'assets/appbar.png',
    //         height: 40,
    //       ),
    //     ],
    //   ),
    //   backgroundColor: Color(0xff024c89),
    // ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            // 1st ClipRRect box with profile details and buttons
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: Color(0xff3e6b91),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/copy.jpg'), // Replace with your image asset
                    ),
                    SizedBox(height: 16),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      phonenumber,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showImagePickerDialog(context); // Handle notifications action
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                              minimumSize: Size(0, 40),
                              textStyle: TextStyle(fontSize: 10),
                            ),
                            child: Text(
                              'Change Profile Picture',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0b3251),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8), // Add spacing between buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _showOtpDialog(_changeUsername);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                              minimumSize: Size(0, 40),
                              textStyle: TextStyle(fontSize: 10),
                            ),
                            child: Text(
                              'Change Username',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0b3251),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8), // Add spacing between buttons
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _showOtpDialog(_changeNumber);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                              minimumSize: Size(0, 40),
                              textStyle: TextStyle(fontSize: 10),
                            ),
                            child: Text(
                              'Change Phone-number',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0b3251),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16), // Add spacing between the two boxes
            // 2nd ClipRRect box with three buttons
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: Color(0xff3e6b91),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 60.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyComplaints()),
                          ); // Handle My Complaints action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Set button color to white
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                        minimumSize: Size(double.infinity, 40), // Make button full-width
                        textStyle: TextStyle(fontSize: 15),
                      ),
                      child: Text(
                        'My Complaints',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0b3251), // Set text color to blue
                        ),
                      ),
                    ),
                    SizedBox(height: 50), // Add spacing between buttons
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyRemarks()),
                          );// Handle My Remarks action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Set button color to white
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                        minimumSize: Size(double.infinity, 40), // Make button full-width
                        textStyle: TextStyle(fontSize: 15),
                      ),
                      child: Text(
                        'My Remarks',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0b3251), // Set text color to blue
                        ),
                      ),
                    ),
                    SizedBox(height: 50), // Add spacing between buttons
                    ElevatedButton(
                      onPressed: () {
                       // Handle Log Out action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Set button color to white
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                        minimumSize: Size(double.infinity, 40), // Make button full-width
                        textStyle: TextStyle(fontSize: 15),
                      ),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0b3251), // Set text color to blue
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  void _changeNumber() {
    showDialog(
      context: context,
      builder: (context) {
        final _numberController = TextEditingController(text: "");
        return AlertDialog(
          title: Text('Change Phonenumber'),
          content: Form(
            key: _numberFormKey,
            child: TextFormField(
              controller: _numberController,
              decoration: InputDecoration(hintText: "Enter new phonenumber"),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phonenumber cannot be empty';
                } else if (value.length != 10) {
                  return 'Phonenumber should be exactly 10 digits long';
                } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Phonenumber should contain only digits';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_numberFormKey.currentState?.validate() ?? false) {
                  setState(() {
                    phonenumber = "+91"+_numberController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showNoNotificationsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('No notifications to show'),
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

  final TextEditingController _otpController = TextEditingController();

  void _showOtpDialog(Function onSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: InputDecoration(
              hintText: 'Enter 6-digit OTP',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _verifyOtp(onSuccess);
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
  }

  void _verifyOtp(Function onSuccess) {
    String otp = _otpController.text;
    // Add OTP verification logic here
    if (otp == "123456") {
      // Replace with actual verification logic
      onSuccess();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP Verified!'),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid OTP!'),
        backgroundColor: Colors.red,
      ));
    }
    _otpController.text = "";
  }
  void _changeUsername() {
    showDialog(
      context: context,
      builder: (context) {
        final _usernameController = TextEditingController(text: "");
        return AlertDialog(
          title: Text('Change Username'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: "Enter new username"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username cannot be empty';
                } else if (value.length < 3) {
                  return 'Username should be at least 3 characters long';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() {
                    username = _usernameController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
 void showImagePickerDialog(BuildContext context) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Upload Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final XFile? pickedImage =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  _image = pickedImage;
                }
              },
              child: Text('Select from Gallery'),
            ),
            SizedBox(height: 6.0,),
            ElevatedButton(
              onPressed: () async {
                final XFile? pickedImage =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  _image = pickedImage;
                }
              },
              child: Text('Take a Photo'),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () async {
              if (_image != null) {
                final Directory appDir = await getApplicationDocumentsDirectory();
                final String filePath = path.join(appDir.path, 'copy.png');
                final File savedImage = await File(_image!.path).copy(filePath);
                print('Image saved at ${savedImage.path}');
              }
              Navigator.of(context).pop();
            },
            child: Text('Change Picture'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
}
