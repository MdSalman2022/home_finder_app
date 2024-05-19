import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_finder_app/decor.dart';
import 'package:home_finder_app/home.dart';
import 'package:home_finder_app/login.dart';
import 'package:home_finder_app/shifting.dart';

class DesignerPage extends StatefulWidget {
  @override
  _DesignerPageState createState() => _DesignerPageState();
}

class _DesignerPageState extends State<DesignerPage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, String>> designers = [
    {
      'name': "Aminul Islam",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Rahim Mia",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Karim Uddin",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Salam Khan",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Rahim Mia",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Karim Uddin",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Salam Khan",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Rahim Mia",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Karim Uddin",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
    {
      'name': "Salam Khan",
      'img': 'assets/images/avatar.jpeg',
      'phone': "019421421412"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(32.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5.0,
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find your local designer...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: designers.length,
                itemBuilder: (context, index) {
                  var designer = designers[index];
                  return Column(
                    children: [
                      Card(
                        elevation: 5.0,
                        child: Row(
                          children: [
                            Image.asset(
                              designer['img'] ?? 'default_image_path',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    designer['name'] ?? 'default_name',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    designer['phone'] ?? 'default_phone',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10), // Add this line
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
