import 'package:admin_multivendor_app/widgets/MySideBar.dart';
import 'package:admin_multivendor_app/widgets/delivery/approved_carriers.dart';
import 'package:admin_multivendor_app/widgets/delivery/create_delivery_carrier.dart';
import 'package:admin_multivendor_app/widgets/delivery/new_carriers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class DeliveryScreen extends StatelessWidget {
  static const String id = 'delivery-screen';

  @override
  Widget build(BuildContext context) {
    MySideBar _sideBar = MySideBar();

    return DefaultTabController(
      length: 2,
      child: AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text('ALTIYOL GENEL YÖNETİM PANELİ'),
        ),
        sideBar: _sideBar.sideBarMenus(context, DeliveryScreen.id),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KURYELER SAYFASI',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                Text('Tüm kuryeleri yönet'),
                Divider(thickness: 5),
                CreateNewCarrier(),
                Divider(thickness: 5),
                //list of delivery boys
                TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(
                      child: Text('YENİ'),
                    ),
                    Tab(
                      child: Text('ONAYLANDI'),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: [
                        NewCarriers(),
                        ApprovedCarriers(),
                        //PublishedProduct(),
                        //UnpublishedProduct(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
