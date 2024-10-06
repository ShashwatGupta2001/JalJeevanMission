// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'navigator.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'runner.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/jjm.png', height: 100),
                      SizedBox(width: 16.0),
                      Image.asset('assets/images/iitk.png', height: 100),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your registered Phone number';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
            
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SplashScreen(nextScreen: MyHomePage(),)),
                        );
                      }
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Google SSO logic
                        },
                        icon: Icon(Icons.account_circle_rounded), // Changed from Icons.google
                        label: Text('Google'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Facebook SSO logic
                        },
                        icon: Icon(Icons.facebook),
                        label: Text('Facebook'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => SignupPage(),
                      );
                    },
                    child: Text('Don\'t have an account? Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}