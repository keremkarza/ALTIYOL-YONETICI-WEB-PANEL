import 'package:admin_multivendor_app/widgets/MySideBar.dart';
import 'package:admin_multivendor_app/widgets/order/NewOrderDataTable.dart';
import 'package:admin_multivendor_app/widgets/order/PassiveOrderDataTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class OrderScreen extends StatefulWidget {
  static const String id = 'order-screen';
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  MySideBar _sideBar = MySideBar();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('ALTIYOL GENEL YÖNETİM PANELİ'),
      ),
      sideBar: _sideBar.sideBarMenus(context, OrderScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Siparişler Sayfası',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36),
              ),
              Text('Tüm Siparişleri Yönet'),
              Divider(thickness: 5),
              Row(
                children: [
                  Container(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Aktif Siparişleriniz',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              NewOrderDataTable(),
              Divider(thickness: 5),
              Row(
                children: [
                  Container(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Pasif Siparişleriniz',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              PassiveOrderDataTable(),
              Divider(thickness: 5),
            ],
          ),
        ),
      ),
    );
  }
}
