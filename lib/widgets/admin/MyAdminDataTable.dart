import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAdminDataTable extends StatefulWidget {
  @override
  _MyAdminDataTableState createState() => _MyAdminDataTableState();
}

class _MyAdminDataTableState extends State<MyAdminDataTable> {
  // int tag = 0;
  // List<String> options = [
  //   'All Vendors', //0
  //   'Active', //1
  //   'Inactive', //2
  //   'Top Picked', //3
  //   'Top Rated', //4
  // ];
  //
  // bool topPicked;
  // bool active;

  // filter(val) {
  //   if (val == 0) {
  //     setState(() {
  //       topPicked = null;
  //       active = null;
  //     });
  //   }
  //   if (val == 1) {
  //     setState(() {
  //       topPicked = null;
  //       active = true;
  //     });
  //   }
  //   if (val == 2) {
  //     setState(() {
  //       topPicked = null;
  //       active = false;
  //     });
  //   }
  //   if (val == 3) {
  //     setState(() {
  //       active = null;
  //       topPicked = true;
  //     });
  //   }
  //   if (val == 4) {
  //     setState(() {
  //       active = null;
  //       topPicked = null;
  //     });
  //   }
  // }

  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ChipsChoice<int>.single(
        //   value: tag,
        //   onChanged: (val) {
        //     setState(() {
        //       tag = val;
        //     });
        //     filter(val);
        //   },
        //   choiceItems: C2Choice.listFrom<int, String>(
        //     activeStyle: (i, v) {
        //       return C2ChoiceStyle(
        //         brightness: Brightness.dark,
        //         color: Colors.black54,
        //       );
        //     },
        //     source: options,
        //     value: (i, v) => i,
        //     label: (i, v) => v,
        //   ),
        // ),
        Divider(thickness: 5),
        StreamBuilder(
          stream: _services.admins.snapshots(),
          // .where('accVerified', isEqualTo: active)
          // .where('isTopPicked', isEqualTo: topPicked)
          // .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showBottomBorder: true,
                dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                //table headers
                columns: <DataColumn>[
                  // DataColumn(label: Text('Active/Inactive')),
                  // DataColumn(label: Text('Top Picked')),
                  // DataColumn(label: Text('Shop Name')),
                  // DataColumn(label: Text('Rating')),
                  // DataColumn(label: Text('Total Sales')),
                  DataColumn(label: Text('Kullanıcı Adı')),
                  DataColumn(label: Text('Şifre')),
                  //DataColumn(label: Text('View Details')),
                ],
                //details
                rows: _adminDetailsRows(snapshot.data, _services),
              ),
            );
          },
        ),
      ],
    );
  }

  List<DataRow> _adminDetailsRows(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      return DataRow(
        cells: [
          // DataCell(
          //   IconButton(
          //     onPressed: () {
          //       services.changeVendorStatus(
          //         query: 'accVerified',
          //         id: document.data()['uid'],
          //         status: document.data()['accVerified'],
          //       );
          //     },
          //     icon: document.data()['accVerified']
          //         ? Icon(
          //             Icons.check_circle,
          //             color: Colors.green,
          //           )
          //         : Icon(
          //             Icons.remove_circle,
          //             color: Colors.red,
          //           ),
          //   ),
          // ),
          // DataCell(
          //   IconButton(
          //     onPressed: () {
          //       services.changeVendorStatus(
          //         query: 'isTopPicked',
          //         id: document.data()['uid'],
          //         status: document.data()['isTopPicked'],
          //       );
          //     },
          //     icon: document.data()['isTopPicked']
          //         ? Icon(
          //             Icons.check_circle,
          //             color: Colors.green,
          //           )
          //         : Icon(null),
          //   ),
          // ),
          // DataCell(
          //   Text(document.data()['shopName']),
          // ),
          // DataCell(
          //   Row(
          //     children: [
          //       Icon(
          //         Icons.star,
          //         color: Colors.grey,
          //       ),
          //       Text('3.5'),
          //     ],
          //   ),
          // ),
          // DataCell(Text('20.000')),
          DataCell(
            document.data() == null ? Text('') : Text(document['username']),
          ),
          DataCell(
            document.data() == null ? Text('') : Text(document['password']),
          ),
          // DataCell(
          //   IconButton(
          //     onPressed: () {
          //       // vendor detayları için yeni kısım
          //       showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             print('uid: ${document.data()['uid']} girdi');
          //             return MyVendorDetails(uid: document.data()['uid']);
          //           });
          //     },
          //     icon: Icon(Icons.info_outline),
          //   ),
          // ),
        ],
      );
    }).toList();
    return newList;
  }
}
