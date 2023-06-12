import 'package:flutter/material.dart';

class ProgressoPage extends StatelessWidget {
  const ProgressoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progresso'),
      ),
      body: Center(
        child: Text('Progresso Page'),
      ),
    );
  }
}
