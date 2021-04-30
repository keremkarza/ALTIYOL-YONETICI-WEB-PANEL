import 'package:admin_multivendor_app/widgets/MySideBar.dart';
import 'package:admin_multivendor_app/widgets/banner/MyBanner.dart';
import 'package:admin_multivendor_app/widgets/banner/MyBannerUploadWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class BannerScreen extends StatelessWidget {
  static const String id = 'banner-screen';

  @override
  Widget build(BuildContext context) {
    MySideBar _sideBar = MySideBar();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('ALTIYOL GENEL YÖNETİM PANELİ'),
      ),
      sideBar: _sideBar.sideBarMenus(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Banners Page',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add / Delete Home Screen Banner Images'),
              Divider(thickness: 5),
              MyBanner(),
              Divider(thickness: 5),
              MyUploadWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
