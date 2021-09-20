import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'MyOrderDetails.dart';

class NewOrderDataTable extends StatefulWidget {
  @override
  _NewOrderDataTableState createState() => _NewOrderDataTableState();
}

class _NewOrderDataTableState extends State<NewOrderDataTable> {
  AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    print('printAudio');
    _setAudio();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   print('printAudio2');
  //   _setAudio();
  //   player.play();
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  _setAudio() async {
    await player.setAsset('assets/audio/pristin.mp3');
  }

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
              .where('seller.orderStatus', isNotEqualTo: 'Delivered')
              //.where('seller.orderStatus', isNotEqualTo: 'Rejected')
              //.orderBy('seller.timeStamp', descending: false)
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
                  DataColumn(label: Text('AKTİVİTE')),

                  // DataColumn(label: Text('Email')),
                  DataColumn(label: Text('DETAY')),
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

//   _playSound() async {
//   await player.setAsset('assets/audio/cow.mp3');
//   player.play();
// },

  List<DataRow> _vendorDetailsRows(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      player.setAsset('assets/audio/pristin.mp3');
      player.play();
      //RingtonePlayer.ringtone();
      //AudioPlayer audioPlayer = AudioPlayer();
      // playLocal() async {
      //   int result = await audioPlayer.play("https://freesound.org/s/456966/",
      //       isLocal: false);
      // }
      return DataRow(
        cells: [
          DataCell(Text(document['seller']['shopName'])),
          DataCell(Text(
            document['seller']['orderStatus'] == 'Ordered'
                ? 'Sipariş Geldi'
                : document['seller']['orderStatus'] == 'Accepted'
                    ? 'Kabul Edildi'
                    : document['seller']['orderStatus'] == 'Picked Up'
                        ? 'Hazırlandı'
                        : document['seller']['orderStatus'] == 'On the way'
                            ? 'Yolda'
                            : document['seller']['orderStatus'] == 'Delivered'
                                ? 'Teslim Edildi'
                                : 'Reddedildi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: document['seller']['orderStatus'] == 'Ordered'
                  ? Colors.blue
                  : document['seller']['orderStatus'] == 'Accepted'
                      ? Colors.brown
                      : document['seller']['orderStatus'] == 'Picked Up'
                          ? Colors.orange
                          : document['seller']['orderStatus'] == 'On the way'
                              ? Colors.deepOrange
                              : document['seller']['orderStatus'] == 'Delivered'
                                  ? Colors.green
                                  : Colors.red,
            ),
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
          DataCell(
            TextButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  document['seller']['orderStatus'] == 'Ordered'
                      ? 'Siparişi Kabul Et'
                      : document['seller']['orderStatus'] == 'Accepted'
                          ? 'Siparişi Hazırla'
                          : document['seller']['orderStatus'] == 'Picked Up'
                              ? 'Yola Çıkar'
                              : document['seller']['orderStatus'] ==
                                      'On the way'
                                  ? 'Teslim Edildi'
                                  : 'İşlemler Bitti',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                _services.changeOrderStatus(
                  query: 'seller.orderStatus',
                  id: document.id,
                  status: document['seller']['orderStatus'],
                );
              },
            ),
          ),
          DataCell(
            IconButton(
              onPressed: () {
                // vendor detayları için yeni kısım
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      print('uid: ${document.id} girdi');
                      return MyOrderDetails(uid: document.id);
                    });
              },
              icon: Icon(Icons.info_outline),
            ),
          ),
        ],
      );
    }).toList();
    return newList;
  }
}
