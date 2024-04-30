import 'package:flutter/material.dart';
import 'package:home_finder_app/PropertyDetailsPage.dart';
import 'package:home_finder_app/decor.dart';
import 'package:home_finder_app/designer.dart';
import 'package:home_finder_app/shifting.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants.dart';

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

  List<dynamic> properties = [];

  @override
  void initState() {
    super.initState();
    fetchProperties();
  }

  Future<List<dynamic>> fetchProperties() async {
    var dio = Dio();
    final response = await dio.get(
        '${Constants.server}/properties/getAll?page=1&limit=10&sortOrder=asc');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load products');
    }
  }

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
          FutureBuilder<List<dynamic>>(
            future:
                fetchProperties(), // Assuming you have a function that fetches the properties
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    height: 600,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpinKitFadingCircle(
                          color: Color(0xFF2563EB),
                          size: 50.0,
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var properties = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: properties?.length,
                    itemBuilder: (context, index) {
                      var propertyMap =
                          properties != null && properties.length > index
                              ? properties[index]
                              : {};
                      Map<String, dynamic> propertyInfo =
                          jsonDecode(propertyMap['PropertyInfo']);
                      int bed = propertyInfo['Bed'];
                      int bath = propertyInfo['Bathroom'];
                      int area = propertyInfo['Area'];
                      print('propertyMap: $propertyMap');
                      String imagesString = propertyMap['Images'] ?? '';
                      List<dynamic> imagesList = imagesString.isNotEmpty
                          ? jsonDecode(imagesString)
                          : [];
                      print("imagesList: $imagesList");
                      var property = Property(
                          Name: propertyMap['Name'] ?? '',
                          imageURL: imagesList.isNotEmpty
                              ? imagesList[0]
                              : 'https://i.ibb.co/VWzpdMG/home-design-1.jpg',
                          bedroom: bed,
                          bathroom: bath,
                          livingArea: area,
                          Description: propertyMap['Description'] ?? '',
                          address: propertyMap['Location'] ?? '',
                          rating: propertyMap['Reviews'] ?? '',
                          rentFee: (propertyMap['RentFee'] ??
                                  '4.3 rating (50 reviews)')
                              .toString());
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
                                    elevation:
                                        0.0, // This line removes the shadow
                                    child: Column(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Container(
                                            height: 300,
                                            width: double.infinity,
                                            child: Image.network(
                                              imagesList.isNotEmpty
                                                  ? imagesList[0]
                                                  : 'https://i.ibb.co/VWzpdMG/home-design-1.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            propertyMap['Name'] ?? '',
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
                                                Text(bed.toString()),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Bathroom'),
                                                Text(bath.toString()),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('Living Area'),
                                                Text(area.toString()),
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
                                    builder: (BuildContext context,
                                        StateSetter setState) {
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
                );
              }
            },
          ),
        ],
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DesignerPage()),
              );
              break;
          }
        },
      ),
    );
  }
}
