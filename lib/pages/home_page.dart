import 'package:flutter/material.dart';
import 'package:projetopdi/pages/Progresso_page.dart';
import 'package:projetopdi/pages/agenda_page.dart';
import 'package:projetopdi/pages/news_page.dart';
import 'package:projetopdi/pages/notifications_page.dart';
import 'package:projetopdi/pages/social_page.dart';
// Include other pages here...

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _pages = <Widget>[
    NewsPage(),
    ProgressoPage(),
    NotificationsPage(),
    SocialPage(),
    AgendaApp()
    // Add other pages here...
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orange,
        items: <BottomNavigationBarItem>[
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
