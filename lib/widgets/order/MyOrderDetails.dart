import 'package:admin_multivendor_app/constants.dart';
import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MyOrderDetails extends StatefulWidget {
  final String uid;
  MyOrderDetails({this.uid});
  @override
  _MyOrderDetailsState createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {
  AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  //static const platform = MethodChannel('samples.flutter.dev/printing');
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _services.orders.doc(widget.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        String userId = snapshot.data['userId'].toString();
        return Center(
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.3,
                    constraints: BoxConstraints(minWidth: 300),
                    child: ListView(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: _services.users.doc(userId).get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Something went wrong'));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(width: 20, height: 60),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Müşteri :  ${snapshot.data['firstName']} ${snapshot.data['lastName']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Divider(thickness: 5),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: _services.users.doc(userId).get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    print(snapshot.data.toString());
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text('Something went wrong'));
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    //print(snapshot.data['email'] + ' bura');
                                    return Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      child: Text('Tel',
                                                          style:
                                                              kVendorDetailsTextstyle))),
                                              Container(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(' :'),
                                              )),
                                              Expanded(
                                                  child: Container(
                                                child: Text(
                                                  "${snapshot.data['number']}",
                                                  style:
                                                      kVendorDetailsTextstyle,
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      child: Text('Email',
                                                          style:
                                                              kVendorDetailsTextstyle))),
                                              Container(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(':'),
                                              )),
                                              Expanded(
                                                  child: Container(
                                                child: Text(
                                                    snapshot.data['email']),
                                              )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                      child: Text('Address',
                                                          style:
                                                              kVendorDetailsTextstyle))),
                                              Container(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(':'),
                                              )),
                                              Expanded(
                                                  child: Container(
                                                child: Text(
                                                  snapshot.data['address'],
                                                  style:
                                                      kVendorDetailsTextstyle,
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              SizedBox(height: 50),
                              StreamBuilder(
                                stream: _services.orders
                                    .where("docId", isEqualTo: widget.uid)
                                    //.where('seller.orderStatus', isNotEqualTo: 'Rejected')
                                    //.orderBy('seller.timeStamp', descending: false)
                                    // .where('accVerified', isEqualTo: active)
                                    // .where('isTopPicked', isEqualTo: topPicked)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  //int index = 0;
                                  if (snapshot.hasError) {
                                    return Text('Something went wrong');
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      showBottomBorder: true,
                                      dataRowHeight: 60,
                                      headingRowColor:
                                          MaterialStateProperty.all(
                                              Colors.grey[200]),
                                      //table headers
                                      columns: <DataColumn>[
                                        DataColumn(label: Text('ADET')),
                                        DataColumn(label: Text('ÜRÜN RESMİ')),
                                        DataColumn(label: Text('ÜRÜN ADI')),
                                        DataColumn(label: Text('BİRİM FİYATI')),
                                        DataColumn(label: Text('TOPLAM')),
                                        // DataColumn(label: Text('REDDET')),
                                        // DataColumn(label: Text('YAZDIR')),
                                      ],
                                      //details
                                      rows: _orderDetailsRows(
                                          snapshot.data, _services),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        color: Colors.grey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Sipariş Toplam : ${snapshot.data['total'].toString()} TL',
                                            style: kVendorDetailsTextstyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                        color: Colors.red,
                                        child: TextButton(
                                          onPressed: () {
                                            _services.changeOrderStatus(
                                              query: 'seller.orderStatus',
                                              id: snapshot.data['docId'],
                                              status: '',
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              'REDDET',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                        color: Colors.orange,
                                        child: TextButton(
                                          onPressed: () async {
                                            await player.setAsset(
                                                'assets/audio/pristin.mp3');
                                            player.play();
                                          },
                                          style: TextButton.styleFrom(
                                              backgroundColor: Colors.orange),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              'YAZDIR',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<DataRow> _orderDetailsRows(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> insideList = [];
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      print(document['products'].length.toString());
      //int index = 0;
      for (int i = 0; i < document['products'].length; i++) {
        print(i);
        print(document['products'][i]['productName'].toString());
        insideList.add(DataRow(
          cells: [
            //0 yerine 0,1,2 diye gezmesi lazım
            DataCell(Text(document['products'][i]['qty'].toString() + ' Adet')),
            DataCell(Container(
              width: 60,
              height: 60,
              child: Image.network(
                  document['products'][i]['productImage'].toString()),
            )),
            DataCell(Text(document['products'][i]['productName'])),
            DataCell(Text(document['products'][i]['price'].toString() + ' TL')),
            DataCell(Text(document['products'][i]['total'].toString() + ' TL')),
          ],
        ));
      }
      return DataRow(
        cells: [
          //0 yerine 0,1,2 diye gezmesi lazım
          DataCell(Text(document['products'][0]['qty'].toString())),
          DataCell(Container(
            width: 60,
            height: 60,
            child: Image.network(
                document['products'][0]['productImage'].toString()),
          )),
          DataCell(Text(document['products'][0]['productName'])),
          DataCell(Text(document['products'][0]['price'].toString())),
          DataCell(Text(document['products'][0]['total'].toString())),
        ],
      );
    }).toList();
    //}).toList();
    print(insideList.toString());
    return insideList;
  }
}
