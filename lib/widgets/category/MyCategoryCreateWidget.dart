// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';

class MyCategoryCreateWidget extends StatefulWidget {
  @override
  _MyCategoryCreateWidgetState createState() => _MyCategoryCreateWidgetState();
}

class _MyCategoryCreateWidgetState extends State<MyCategoryCreateWidget> {
  bool _visible = false;
  var _fileNameTextController = TextEditingController();
  var _categoryNameTextController = TextEditingController();
  bool _imageSelected = true;
  FirebaseServices _services = FirebaseServices();
  String _url;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: TextField(
                          controller: _categoryNameTextController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'No Category Name Given',
                            hintStyle: TextStyle(fontSize: 13),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                        width: 200,
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextField(
                            controller: _fileNameTextController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'No Image Selected',
                              hintStyle: TextStyle(fontSize: 13),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          uploadStorage();
                        },
                        child: Text('Upload Image')),
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: AbsorbPointer(
                        absorbing: _imageSelected,
                        child: TextButton(
                            onPressed: () {
                              if (_categoryNameTextController.text.isEmpty) {
                                return _services.showMyDialog(
                                  context: context,
                                  title: 'Add New Category',
                                  message: 'New Category Name not Given',
                                );
                              }
                              print(_url.toString());
                              _services
                                  .uploadCategoryImageToDb(
                                      _url, _categoryNameTextController.text)
                                  .then((downloadUrl) {
                                print(_url.toString());
                                if (downloadUrl != null) {
                                  _services.showMyDialog(
                                    title: 'New Category',
                                    message: 'Saved New Category Successfully',
                                    context: context,
                                  );
                                }
                              });
                              _categoryNameTextController.clear();
                              _fileNameTextController.clear();
                            },
                            child: Text('Save Category')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _visible ? false : true,
              child: TextButton(
                  onPressed: () {
                    print(_visible);
                    setState(() {
                      _visible = true;
                      print(_visible);
                    });
                  },
                  child: Text('Add New Category')),
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage({@required Function(File file) onSelected}) {
    //selecting the image
    InputElement uploadInpt = FileUploadInputElement()..accept = 'image/*';
    uploadInpt.click();
    uploadInpt.onChange.listen((event) {
      final file = uploadInpt.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void uploadStorage() {
    //uploading selected image to storage
    final dateTime = DateTime.now();
    final path = 'categoryImage/$dateTime';
    uploadImage(onSelected: (file) {
      if (file != null) {
        setState(() {
          _fileNameTextController.text = file.name;
          _imageSelected = false;
          _url = path; //this path(url will upload to)
          print(_url);
        });
        fb
            .storage()
            .refFromURL('gs://multivendor-app-9b552.appspot.com')
            .child(path)
            .put(file);
      }
    });
    print(_url);
  }
}
