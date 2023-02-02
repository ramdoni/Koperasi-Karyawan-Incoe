import 'package:flutter/material.dart';
import '../helpers/util.dart';

class BelanjaRiwayatPulsaScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final argument;

  BelanjaRiwayatPulsaScreen({this.argument});

  @override
  createState() {
    return BelanjaRiwayatPulsaState();
  }
}

class BelanjaRiwayatPulsaState extends State<BelanjaRiwayatPulsaScreen> {
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
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: getColorFromHex('41c8b1')))),
                    child: Row(children: [
                      Expanded(
                          flex: 5,
                          child: Text("No Transaksi", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(
                          flex: 5,
                          child: Text(data['no_transaksi'].toString(),
                              textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))
                    ])),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: getColorFromHex('41c8b1')))),
                    child: Row(children: [
                      Expanded(
                          flex: 5,
                          child:
                              Text("Metode Pembayaran", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(
                          flex: 5,
                          child: Text(data['metode_pembayaran'],
                              textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))
                    ])),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: getColorFromHex('41c8b1')))),
                    child: Row(children: [
                      Expanded(
                          flex: 5,
                          child: Text("Transaksi", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(
                          flex: 5,
                          child: Text(data['items'].toString(),
                              textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))
                    ])),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: getColorFromHex('41c8b1')))),
                    child: Row(children: [
                      Expanded(
                          flex: 5, child: Text("Harga", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(
                          flex: 5,
                          child: Text(data['price'].toString(),
                              textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))
                    ])),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: getColorFromHex('41c8b1')))),
                    child: Row(children: [
                      Expanded(
                          flex: 5, child: Text("Tanggal", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(
                          flex: 5,
                          child: Text(data['date'], textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))
                    ])),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: getColorFromHex('41c8b1')))),
                    child: Row(children: [
                      Expanded(
                          flex: 5, child: Text("Status", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(
                          flex: 5,
                          child: Text(data['status'], textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))
                    ])),
                Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration:
                        BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: getColorFromHex('41c8b1')))),
                    child: Row(children: [
                      Expanded(
                          flex: 5,
                          child: Text("Keterangan", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                      Expanded(
                          flex: 5,
                          child: Text(data['keterangan'], textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))
                    ])),
              ],
            )));
  }
}
