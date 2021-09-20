import 'package:admin_multivendor_app/screens/LoginScreen.dart';
import 'package:admin_multivendor_app/widgets/MySideBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class ExitScreen extends StatelessWidget {
  static const String id = 'exit-screen';

  @override
  Widget build(BuildContext context) {
    MySideBar _sideBar = MySideBar();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('ALTIYOL GENEL YÖNETİM PANELİ'),
      ),
      sideBar: _sideBar.sideBarMenus(context, ExitScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'ÇIKIŞ SAYFASI',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 800,
                child: Center(
                  child: Container(
                    height: 100,
                    width: 300,
                    child: TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          print('kullanıcı senin tıklamanla çıktı.');
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.id);
                        },
                        child: Text('Bu hesaptan çık')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
