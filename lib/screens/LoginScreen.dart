import 'dart:async';

import 'package:admin_multivendor_app/screens/HomeScreen.dart';
import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';
  LoginScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseServices _services = FirebaseServices();
  String username;
  String password;
  @override
  Widget build(BuildContext context) {
    Future<void> _login() async {
      _services.getAdminCredentials().then((value) {
        value.docs.forEach((doc) async {
          print(doc == null ? 'document error' : 'doc is ' + doc.toString());
          Timer(Duration(seconds: 2), () async {
            if (mounted) {
              try {
                if (await doc.get('username') == username) {
                  print(username == null ? 'username error' : username);
                  if (await doc.get('password') == password) {
                    print(password == null ? 'password error' : password);
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: "admin@gmail.com", password: "Admin@123");
                    if (userCredential.user.uid != null) {
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                      return;
                    } else {
                      _services.showMyDialog(
                          title: 'Login Error',
                          message: 'Your attempt to logging in  failed.',
                          context: context);
                      return;
                    }
                  }
                }
              } on FirebaseAuthException catch (e) {
                //buraya şuan bu hatalar düşmüyor, istenilirse yukarıya else ler koyulsun.
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
              return;
            }
          });
        });
      });
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'GENEL YÖNETİM PANELİ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Center(
                child: Text('Connection Failed'),
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF008744),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment(0.0, 0.0),
                    stops: [1, 1],
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 350,
                    height: 350,
                    child: Card(
                      elevation: 6,
                      shape: Border.all(
                        color: Theme.of(context).secondaryHeaderColor,
                        width: 2,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child:
                                            Image.asset('images/security.png'),
                                      ),
                                      Text(
                                        'YÖNETİM PANELİ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter Username';
                                            }
                                            setState(() {
                                              username = value;
                                            });
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.person),
                                            hintText: 'User Name',
                                            labelText: 'User Name',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 1.5),
                                            ),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                  width: 1.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter Password';
                                            }
                                            if (value.length < 6) {
                                              return 'Minimum 6 characters';
                                            }
                                            setState(() {
                                              password = value;
                                            });
                                            return null;
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.vpn_key_sharp),
                                            labelText: 'Password',
                                            hintText: 'Password',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: 1.5),
                                            ),
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .secondaryHeaderColor,
                                                  width: 1.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                          style: ButtonStyle(),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _login();
                                            }
                                          },
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
