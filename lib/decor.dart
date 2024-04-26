import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_finder_app/designer.dart';
import 'package:home_finder_app/home.dart';
import 'package:home_finder_app/shifting.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DecorPage extends StatefulWidget {
  @override
  _DecorPageState createState() => _DecorPageState();
}

class _DecorPageState extends State<DecorPage> {
  final List<Map<String, String>> categories = [
    {
      'name': "Wall Art",
      'img': 'assets/images/categories/wallart.jpg',
      'bg': '#E9FCF6',
      'text': "#119C75",
    },
    {
      'name': "Home Accents",
      'img': 'assets/images/categories/accents.jpg',
      'bg': '#FFF2F9',
      'text': "#FF43A2",
    },
    {
      'name': "Rugs",
      'img': 'assets/images/categories/rugs.jpg',
      'bg': '#F7F0FE',
      'text': "#802FDE",
    },
    {
      'name': "Faux Plants",
      'img': 'assets/images/categories/plants.jpg',
      'bg': '#F2F7FF',
      'text': "#0067FB",
    },
    {
      'name': "Mirrors",
      'img': 'assets/images/categories/mirrors.jpg',
      'bg': '#FEF9E6',
      'text': "#DAAB00",
    },
    {
      'name': "Curtains",
      'img': 'assets/images/categories/curtains.jpg',
      'bg': '#E5F5FA',
      'text': "#3A506B",
    },
    {
      'name': "Pillows",
      'img': 'assets/images/categories/pillows.jpg',
      'bg': '#FFE7D9',
      'text': "#6F5151",
    },
    {
      'name': "Floating Shelves",
      'img': 'assets/images/categories/shelves.jpg',
      'bg': '#D8E3E7',
      'text': "#4F7178",
    },
    {
      'name': "Vases",
      'img': 'assets/images/categories/vases.jpg',
      'bg': '#F0F3F9',
      'text': "#475A77",
    },
    {
      'name': "Lighting",
      'img': 'assets/images/categories/lighting.jpg',
      'bg': '#DDEBF5',
      'text': "#3E6379",
    },
    {
      'name': "Planters",
      'img': 'assets/images/categories/planters.jpg',
      'bg': '#F7E6E2',
      'text': "#9A694E",
    },
    {
      'name': "Throws",
      'img': 'assets/images/categories/throws.jpg',
      'bg': '#EAE8E1',
      'text': "#7C7B6D",
    },
    {
      'name': "Baskets & Bins",
      'img': 'assets/images/categories/baskets.jpg',
      'bg': '#E9F3F0',
      'text': "#4E6A69",
    },
    {
      'name': "Candles",
      'img': 'assets/images/categories/candles.jpg',
      'bg': '#FFE4F1',
      'text': "#955272",
    },
    {
      'name': "Wallpaper",
      'img': 'assets/images/categories/wallpaper.jpg',
      'bg': '#F9EFE9',
      'text': "#8F7A6D",
    },
    {
      'name': "Handmade Decor",
      'img': 'assets/images/categories/handmade.jpg',
      'bg': '#F3E9F4',
      'text': "#7A6D80",
    },
  ];

  List<dynamic> products = [];

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    var dio = Dio();
    // print('Fetching products');
    final response = await dio.get('http://10.0.2.2:3000/products/getProducts');

    if (response.statusCode == 200) {
      setState(() {
        products = response.data;
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center, // Center the non-positioned children
              children: [
                Container(
                  height: 560, // Set the height of the image
                  child: Image.asset('assets/images/heroImage.jpg',
                      fit: BoxFit.cover),
                ),
                Container(
                  color: Colors.black.withOpacity(
                      0.5), // Add a black background with 50% opacity
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the children vertically
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Center the children horizontally
                      children: [
                        Text(
                          "It's More Than Decor, IT'S A LIFESTYLE",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left, // Center align the text
                        ),
                        Text(
                          "Turning Spaces Into your lifestyle canvas",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.left, // Center align the text
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Shop top categories in decor",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10, // Add horizontal spacing
                  mainAxisSpacing: 10, // Add vertical spacing
                  children: categories.map((category) {
                    return Card(
                      color: category['bg'] != null
                          ? Color(
                              int.parse('0xFF' + category['bg']!.substring(1)))
                          : Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the children vertically
                        children: [
                          Container(
                            height: 100,
                            child: Image.asset(
                              category['img'] ?? 'assets/images/default.jpg',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top:
                                    8.0), // Add a gap between the image and the text
                            child: Center(
                              child: Text(
                                category['name'] ?? 'Default title',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: category['bg'] != null
                                      ? Color(int.parse('0xFF' +
                                          category['text']!.substring(1)))
                                      : Colors.grey[200],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Expanded(
            //             child: TextField(
            //               decoration: InputDecoration(
            //                 hintText: 'Search...',
            //               ),
            //               // Add your search logic here
            //             ),
            //           ),
            //           SizedBox(
            //               width:
            //                   10), // Add a gap between the TextField and the Button
            //           ElevatedButton(
            //             child: Text('Search'),
            //             onPressed: () {
            //               // Add your search button logic here
            //             },
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //           height:
            //               10), // Add a gap between the search bar and the GridView
            //       GridView.count(
            //         shrinkWrap: true,
            //         physics: NeverScrollableScrollPhysics(),
            //         crossAxisCount: 2,
            //         crossAxisSpacing: 10, // Add horizontal spacing
            //         // ... rest of your code ...
            //       ),
            //     ],
            //   ),
            // ),
            Text(
              "Latest products in store",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10, // Add horizontal spacing
                mainAxisSpacing: 10, // Add vertical spacing
                children: products.map((product) {
                  return Card(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.favorite_border), // Love icon
                            onPressed: () {
                              // Handle the press event
                            },
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                child: Image.network(
                                  product['img'] ?? 'assets/images/default.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top:
                                        2.0), // Add a gap between the image and the text
                                child: Text(
                                  product['name'], // Price
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),

                                  textAlign:
                                      TextAlign.center, // Center align the text
                                ),
                              ),
                              Container(
                                child: Text(
                                  '৳${product['price']}', // Price
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
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
