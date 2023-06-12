import 'package:flutter/material.dart';
import 'package:projetopdi/table_calendar.dart';

class AgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Agenda'),
      ),
      body: Column(
        children: [
          // Your other widgets here
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(2023, 1, 1),
            lastDay: DateTime(2029, 12, 31),
          ), // Add the TableCalendar widget here
        ],
      ),
    );
  }
}
