import 'package:admin_multivendor_app/widgets/category/MySubcategoryWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyCategoryCardWidget extends StatelessWidget {
  final DocumentSnapshot document;
  MyCategoryCardWidget(this.document);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MySubcategoryWidget(document['name']);
            });
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: Card(
          color: Colors.white.withOpacity(.9),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Image.network(document['image']),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Center(
                      child: Text(
                        document['name'],
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
