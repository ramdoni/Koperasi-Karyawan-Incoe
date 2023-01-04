import 'package:flutter/material.dart';
import '../helpers/util.dart';

class BelanjaRiwayatTokenScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final argument;

  BelanjaRiwayatTokenScreen({this.argument});

  @override
  createState() {
    return BelanjaRiwayatTokenState();
  }
}

class BelanjaRiwayatTokenState extends State<BelanjaRiwayatTokenScreen> {
  Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.argument;
    });
  }

  Widget build(context) {
    return Scaffold(
        backgroundColor: getColorFromHex('efefef'),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          titleSpacing: 0,
          title: const Text('Kembali', style: TextStyle(color: Colors.white, fontSize: 16)),
          backgroundColor: getColorFromHex('32c8b1'),
          elevation: 0,
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(children: [
                      Expanded(flex: 5, child: Text("No Transaksi", style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(flex: 5, child: Text(data['no_transaksi'].toString()))
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(children: [
                      Expanded(
                          flex: 5, child: Text("Metode Pembayaran", style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(flex: 5, child: Text(data['metode_pembayaran']))
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(children: [
                      Expanded(flex: 5, child: Text("Nomor Pelanggan", style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(flex: 5, child: Text(data['no'].toString()))
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(children: [
                      Expanded(flex: 5, child: Text("Nama", style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(flex: 5, child: Text(data['nama']))
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(children: [
                      Expanded(flex: 5, child: Text("Kwh", style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(flex: 5, child: Text(data['kwh']))
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(children: [
                      Expanded(flex: 5, child: Text("Tanggal", style: TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(flex: 5, child: Text(data['date']))
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.topLeft,
                    child: Text("No Token", style: TextStyle(fontWeight: FontWeight.w600))),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                    width: MediaQuery.of(context).size.width * 0.98,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: getColorFromHex('41c8b1'), style: BorderStyle.solid, width: 0.80),
                    ),
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    child: Text(data['no_token'].toString(),
                        style: TextStyle(fontSize: 20, color: getColorFromHex('41c8b1'), fontWeight: FontWeight.w700))),
              ],
            )));
  }
}
