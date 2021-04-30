import 'package:admin_multivendor_app/widgets/MySideBar.dart';
import 'package:admin_multivendor_app/widgets/category/MyCategoryCreateWidget.dart';
import 'package:admin_multivendor_app/widgets/category/MyCategoryListWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class CategoriesScreen extends StatelessWidget {
  static const String id = 'categories-screen';

  @override
  Widget build(BuildContext context) {
    MySideBar _sideBar = MySideBar();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('ALTIYOL GENEL YÖNETİM PANELİ'),
      ),
      sideBar: _sideBar.sideBarMenus(context, CategoriesScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Categories Page',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add New Categories and Sub Categories'),
              Divider(thickness: 5),
              MyCategoryCreateWidget(),
              Divider(thickness: 5),
              MyCategoryListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
