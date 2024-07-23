import 'package:flutter/material.dart';
import 'Profile.dart';
import 'screens/nearby_complaints_screen.dart';
import 'map_user.dart';
import 'analytics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Bar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    MapUserPage(),
    ImageColumnPage(),
    NearbyComplaintsScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 80, 129),
        leading: IconButton(
          icon: ClipOval(
            child: SizedBox(
              width: 40, // Adjust the size as needed
              height: 40,
              child: Image.asset('assets/icons/drops.jpg', fit: BoxFit.cover),
            ),
          ),
          onPressed: () {
            // Handle the icon button press
          },
        ),
        title: Text(
          'जल जीवन MISSION',
          style: TextStyle(
            fontSize: 20, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Adjust the font weight as needed
            color: Colors.white, // Adjust the font color as needed
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: ClipOval(
              child: SizedBox(
                width: 40, // Adjust the size as needed
                height: 40,
                child: Image.asset('assets/icons/iitk.jpg', fit: BoxFit.cover),
              ),
            ),
            onPressed: () {
              // Handle the icon button press
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Complaints near me',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile Page',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 21, 80, 129),
        unselectedItemColor: Colors.grey, // Make unselected icons visible
        onTap: _onItemTapped,
      ),
    );
  }
}
