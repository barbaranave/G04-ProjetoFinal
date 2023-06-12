import 'package:flutter/material.dart';
import 'package:projetopdi/pages/home_page.dart';
import 'package:projetopdi/pages/progresso_page.dart';
import 'package:projetopdi/pages/notifications_page.dart';
import 'package:projetopdi/pages/social_page.dart';
import 'package:projetopdi/pages/agenda_page.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ProgressoPage(),
    NotificationsPage(),
    SocialPage(),
    AgendaApp(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromRGBO(253, 250, 223, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Progresso',
            backgroundColor: Color.fromRGBO(253, 250, 223, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Color.fromRGBO(253, 250, 223, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Social',
            backgroundColor: Color.fromRGBO(253, 250, 223, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Agenda',
            backgroundColor: Color.fromRGBO(253, 250, 223, 1),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
