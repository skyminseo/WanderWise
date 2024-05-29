import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wander_wise/components/custom_appbar.dart';
import 'package:wander_wise/components/textfield_layout.dart';
import 'package:wander_wise/posts/wall_post.dart';
import 'package:wander_wise/resources/color.dart';
import 'package:wander_wise/screen/my_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }
    setState(() {
      textController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueGreyColor,
      appBar: CustomAppBar(title: 'Travel Community',
      ),
      body: Column(
        children: [
          // wall
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy("TimeStamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        message: post['Message'],
                        user: post['UserEmail'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),

          Container(
            color: primaryColor,
            child: Column(
              children: [
                // post message
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 8,
                    right: 8,
                    bottom: 16,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkBlueColor,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextfieldLayout(
                          controller: textController,
                          hintText: "Write your post..",
                          obscureText: false,
                        ),
                      ),
                      IconButton(
                        onPressed: postMessage,
                        icon: Icon(Icons.send_rounded),
                      ),
                    ],
                  ),
                ),

                // logged in as
                Text(
                  "Logged in as: " + currentUser.email!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: CommunityScreen(),
  ));
}
