import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle, size: 30.0),
          onPressed: () {
            // Add your onPressed code here!
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, size: 30.0),
            onPressed: () {
              // Add your onPressed code here!
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to Home Page!'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: 'Shifting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_paint),
            label: 'Decor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Interior',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
