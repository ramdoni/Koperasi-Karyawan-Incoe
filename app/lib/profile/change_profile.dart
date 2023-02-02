import 'package:coopzone_application/helpers/bottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../home.dart';
import 'change_password.dart';
import 'index.dart';

final _storage = FlutterSecureStorage();

class ProfileChangeScreen extends StatefulWidget {
  @override
  createState() {
    return ProfileChangeScreenState();
  }
}

class ProfileChangeScreenState extends State<ProfileChangeScreen> {
  int totalTagihan = 0, filterTahun;
  bool isLoading = false;
  bool isEdit = false;
  String isEditField;
  @override
  void initState() {
    super.initState();
  }

  Widget field_(title, value, keyEdit) {
    return Container(
        padding: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5, color: getColorFromHex('eeeeee')),
          ),
        ),
        margin: EdgeInsets.only(top: 15),
        child: Column(children: [
          Container(
              alignment: Alignment.topLeft,
              child: Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
          Row(
            children: [
              Expanded(
                  flex: 6,
                  child: (isEdit && isEditField == keyEdit)
                      ? Container(
                          height: 38,
                          child: TextFormField(
                            obscureText: true,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Password Sebelumnya required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                            onSaved: (value) {
                              setState(() {});
                            },
                          ))
                      : Text((value == "" || value == null) ? "-" : value)),
              Expanded(
                  flex: 2,
                  child: (isEdit && isEditField == keyEdit)
                      ? Container(
                          child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Icon(Icons.check, color: Colors.green))),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isEdit = false;
                                      });
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(left: 5, right: 5),
                                        child: Icon(Icons.close, color: Colors.red))))
                          ],
                        ))
                      : Container(
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  isEdit = true;
                                  isEditField = keyEdit;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.pencil_ellipsis_rectangle,
                                color: getColorFromHex('4ec9b2'),
                                size: 25.0,
                              ))))
            ],
          )
        ]));
  }

  Widget build(context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileIndexScreen()));
        },
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white //change your color here
                  ),
              bottomOpacity: 0.0,
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
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
                                    alignment: Alignment.topLeft,
                                    child: Text("Ubah Profile",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
                                Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(width: 1.5, color: getColorFromHex('eeeeee')),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(top: 20),
                                    child: Column(children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: Text("No Anggota",
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                                      Container(alignment: Alignment.topLeft, child: Text(session.noAnggota))
                                    ])),
                                field_('Nama', session.name_, 'name'),
                                field_('No KTP', session.nik_, 'nik'),
                                field_('No Telepon', session.noTelepon, 'no_telepon'),
                                field_('Jenis Kelamin', session.jenisKelamin, 'jenis_kelamin'),
                                field_('Tempat Lahir', session.tempatLahir, 'tempat_lahir'),
                                field_('Tanggal Lahir', session.tanggalLahir, 'tanggal_lahir'),
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
                                      onPressed: () {},
                                      child: Text('Simpan Perubahan',
                                          style: TextStyle(
                                            color: getColorFromHex('FFFFFF'),
                                          )),
                                    )))),
                      ],
                    )))));
  }
}
