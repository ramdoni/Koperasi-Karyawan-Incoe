import 'package:coopzone_application/helpers/bottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _storage = FlutterSecureStorage();

class ProfileIndexScreen extends StatefulWidget {
  @override
  createState() {
    return ProfileIndexScreenState();
  }
}

class ProfileIndexScreenState extends State<ProfileIndexScreen> {
  int totalTagihan = 0, filterTahun;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(context) {
    return Scaffold(
        bottomNavigationBar: bottomNavBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColorFromHex('FFFFFF'), //change your color here
          ),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
        ),
        backgroundColor: getColorFromHex('EFEFEF'),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.white,
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              alignment: Alignment.topLeft,
                              child: const Text("Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                            ),
                            Container(
                                child: Row(children: [
                              Expanded(
                                flex: 1,
                                child: Icon(CupertinoIcons.person_alt_circle, color: getColorFromHex('4ec9b2')),
                              ),
                              Expanded(
                                  flex: 9,
                                  child: Container(margin: EdgeInsets.only(left: 5), child: Text(session.name_))),
                            ]))
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(20),
                        color: Colors.white,
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("Akun", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
                            Container(
                                padding: EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 1.5, color: getColorFromHex('eeeeee')),
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Icon(CupertinoIcons.person_crop_circle_badge_exclam))),
                                    Expanded(flex: 8, child: Text("Ubah Profile")),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            child: InkWell(
                                                onTap: () {
                                                  // Navigator.of(context).push(MaterialPageRoute(
                                                  //     builder: (context) => SimpananSukarelaScreen()));
                                                },
                                                child: Icon(
                                                  CupertinoIcons.chevron_forward,
                                                  color: getColorFromHex('0f0f0f'),
                                                  size: 25.0,
                                                ))))
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Icon(CupertinoIcons.lock_circle))),
                                    const Expanded(flex: 8, child: Text("Ubah Password")),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            child: InkWell(
                                                onTap: () {
                                                  // Navigator.of(context).push(MaterialPageRoute(
                                                  //     builder: (context) => SimpananSukarelaScreen()));
                                                },
                                                child: Icon(
                                                  CupertinoIcons.chevron_forward,
                                                  color: getColorFromHex('0f0f0f'),
                                                  size: 25.0,
                                                ))))
                                  ],
                                )),
                          ],
                        )),
                    Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ButtonTheme(
                            height: 45.0,
                            child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      backgroundColor: getColorFromHex("4ec9b2"),
                                    ),
                                    onPressed: () {
                                      _storage.deleteAll();
                                      Navigator.of(context).pushNamed('/');
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 5,
                                            child: Container(
                                                margin: const EdgeInsets.only(right: 5),
                                                alignment: Alignment.centerRight,
                                                child: const Icon(Icons.logout))),
                                        Expanded(
                                            flex: 5,
                                            child: Text('Logout',
                                                style: TextStyle(
                                                  color: getColorFromHex('FFFFFF'),
                                                ))),
                                      ],
                                    ))))),
                  ],
                ))));
  }
}
