import 'package:admin_multivendor_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CreateNewCarrier extends StatefulWidget {
  @override
  _CreateNewCarrierState createState() => _CreateNewCarrierState();
}

class _CreateNewCarrierState extends State<CreateNewCarrier> {
  bool _visible = false;
  FirebaseServices _services = FirebaseServices();
  var emailText = TextEditingController();
  var passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          Visibility(
            visible: !_visible,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 5, left: 30),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        _visible = true;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sisteme yeni kurye ekle'),
                    )),
              ),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: TextField(
                              //TODO:EMAIL validator
                              controller: emailText,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Email ID',
                                hintStyle: TextStyle(fontSize: 13),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          height: 30,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: TextField(
                              controller: passwordText,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Password',
                                hintStyle: TextStyle(fontSize: 13),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: TextButton(
                            onPressed: () {
                              if (emailText.text.isEmpty) {
                                return _services.showMyDialog(
                                    context: context,
                                    title: 'Email Error',
                                    message: 'Email is empty');
                              } else if (passwordText.text.isEmpty) {
                                return _services.showMyDialog(
                                    context: context,
                                    title: 'Password Error',
                                    message: 'Password is empty');
                              } else if (passwordText.text.length < 6) {
                                return _services.showMyDialog(
                                    context: context,
                                    title: 'Password Error',
                                    message:
                                        'Password should have more than 6 characters.');
                              }
                              _services
                                  .saveDeliveryCarriers(
                                      emailText.text, passwordText.text)
                                  .whenComplete(() {
                                emailText.clear();
                                passwordText.clear();
                                _services.showMyDialog(
                                    context: context,
                                    title: 'Save Delivery Boy',
                                    message: 'Saved Successfuly');
                              });
                            },
                            child: Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
