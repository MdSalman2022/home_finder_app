import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_finder_app/decor.dart';
import 'package:home_finder_app/designer.dart';
import 'package:home_finder_app/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:home_finder_app/login.dart';
import 'constants.dart';

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
  String? name, phone, email, dayOfShifting, fromLocation, toLocation;
  void submitForm() async {
    print("Submitting");
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      try {
        final response = await Dio().post(
          '${Constants.server}/shiftings/create',
          data: {
            'name': name,
            'phone': phone,
            'email': email,
            'dayOfShifting': dayOfShifting,
            'from_location': fromLocation,
            'to_location': toLocation,
            'submittedBy': '1',
          },
        );

        print("myresponse: ${response}");

        if (response.statusCode == 200) {
          print("Form submitted successfully");
          Fluttertoast.showToast(
            msg: "Form submitted successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          form.reset();
          FocusScope.of(context).unfocus();
        } else {
          print("Form failed to submit");
          Fluttertoast.showToast(
            msg: "Failed to submit form",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        print("Failed to submit form: $e");
        Fluttertoast.showToast(
          msg: "Failed to submit form",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

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
                      onSaved: (value) => name = value,

                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Your Phone',
                      ),
                      onSaved: (value) => phone = value,

                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Your Email',
                      ),
                      onSaved: (value) => email = value,

                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Day of shifting',
                      ),
                      onSaved: (value) => dayOfShifting = value,
                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'From location',
                      ),
                      onSaved: (value) => fromLocation = value,
                      // Add validation logic here
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'To location',
                      ),
                      onSaved: (value) => toLocation = value,
                      // Add validation logic here
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitForm,
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
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listings',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows),
            label: 'Shifting',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.format_paint),
            label: 'Decor',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people),
            label: 'Interior',
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User? user = snapshot.data;
                  if (user != null && user.photoURL != null) {
                    return CircleAvatar(
                      radius:
                          15, // Adjust this value to change the size of the CircleAvatar
                      backgroundImage: NetworkImage(user.photoURL!),
                    );
                  } else {
                    return Icon(Icons.account_circle);
                  }
                } else {
                  // Show a loading spinner while waiting for the auth state to change
                  return CircularProgressIndicator();
                }
              },
            ),
          )
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
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
              break;
          }
        },
      ),
    );
  }
}
