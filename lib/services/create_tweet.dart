// Inside services/create_tweet.dart
import 'package:flutter/material.dart';

class Tweet {
  final String content;

  Tweet({required this.content});

  Future<void> post() async {
    // Simulate a service call with a delay
    await Future.delayed(Duration(seconds: 1));
  }
}

class ComposeTweetPage extends StatefulWidget {
  ComposeTweetPage({Key? key}) : super(key: key);

  @override
  _ComposeTweetPageState createState() => _ComposeTweetPageState();
}

class _ComposeTweetPageState extends State<ComposeTweetPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose a Tweet'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "What's happening?",
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Tweet'),
            onPressed: () {
              final tweet = Tweet(content: _controller.text);
              tweet.post().then((_) {
                // Return to the previous screen with the tweet
                Navigator.of(context).pop(tweet);
              });
            },
          )
        ],
      ),
    );
  }
}
