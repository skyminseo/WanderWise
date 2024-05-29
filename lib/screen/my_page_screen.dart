import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wander_wise/components/profile_textbox.dart';
import 'package:wander_wise/screen/start_screen.dart';

class MyPageScreen extends StatefulWidget {
  MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => StartScreen()),
      (route) => false,
    );
  }

  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Page"),
        actions: [
          IconButton(
            onPressed: () => signUserOut(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          Icon(
            Icons.account_circle_rounded,
            size: 68,
          ),
          SizedBox(height: 10),
          Text(
            'Hello! ' + user.email!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700]),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          ProfileTextbox(
            content: 'Admin',
            sectionName: 'Username',
            onPressed: () => editField('Username'),
            icons: Icon(Icons.drive_file_rename_outline_rounded),
          ),
          ProfileTextbox(
            content: 'Phone Number',
            sectionName: 'Phone',
            onPressed: () => editField('Phone'),
            icons: Icon(Icons.phone),
          ),
        ],
      ),
    );
  }
}
