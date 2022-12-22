import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'helpers/bottomNavBar.dart';

class PageProfileScreen extends StatefulWidget {
  @override
  createState() {
    return PageProfileScreenState();
  }
}

class PageProfileScreenState extends State<PageProfileScreen> {
  bool isLoadIuran = true;
  List dataIuran;
  int backPressCounter = 0, backPressTotal = 2, isTabFocus = 1, _selectedIndex = 0, pageIndex = 4;

  @override
  void initState() {
    super.initState();
  }

  Widget label_(label, value) {
    return Container(
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(children: [
          Expanded(flex: 3, child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 7, child: Text(" : " + value.toString()))
        ]));
  }

  @override
  Widget build(context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(),
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            margin: EdgeInsets.only(left: 0, top: 20),
            child: Image.asset(
              'logo.png',
            ),
            width: 140,
          ),
          elevation: 0.0,
          backgroundColor: Colors.grey[200]),
      body: Container(padding: const EdgeInsets.all(8), child: Column(children: [Container()])),
    );
  }

  Future<bool> onWillPop() {
    if (backPressCounter < 1) {
      Toast.show("Press again time to exit app", context);
      backPressCounter++;
      Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      exit(0);
      // return Future.value(true);
    }
  }
}
