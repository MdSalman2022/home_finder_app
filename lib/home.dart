import 'package:flutter/material.dart';
import 'package:home_finder_app/PropertyDetailsPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  // Future<List<Map<String, dynamic>>> fetchProperties() async {
  //   final response = await http
  //       .get(Uri.parse('http://localhost:3000/properties/getAll?limit=10'));

  //   if (response.statusCode == 200) {
  //     // If the server returns a 200 OK response, parse the JSON.
  //     return jsonDecode(response.body);
  //   } else {
  //     // If the server returns an unsuccessful response code, throw an exception.
  //     throw Exception('Failed to load properties');
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchProperties().then((properties) {
  //     setState(() {
  //       this.properties = properties;
  //     });
  //   });
  // }

  List<Map<String, dynamic>> properties = [
    {
      'imageURL': 'assets/images/bedroom.webp',
      'Name':
          'A Very Well-fitted Apartment Is Here Sited At Bashundhara R-A Featuring 2080 Sq Ft Space',
      'bedroom': 3,
      'bathroom': 2,
      'livingArea': 1000,
      'Description':
          "A Budget-Friendly beautiful apartment is available to sale. Located in Bashundhara R-A, this modern apartment is 2080  Square Feet. This ready apartment has cozy 4 beds and modern and well fitted ...Read more",
      'address': 'Bashundhora R-A',
      'rating': '4.2 rating (1752 reviews)',
      'rentFee': '10000'
    },
    {
      'imageURL': 'assets/images/masterbed.webp',
      'Name':
          'A Newly Constructed 3 Bedroom Flat Is Available For Sale In Bashundhara R-A',
      'bedroom': 4,
      'bathroom': 3,
      'livingArea': 2000,
      'Description':
          "A Budget-Friendly beautiful apartment is available to sale. Located in Bashundhara R-A, this modern apartment is 2080  Square Feet. This ready apartment has cozy 4 beds and modern and well fitted ...Read more",
      'address': 'Bashundhora R-A',
      'rating': '4.8 rating (1156 reviews)',
      'rentFee': '15000'
    },
    {
      'imageURL': 'assets/images/drawingroom.webp',
      'Name': 'A 3 Bedroom Flat Is Available For Sale In Bashundhara R-A',
      'bedroom': 5,
      'bathroom': 5,
      'livingArea': 2500,
      'Description':
          "A Budget-Friendly beautiful apartment is available to sale. Located in Bashundhara R-A, this modern apartment is 2080  Square Feet. This ready apartment has cozy 4 beds and modern and well fitted ...Read more",
      'address': 'Bashundhora R-A',
      'rating': '4.9 rating (100 reviews)',
      'rentFee': '20000'
    },
    {
      'imageURL': 'assets/images/diningroom.webp',
      'Name': 'A 3 Bedroom Flat Is Available For Sale In Bashundhara R-A',
      'bedroom': 2,
      'bathroom': 1,
      'livingArea': 2000,
      'Description':
          "A Budget-Friendly beautiful apartment is available to sale. Located in Bashundhara R-A, this modern apartment is 2080  Square Feet. This ready apartment has cozy 4 beds and modern and well fitted ...Read more",
      'address': 'Bashundhora R-A',
      'rating': '4.5 rating (100 reviews)',
      'rentFee': '22000'
    },
    {
      'imageURL': 'assets/images/livingroom.webp',
      'Name': 'Awesome 3 Bedroom Flat Is Available For Sale In Bashundhara R-A',
      'bedroom': 4,
      'bathroom': 3,
      'livingArea': 2000,
      'Description':
          "A Budget-Friendly beautiful apartment is available to sale. Located in Bashundhara R-A, this modern apartment is 2080  Square Feet. This ready apartment has cozy 4 beds and modern and well fitted ...Read more",
      'address': 'Bashundhora R-A',
      'rating': '4.3 rating (50 reviews)',
      'rentFee': '12000'
    },
  ];

  List<bool> isSelected = [true, false, false]; // Initial selection
  bool isFavorited = false;

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F3F5),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF2F3F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Image.asset(
                      'assets/images/filter.png'), // Replace with your image path
                  onPressed: () {
                    // Handle filter button press
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: isSelected[0]
                          ? const Color(0xFF2563EB)
                          : Colors.transparent,
                      side: isSelected[0]
                          ? BorderSide.none
                          : const BorderSide(
                              color: Color(0xFFB9B9B9), width: 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Apartment',
                        style: TextStyle(
                          color:
                              isSelected[0] ? Colors.white : Color(0xFF818181),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isSelected = [true, false, false];
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: isSelected[1]
                          ? const Color(0xFF2563EB)
                          : Colors.transparent,
                      side: isSelected[1]
                          ? BorderSide.none
                          : const BorderSide(
                              color: Color(0xFFB9B9B9), width: 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Room',
                        style: TextStyle(
                          color:
                              isSelected[1] ? Colors.white : Color(0xFF818181),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isSelected = [false, true, false];
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: isSelected[2]
                          ? const Color(0xFF2563EB)
                          : Colors.transparent,
                      side: isSelected[2]
                          ? BorderSide.none
                          : const BorderSide(
                              color: Color(0xFFB9B9B9), width: 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Duplex',
                        style: TextStyle(
                          color:
                              isSelected[2] ? Colors.white : Color(0xFF818181),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isSelected = [false, false, true];
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: properties.length,
              itemBuilder: (context, index) {
                var propertyMap = properties[index];
                var property = Property(
                    Name: propertyMap['Name'],
                    imageURL: propertyMap['imageURL'],
                    bedroom: propertyMap['bedroom'],
                    bathroom: propertyMap['bathroom'],
                    livingArea: propertyMap['livingArea'],
                    Description: propertyMap['Description'],
                    address: propertyMap['address'],
                    rating: propertyMap['rating'],
                    rentFee: propertyMap['rentFee']);
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PropertyDetailsPage(property)),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              elevation: 0.0, // This line removes the shadow
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(propertyMap['imageURL']),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      propertyMap['Name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Bedroom'),
                                          Text(propertyMap['bedroom']
                                              .toString()),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Bathroom'),
                                          Text(propertyMap['bathroom']
                                              .toString()),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Living Area'),
                                          Text(propertyMap['livingArea']
                                              .toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Positioned(
                            top: 20.0,
                            right: 20.0,
                            child: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: Icon(
                                        isFavorited
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        isFavorited = !isFavorited;
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                );
              },
            ),
          ),
        ],
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
