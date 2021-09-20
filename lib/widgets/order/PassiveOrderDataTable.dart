import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PassiveOrderDataTable extends StatefulWidget {
  @override
  _PassiveOrderDataTableState createState() => _PassiveOrderDataTableState();
}

class _PassiveOrderDataTableState extends State<PassiveOrderDataTable> {
  // int tag = 0;
  // List<String> options = [
  //   'All Vendors', //0
  //   'Active', //1
  //   'Inactive', //2
  //   'Top Picked', //3
  //   'Top Rated', //4
  // ];

  // bool topPicked;
  // bool active;
  //
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
          stream: _services.orders
              .where('seller.orderStatus', isEqualTo: 'Delivered')
              //.where('seller.orderStatus', isEqualTo: 'Rejected')
              //.orderBy('seller.timeStamp', descending: true)
              // .where('accVerified', isEqualTo: active)
              // .where('isTopPicked', isEqualTo: topPicked)
              .snapshots(),
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
                  DataColumn(label: Text('DÜKKAN')),
                  DataColumn(label: Text('DURUM')),
                  DataColumn(label: Text('ÖDEME TÜRÜ')),
                  DataColumn(label: Text('TESLİMAT ÜCRETİ')),
                  DataColumn(label: Text('İNDİRİM')),
                  DataColumn(label: Text('İNDİRİM KODU')),
                  DataColumn(label: Text('TOPLAM')),
                  DataColumn(label: Text('SİPARİŞ GÜNÜ')),
                  DataColumn(label: Text('SİPARİŞ SAATİ')),
                  DataColumn(label: Text('KURYE')),

                  // DataColumn(label: Text('Email')),
                  // DataColumn(label: Text('View Details')),
                ],
                //details
                rows: _vendorDetailsRows(snapshot.data, _services),
              ),
            );
          },
        ),
      ],
    );
  }

  List<DataRow> _vendorDetailsRows(
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
          DataCell(Text(document['seller']['shopName'])),
          DataCell(Text(
            document['seller']['orderStatus'] == 'Delivered'
                ? 'Teslim Edildi'
                : 'İşlem Hatalı',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
          )),
          DataCell(
            Text(document['cod'] == 0
                ? 'Online Ödeme'
                : document['cod'] == 1
                    ? 'Kapıda Kredi Kartı'
                    : 'Kapıda Nakit'),
          ),
          DataCell(
            Row(
              children: [
                // Icon(
                //   Icons.star,
                //   color: Colors.grey,
                // ),
                Text(document['deliveryFee'].toString() + ' TL'),
              ],
            ),
          ),
          DataCell(Text(document['discount'].toString() + ' TL')),
          DataCell(
            Text(document['discountCode'] == null
                ? 'YOK'
                : document['discountCode']),
          ),
          DataCell(
            Text(document['total'].toString() + ' TL'),
          ),
          DataCell(Text(
              document['seller']['timeStamp'].toString().substring(0, 11))),
          DataCell(Text(
              document['seller']['timeStamp'].toString().substring(11, 19))),
          DataCell(Text(document['deliveryBoy']['name'].toString())),
          // DataCell(
          //   IconButton(
          //     onPressed: () {
          //       // vendor detayları için yeni kısım
          //       showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             print('uid: ${document.data()['userId']} girdi');
          //             return MyVendorDetails(uid: document.data()['userId']);
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
