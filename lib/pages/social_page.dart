import 'package:flutter/material.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social'),
      ),
      body: Center(
        child: Text('Social Page'),
      ),
    );
  }
}
