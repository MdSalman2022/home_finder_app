import 'package:flutter/material.dart';

class MyLayout extends StatelessWidget {
  final Widget child;
  int _currentIndex = 0;

  MyLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      drawer: Drawer(
          // Populate your Drawer here
          ),
      body: this.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          // Add more items here for more tabs
        ],
        onTap: (index) {
          _currentIndex = index;
          // Handle tab change here
        },
      ),
    );
  }
}
