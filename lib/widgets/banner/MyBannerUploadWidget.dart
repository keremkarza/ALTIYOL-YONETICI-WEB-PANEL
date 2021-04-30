// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyUploadWidget extends StatefulWidget {
  @override
  _MyUploadWidgetState createState() => _MyUploadWidgetState();
}

class _MyUploadWidgetState extends State<MyUploadWidget> {
  bool _visible = false;
  var _fileNameTextController = TextEditingController();
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
        padding: const EdgeInsets.only(left: 30),
        child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Row(
            children: [
              Visibility(
                visible: _visible,
                child: Container(
                  child: Row(
                    children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: SizedBox(
                          width: 300,
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
                                hintText: 'Uploaded Image',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 20),
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
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: AbsorbPointer(
                          absorbing: _imageSelected,
                          child: TextButton(
                              onPressed: () {
                                //işin içinden çıkılamadı, sonra tekrar bak.
                                //   print(_url.toString());
                                // if ((defaultTargetPlatform ==
                                //         TargetPlatform.iOS) ||
                                //     (defaultTargetPlatform ==
                                //         TargetPlatform.android)) {
                                //   print('girdi1');
                                //   // Some android/ios specific code
                                // } else if ((defaultTargetPlatform ==
                                //         TargetPlatform.linux) ||
                                //     (defaultTargetPlatform ==
                                //         TargetPlatform.macOS)) {
                                //   print('girdi2');
                                //   // Some desktop? specific code there
                                // } else if (defaultTargetPlatform ==
                                //     TargetPlatform.fuchsia) {
                                //   print('girdi3');
                                //   // Some fuchsia specific code here
                                // } else if ((defaultTargetPlatform ==
                                //     TargetPlatform.windows)) {
                                //   // Some web specific code here
                                //   print('girdi');
                                //   _services
                                //       .uploadBannerImageToDbFromCarrierApp(_url)
                                //       .then((downloadUrl) {
                                //     print(_url.toString());
                                //     if (downloadUrl != null) {
                                //       print('Saved Banner Image Successfully');
                                //       _services.saveSliderDataToFirestore(
                                //           url: _url);
                                //
                                //       // _services.showMyDialog(
                                //       //   title: 'New Banner Image',
                                //       //   message:
                                //       //       'Saved Banner Image Successfully',
                                //       //   context: context,
                                //       // );
                                //     }
                                //   });
                                // }
                                // print('girmedi');
                              },
                              child: Text('Save Image')),
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
                    child: Text('Add New Banner')),
              ),
            ],
          ),
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
    final String path = 'bannerImage/$dateTime';
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
