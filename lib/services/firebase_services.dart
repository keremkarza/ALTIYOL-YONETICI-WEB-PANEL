import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  //Firebase Instances
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var storage = FirebaseStorage.instance;

  // Collection References
  CollectionReference banners =
      FirebaseFirestore.instance.collection('sliders');
  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference boys = FirebaseFirestore.instance.collection('boys');
  CollectionReference admins = FirebaseFirestore.instance.collection('Admin');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Admin Services
  Future<QuerySnapshot> getAdminCredentials() {
    var result = admins.get();
    return result;
  }

  //Category Services
  Future<String> uploadCategoryImageToDb(url, categoryName) async {
    //String downloadUrl = await storage.ref().child(url).getDownloadURL();
    String downloadUrl = await storage.ref(url).getDownloadURL();
    print(downloadUrl);
    if (downloadUrl != null) {
      print(downloadUrl);
      categories.doc(categoryName).set({
        'image': downloadUrl,
        'name': categoryName,
      });
    }
    return downloadUrl;
  }

  //Delivery Services
  Future<void> saveDeliveryCarriers(email, password) async {
    boys.doc(email).set({
      'email': email,
      'password': password,
      'accVerified': false,
      'address': '',
      'url': '',
      'location': GeoPoint(0, 0),
      'mobile': '',
      'name': '',
      'uid': '',
    });
  }

  updateCarrierStatus({id, context, accVerified}) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('boys').doc(id);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }

          transaction.update(documentReference, {'accVerified': !accVerified});
        })
        .then((value) => showMyDialog(
            context: context,
            title: 'Approval',
            message:
                "Delivery carrier updated as :  ${accVerified == false ? 'Approved' : 'Not Approved'}"))
        .catchError((error) => showMyDialog(
            context: context,
            title: 'Approval',
            message: "Failed to update carrier status: $error"));
  }

  // Banner Services
  Future<String> uploadBannerImageToDb(url) async {
    //print(await storage);
    //print(await storage.ref());
    //print(await storage.ref().child(url).toString());
    //print(await storage.ref(url));
    //print(await storage.ref(url).getDownloadURL());
    //print(await storage.ref().child(url).getDownloadURL());

    //  bannerImage/
    String formattedUrl = url.substring(12);
    print('formatted : $formattedUrl');
    String downloadUrl = await storage
        .refFromURL('gs://multivendor-app-9b552.appspot.com')
        .child(formattedUrl)
        .getDownloadURL();
    //String downloadUrl = await storage.ref(url).getDownloadURL();

    print(downloadUrl);
    if (downloadUrl != null) {
      print(downloadUrl);
      firestore.collection('sliders').add({
        'image': formattedUrl,
      });
    }
    return downloadUrl;
  }

  Future<String> uploadBannerImageToDbFromCarrierApp(filePath) async {
    File file = File(filePath);
    FirebaseStorage _storage = FirebaseStorage.instance;
    try {
      await _storage
          .ref('generalSliders/$filePath')
          .child('generalSliders/$filePath')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.code);
    }
    //will save url path of file in db
    String downloadURL = await _storage
        .ref('generalSliders/$filePath')
        .child('generalSliders/$filePath')
        .getDownloadURL();
    return downloadURL;
  }

  Future<void> saveSliderDataToFirestore({String url}) {
    banners.doc(url).set({
      'image': url,
    });
    return null;
  }

  deleteBannerImageFromDb(id) async {
    banners.doc(id).delete();
  }

  // Order Services
  changeOrderStatus({id, status, query}) async {
    orders.doc(id).update({
      query: status == 'Ordered'
          ? 'Accepted'
          : status == 'Accepted'
              ? 'Picked Up'
              : status == 'Picked Up'
                  ? 'On the way'
                  : status == 'On the way'
                      ? 'Delivered'
                      : 'Rejected'
    });
  }

  Future<DocumentSnapshot> getOrderDetails(docId) async {
    DocumentSnapshot doc = await orders.doc(docId).get();
    return doc;
  }

  // Vendor Services
  changeVendorStatus({id, status, query}) async {
    vendors.doc(id).update({query: status ? false : true});
  }

  Future<void> confirmDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteBannerImageFromDb(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //General Services
  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
