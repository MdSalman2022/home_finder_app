import 'package:flutter/material.dart';
import 'package:home_finder_app/decor.dart';
import 'package:home_finder_app/home.dart';

class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.check, color: Colors.white),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class ShiftingPage extends StatefulWidget {
  @override
  _ShiftingPageState createState() => _ShiftingPageState();
}

class _ShiftingPageState extends State<ShiftingPage> {
  final _formKey = GlobalKey<FormState>();

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  // The image
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.darken,
                    ),
                    child: Image.asset(
                      'assets/images/homeshifting.jpg',
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // The text
                  Center(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'House Shifting Service',
                            style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BulletPoint(
                                    'Trusted, Background Checked & Skilled Movers'),
                                BulletPoint(
                                    'Superior Packaging, Loading-unloading & Quality Moving Services'),
                                BulletPoint(
                                    "Bangladesh's Highest-rated & Premium Shifting Service"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Contact us to ease your shifting process',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Please do not hesitate to reach out to us for a seamless transition during your relocation. To initiate the process, kindly complete the following form.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Your Name',
                      ),
                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Your Phone',
                      ),
                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Your Email',
                      ),
                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Day of shifting',
                      ),
                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'From location',
                      ),
                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'To location',
                      ),
                      // Add validation logic here
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add submit logic here
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16, // Adjust as needed
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF3C91E6)),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12), // Adjust as needed
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(color: Colors.white.withOpacity(0.4)),
                        ),
                        overlayColor: MaterialStateProperty.all<Color>(
                            Color(0xFF3C91E6)), // Random color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              // Navigate to Shifting page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShiftingPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DecorPage()),
              );
              break;
            case 3:
              // Navigate to Interior page
              break;
          }
        },
      ),
    );
  }
}
