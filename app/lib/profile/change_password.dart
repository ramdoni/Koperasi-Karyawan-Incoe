import 'dart:developer';

import 'package:flutter/material.dart';
import '../helpers/util.dart';
import 'index.dart';

class ChangePasswordScreen extends StatefulWidget {
  createState() {
    return ChangePasswordScreenState();
  }
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<State> _keyLoader = GlobalKey();
  final formKey = GlobalKey<FormState>();

  String oldPassword, newPassword, confirmNewPassword;
  bool isSubmit = false;
  void _submit() async {
    Dialogs.showLoadingDialog(context, _keyLoader);

    try {
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        setState(() {
          isSubmit = true;
        });
        sendData('/anggota/change-password', {
          'old_password': oldPassword,
          'new_password': newPassword,
          'confirm_new_password': confirmNewPassword
        }).then((res) {
          log(res.data.toString());
          if (res.data['status'] == 'error') {
            bottomInfo(context, res.data['message']);
          } else {
            bottomInfo(context, 'Password changed successfully');
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileIndexScreen()));
          }
          setState(() {
            isSubmit = false;
          });
        });
      }
    } catch (error) {}
    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: getColorFromHex('08CFB6') //change your color here
              ),
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Ubah Password",
            style: TextStyle(color: getColorFromHex('08CFB6')),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(right: 20, left: 20, top: 10),
            child: Form(
                key: formKey,
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Password Sebelumnya',
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)))),
                          Container(
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
                                  setState(() {
                                    oldPassword = value;
                                  });
                                },
                              ))
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Password Password',
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)))),
                          Container(
                              height: 38,
                              child: TextFormField(
                                obscureText: true,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Password required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )),
                                onSaved: (value) {
                                  setState(() {
                                    newPassword = value;
                                  });
                                },
                              ))
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Konfirmasi Password Baru',
                                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)))),
                          Container(
                              height: 38,
                              child: TextFormField(
                                obscureText: true,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Konfirmasi Password required";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
                                    // labelText: "Old Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )),
                                onSaved: (value) {
                                  setState(() {
                                    confirmNewPassword = value;
                                  });
                                },
                              ))
                        ],
                      )),
                  ButtonTheme(
                      // minWidth: double.infinity,
                      height: 35.0,
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: getColorFromHex("4ec9b2"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () {
                              _submit();
                            },
                            child: (isSubmit
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : Text('Simpan Perubahan', style: TextStyle(color: Colors.white))),
                          ))),
                ]))));
  }
}
