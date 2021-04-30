import 'package:admin_multivendor_app/screens/AdminScreen.dart';
import 'package:admin_multivendor_app/screens/BannerScreen.dart';
import 'package:admin_multivendor_app/screens/CategoriesScreen.dart';
import 'package:admin_multivendor_app/screens/DeliveryScreen.dart';
import 'package:admin_multivendor_app/screens/ExitScreen.dart';
import 'package:admin_multivendor_app/screens/HomeScreen.dart';
import 'package:admin_multivendor_app/screens/NotificationScreen.dart';
import 'package:admin_multivendor_app/screens/OrderScreen.dart';
import 'package:admin_multivendor_app/screens/SettingScreen.dart';
import 'package:admin_multivendor_app/screens/VendorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MySideBar {
  sideBarMenus(BuildContext context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: HomeScreen.id,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: Icons.image_search_rounded,
        ),
        MenuItem(
          title: 'Categories',
          route: CategoriesScreen.id,
          icon: Icons.category_rounded,
        ),
        MenuItem(
          title: 'Admin users',
          route: AdminScreen.id,
          icon: Icons.supervised_user_circle_rounded,
        ),
        MenuItem(
          title: 'Vendor users',
          route: VendorScreen.id,
          icon: Icons.storefront_rounded,
        ),
        MenuItem(
          title: 'Delivery users',
          route: DeliveryScreen.id,
          icon: Icons.motorcycle_outlined,
        ),
        MenuItem(
          title: 'Orders',
          route: OrderScreen.id,
          icon: Icons.shopping_basket_rounded,
        ),
        MenuItem(
          title: 'Send Notification',
          route: NotificationScreen.id,
          icon: Icons.notifications,
        ),
        MenuItem(
          title: 'Settings',
          route: SettingScreen.id,
          icon: Icons.settings,
        ),
        MenuItem(
          title: 'Exit',
          route: ExitScreen.id,
          icon: Icons.exit_to_app,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        Navigator.of(context).pushNamed(item.route);
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Text(
            'MENU',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.business, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'ALTIYOL',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
