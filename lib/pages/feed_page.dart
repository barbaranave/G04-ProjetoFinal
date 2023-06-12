import 'package:flutter/material.dart';
import 'package:projetopdi/services/create_tweet.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the ComposeTweetPage here.
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons
                .account_circle), // Replace this with actual profile picture
            title: Text('User 1'), // Replace this with actual user name
            subtitle: Text('This is a dummy tweet from user 1.'),
          ),
          ListTile(
            leading: Icon(Icons
                .account_circle), // Replace this with actual profile picture
            title: Text('User 2'), // Replace this with actual user name
            subtitle: Text('This is a dummy tweet from user 2.'),
          ),
        ],
      ),
    );
  }
}
