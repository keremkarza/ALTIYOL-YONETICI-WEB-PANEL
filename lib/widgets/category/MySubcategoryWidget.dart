import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MySubcategoryWidget extends StatefulWidget {
  final String categoryName;

  MySubcategoryWidget(this.categoryName);

  @override
  _MySubcategoryWidgetState createState() => _MySubcategoryWidgetState();
}

class _MySubcategoryWidgetState extends State<MySubcategoryWidget> {
  FirebaseServices _services = FirebaseServices();
  var _subCategoryNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 300,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: FutureBuilder<DocumentSnapshot>(
            future: _services.categories.doc(widget.categoryName).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(child: Text('No Subcategories added'));
                }
                Map<String, dynamic> data = snapshot.data.data();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Main Category  :  '),
                              Text(widget.categoryName,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Divider(thickness: 3),
                          //subcategory list widget
                        ],
                      ),
                    ),
                    Container(
                      //subcategory list
                      child: Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Text('${index + 1}',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                title: Text(data['subCategory'][index]['name'],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic)),
                              ),
                            );
                          },
                          itemCount: data['subCategory'] == null
                              ? 0
                              : data['subCategory'].length,
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Divider(thickness: 3),
                          Container(
                            color: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Add New Subcategory',
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 30,
                                          child: TextField(
                                            controller:
                                                _subCategoryNameTextController,
                                            decoration: InputDecoration(
                                              hintText: 'Subcategory Name',
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              focusedBorder:
                                                  OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: TextButton(
                                          onPressed: () {
                                            if (_subCategoryNameTextController
                                                .text.isEmpty) {
                                              return _services.showMyDialog(
                                                  context: context,
                                                  title: 'Add New Subcategory',
                                                  message:
                                                      'Need to Give Subcategory Name');
                                            }
                                            DocumentReference doc = _services
                                                .categories
                                                .doc(widget.categoryName);
                                            doc.update({
                                              'subCategory':
                                                  FieldValue.arrayUnion([
                                                {
                                                  'name':
                                                      _subCategoryNameTextController
                                                          .text,
                                                }
                                              ]),
                                            });
                                            // tüm widget agacını yeniden başlat
                                            setState(() {});
                                            // update sonrası sıfırla
                                            _subCategoryNameTextController
                                                .clear();
                                          },
                                          child: Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
