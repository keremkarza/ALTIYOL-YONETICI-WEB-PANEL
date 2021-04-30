import 'package:admin_multivendor_app/constants.dart';
import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyVendorDetails extends StatefulWidget {
  final String uid;
  MyVendorDetails({this.uid});
  @override
  _MyVendorDetailsState createState() => _MyVendorDetailsState();
}

class _MyVendorDetailsState extends State<MyVendorDetails> {
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _services.vendors.doc(widget.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    snapshot.data['url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data['shopName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(snapshot.data['dialog']),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 5),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          child: Text('Contact Number',
                                              style: kVendorDetailsTextstyle))),
                                  Container(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(':'),
                                  )),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data['mobile']),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          child: Text('Email',
                                              style: kVendorDetailsTextstyle))),
                                  Container(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(':'),
                                  )),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data['email']),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          child: Text('Address',
                                              style: kVendorDetailsTextstyle))),
                                  Container(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(':'),
                                  )),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data['address']),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(thickness: 5),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          child: Text('Top Pick Status',
                                              style: kVendorDetailsTextstyle))),
                                  Container(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(':'),
                                  )),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: snapshot.data['isTopPicked']
                                          ? Chip(
                                              backgroundColor: Colors.green,
                                              label: Row(
                                                children: [
                                                  Icon(Icons.check,
                                                      color: Colors.white),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Top Picked',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            )
                                          : Chip(
                                              backgroundColor: Colors.red,
                                              label: Row(
                                                children: [
                                                  Icon(Icons.highlight_remove,
                                                      color: Colors.white),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'Not Top Picked',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Divider(thickness: 5),
                            ),
                            Wrap(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .money_dollar_circle,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Total Revenue'),
                                            Text('12,000'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              CupertinoIcons.cart_fill,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Active Orders'),
                                            Text('6'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.shopping_bag,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Total Orders'),
                                            Text('130'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.grain_outlined,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Products'),
                                            Text('160 Products'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.list_alt_outlined,
                                              size: 50,
                                              color: Colors.black54,
                                            ),
                                            Text('Statement'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: snapshot.data['accVerified']
                        ? Chip(
                            backgroundColor: Colors.green,
                            label: Row(
                              children: [
                                Icon(Icons.check, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Active Account',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        : Chip(
                            backgroundColor: Colors.red,
                            label: Row(
                              children: [
                                Icon(Icons.highlight_remove,
                                    color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Inactive Account',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
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
}
