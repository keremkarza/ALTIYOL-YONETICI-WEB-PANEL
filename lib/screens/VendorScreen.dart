import 'package:admin_multivendor_app/widgets/MySideBar.dart';
import 'package:admin_multivendor_app/widgets/vendor/MyVendorDataTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class VendorScreen extends StatefulWidget {
  static const String id = 'vendor-screen';
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  MySideBar _sideBar = MySideBar();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('ALTIYOL GENEL YÖNETİM PANELİ'),
      ),
      sideBar: _sideBar.sideBarMenus(context, VendorScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Vendors Page',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
              ),
              Text('Manage all the Vendors Activities'),
              Divider(thickness: 5),
              MyVendorDataTable(),
              Divider(thickness: 5),
            ],
          ),
        ),
      ),
    );
  }
}
