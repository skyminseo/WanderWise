import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wander_wise/components/profile_textbox.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/start_screen.dart';

class MyPageScreen extends StatefulWidget {
  MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit " + field),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Enter new " + field,
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (newValue.isNotEmpty) {
                  // Update the Firestore document
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(currentUser.email)
                      .update({field: newValue});
                }
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => StartScreen()),
      (route) => false,
    );
  }

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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                SizedBox(height: 50),
                Icon(
                  Icons.account_circle_rounded,
                  size: 68,
                ),
                SizedBox(height: 10),
                Text(
                  'Hello! ' + currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[700]),
                ),
                Divider(
                  thickness: 1,
                  height: 20,
                  indent: 24,
                  endIndent: 24,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 25),
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
                  content: userData['username'] ?? '',
                  sectionName: 'Username',
                  onPressed: () => editField('username'),
                  icons: Icon(Icons.drive_file_rename_outline_rounded),
                ),
                ProfileTextbox(
                  content: userData['phone'] ?? '',
                  sectionName: 'Phone',
                  onPressed: () => editField('phone'),
                  icons: Icon(Icons.phone),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: darkBlueColor,
              strokeWidth: 4.0,
            ),
          );
        },
      ),
    );
  }
}
