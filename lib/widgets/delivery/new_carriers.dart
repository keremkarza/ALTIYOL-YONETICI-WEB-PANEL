import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NewCarriers extends StatefulWidget {
  @override
  _NewCarriersState createState() => _NewCarriersState();
}

class _NewCarriersState extends State<NewCarriers> {
  bool status = false;
  FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream:
            _services.boys.where('accVerified', isEqualTo: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong..');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          QuerySnapshot snap = snapshot.data;
          if (snap.size == 0) {
            return Center(
              child: Text('No new delivery boys to display'),
            );
          }
          return SingleChildScrollView(
            child: FittedBox(
              child: DataTable(
                showBottomBorder: true,
                dataRowHeight: 70,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: <DataColumn>[
                  DataColumn(label: Text('Profile Picture')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Mobile')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Address')),
                  DataColumn(label: Text('Action')),
                  //DataColumn(label: Text('Actions')),
                ],
                rows: _carriersList(snapshot.data, context),
              ),
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _carriersList(QuerySnapshot snapshot, context) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      if (document != null) {
        return DataRow(cells: [
          DataCell(
            document['url'] != ''
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      document['url'],
                      fit: BoxFit.cover,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        //Icon(Icons.motorcycle),
                        Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/multivendor-app-9b552.appspot.com/o/assets%2FALTIYOL_LOGO.png?alt=media&token=579e324c-d996-43be-8264-157b2ea04c2f',
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          DataCell(Text(document['name'])),
          DataCell(Text(document['mobile'])),
          DataCell(Text(document['email'])),
          DataCell(Text(
            document['address'],
            style: TextStyle(),
            overflow: TextOverflow.ellipsis,
          )),
          DataCell(
            document['mobile'] == ''
                ? Text('No Registered')
                : FlutterSwitch(
                    activeText: "Onaylandı",
                    inactiveText: "Onaylanmadı",
                    value: document['accVerified'],
                    valueFontSize: 10.0,
                    width: 110,
                    borderRadius: 30.0,
                    showOnOff: true,
                    onToggle: (val) {
                      _services.updateCarrierStatus(
                          id: document.id,
                          context: context,
                          accVerified: document['accVerified']);
                    },
                  ),
          ),
        ]);
      }
    }).toList();
    return newList;
  }

  Widget popUpButton(data, {BuildContext context}) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        if (value == 'unpublish') {
          //_services.unPublishProduct(id: data['productId']);
        }
        if (value == 'preview') {}
        // if (value == 'edit') {}
        // if (value == 'delete') {
        //   _services.deleteProduct(id: data['productId']);
        // }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          child: ListTile(
            leading: Icon(Icons.check),
            title: Text('Unpublish'),
          ),
          value: 'unpublish',
        ),
        const PopupMenuItem<String>(
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Preview'),
          ),
          value: 'preview',
        ),
        const PopupMenuItem<String>(
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit'),
          ),
          value: 'edit',
        ),
        const PopupMenuItem<String>(
          child: ListTile(
            leading: Icon(Icons.delete_outlined),
            title: Text('Delete'),
          ),
          value: 'delete',
        ),
      ],
    );
  }
}
