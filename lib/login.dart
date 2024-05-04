import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_finder_app/constants.dart';
import 'package:home_finder_app/decor.dart';
import 'package:home_finder_app/designer.dart';
import 'package:home_finder_app/home.dart';
import 'package:home_finder_app/register.dart';
import 'package:home_finder_app/shifting.dart';
import 'package:provider/provider.dart';
import 'package:home_finder_app/UserProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '';

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    updateCurrentUser();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  void updateCurrentUser() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final User? currentUser = _auth.currentUser;
      Provider.of<UserProvider>(context, listen: false).user = currentUser;
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    await _googleSignIn.signOut(); // Add this line

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print('userCredential.user ${userCredential.user}');

      try {
        var dio = Dio();
        await dio.post(
          '${Constants.server}/users/create', // Replace with your database URL
          data: {
            'name': userCredential.user!.displayName ?? 'No Name',
            'email': userCredential.user!.email,
            'photoURL': userCredential.user!.photoURL ?? 'No Photo',
            'uid': userCredential.user!.uid,
          },
        );
      } catch (e) {
        print('Failed to make POST request: $e');
      }

      if (userCredential.user != null) {
        Fluttertoast.showToast(
            msg: "Continued with ${userCredential.user!.email}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 12.0);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }

      return userCredential;
    }
    return null;
  }

  Future<UserCredential?> _signInWithEmailPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user == null) {
                return Text('Login');
              } else {
                return Text('Profile');
              }
            } else {
              // Show a loading spinner while waiting for the auth state to change
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            Provider.of<UserProvider>(context, listen: false).user =
                snapshot.data; // Add this line

            // User is signed in, show logout button
            return ListView(
              padding: EdgeInsets.only(left: 16, right: 16),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                      'Hi ${toBeginningOfSentenceCase(snapshot.data!.displayName)}',
                      style: TextStyle(fontSize: 24, color: Colors.blueAccent)),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Personal Info'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Rent management'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('My Properties'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favorites'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Privacy'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Payments & payouts'),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Login & Security'),
                  ),
                ),
                const Divider(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // background color
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                    Provider.of<UserProvider>(context, listen: false).user =
                        null;
                  },
                  child: Text('Logout', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          } else {
            Provider.of<UserProvider>(context, listen: false).user = null;

            return Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter email' : null,
                              onSaved: (value) => _email = value!,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter password'
                                  : null,
                              onSaved: (value) => _password = value!,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: 'Don\'t have an account? '),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 10),
                        child: Container(
                          height: 40.0,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              UserCredential? user =
                                  await _signInWithEmailPassword();
                              if (user != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 10),
                        child: Container(
                          height: 40.0,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset('assets/images/google.png',
                                    height: 20.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Continue with Google',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              try {
                                UserCredential? user =
                                    await _signInWithGoogle();
                                print("userinfo ${user}");
                              } catch (e) {
                                print("Error signing in with Google: $e");
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
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
