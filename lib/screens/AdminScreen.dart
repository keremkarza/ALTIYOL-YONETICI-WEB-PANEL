import 'package:admin_multivendor_app/widgets/MySideBar.dart';
import 'package:admin_multivendor_app/widgets/admin/MyAdminDataTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class AdminScreen extends StatelessWidget {
  static const String id = 'admin-screen';

  @override
  Widget build(BuildContext context) {
    MySideBar _sideBar = MySideBar();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('ALTIYOL GENEL YÖNETİM PANELİ'),
      ),
      sideBar: _sideBar.sideBarMenus(context, AdminScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Adminler Sayfası',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
              ),
              Text('Tüm Adminleri ve aktivitelerini yönet'),
              Divider(thickness: 5),
              MyAdminDataTable(),
              Divider(thickness: 5),
            ],
          ),
        ),
      ),
    );
  }
}
