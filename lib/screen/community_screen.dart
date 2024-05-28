import 'package:flutter/material.dart';
import 'package:wander_wise/posts/post_model.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Post> _posts = [];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  void _addPost() {
    if (_usernameController.text.isEmpty || _experienceController.text.isEmpty) {
      return;
    }
    setState(() {
      _posts.add(
        Post(
          username: _usernameController.text,
          experience: _experienceController.text,
        ),
      );
      _usernameController.clear();
      _experienceController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_posts[index].username),
                  subtitle: Text(_posts[index].experience),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _experienceController,
                  decoration: InputDecoration(labelText: 'Experience'),
                  maxLines: 3,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addPost,
                  child: Text('Share Experience'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _experienceController.dispose();
    super.dispose();
  }
}
