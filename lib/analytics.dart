import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageColumnPage(),
    );
  }
}

class ImageColumnPage extends StatefulWidget {
  @override
  _ImageColumnPageState createState() => _ImageColumnPageState();
}

class _ImageColumnPageState extends State<ImageColumnPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _slidingImageUrls = [
    'assets/4.jpg',
    'assets/5.webp',
    'assets/6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _slidingImageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 80, 129),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListView(
          children: [
            _buildSlidingImageContainer(),
            
            _buildImageContainer('assets/8.png'),
            _buildImageContainer('assets/3.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildSlidingImageContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 200,
      width: 400,
      
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: PageView.builder(
          controller: _pageController,
          itemCount: _slidingImageUrls.length,
          itemBuilder: (context, index) {
            return Image.asset(
              _slidingImageUrls[index],
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 300,
        width: 400,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
