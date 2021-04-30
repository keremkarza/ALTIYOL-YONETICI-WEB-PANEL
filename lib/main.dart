import 'package:admin_multivendor_app/screens/AdminScreen.dart';
import 'package:admin_multivendor_app/screens/BannerScreen.dart';
import 'package:admin_multivendor_app/screens/CategoriesScreen.dart';
import 'package:admin_multivendor_app/screens/DeliveryScreen.dart';
import 'package:admin_multivendor_app/screens/ExitScreen.dart';
import 'package:admin_multivendor_app/screens/HomeScreen.dart';
import 'package:admin_multivendor_app/screens/LoginScreen.dart';
import 'package:admin_multivendor_app/screens/NotificationScreen.dart';
import 'package:admin_multivendor_app/screens/OrderScreen.dart';
import 'package:admin_multivendor_app/screens/SettingScreen.dart';
import 'package:admin_multivendor_app/screens/SplashScreen.dart';
import 'package:admin_multivendor_app/screens/VendorScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multivendor Admin',
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Color(0xFF008744),
            padding: EdgeInsets.all(0),
          ),
        ),
        primaryColor: Color(0xFF008744),
        secondaryHeaderColor: Colors.green[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        AdminScreen.id: (context) => AdminScreen(),
        BannerScreen.id: (context) => BannerScreen(),
        ExitScreen.id: (context) => ExitScreen(),
        OrderScreen.id: (context) => OrderScreen(),
        SettingScreen.id: (context) => SettingScreen(),
        NotificationScreen.id: (context) => NotificationScreen(),
        CategoriesScreen.id: (context) => CategoriesScreen(),
        VendorScreen.id: (context) => VendorScreen(),
        DeliveryScreen.id: (context) => DeliveryScreen(),
      },
    );
  }
}
