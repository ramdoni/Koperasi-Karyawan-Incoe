import 'package:coopzone_application/simpanan/lainnya.dart';
import 'package:coopzone_application/simpanan/pokok.dart';
import 'package:coopzone_application/simpanan/sukarela.dart';
import 'package:coopzone_application/simpanan/wajib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/bottomNavBar.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;

class SimpananScreen extends StatefulWidget {
  @override
  createState() {
    return SimpananScreenState();
  }
}

class SimpananScreenState extends State<SimpananScreen> {
  Widget build(context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(tabActive: 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Kembali', style: TextStyle(color: Colors.white, fontSize: 17)),
        backgroundColor: getColorFromHex('32c8b1'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
              height: 700,
              color: getColorFromHex("efefef"),
              child: Stack(children: <Widget>[
                Positioned(
                    top: 0,
                    child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        color: getColorFromHex('32c8b1'),
                        child: Column(
                          children: [
                            Container(
                                child: Column(
                              children: [],
                            ))
                          ],
                        ))),
                Positioned(
                    // top: 10,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(6)),
                            ),
                            width: MediaQuery.of(context).size.width * 0.94,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        child: Image.asset(
                                      'icon_wallet.png',
                                      height: 28,
                                    )),
                                    Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Total saldo simpanan kamu adalah : ",
                                                style: TextStyle(fontSize: 12)))),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 30, top: 1),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Rp. " + session.saldoSimpanan,
                                            style: TextStyle(fontSize: 16, color: getColorFromHex('32c8b1'))))),
                                Container(
                                    margin: EdgeInsets.only(left: 30, top: 10),
                                    padding: const EdgeInsets.only(left: 13, right: 13, top: 17, bottom: 17),
                                    color: getColorFromHex('efefef'),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => SimpananPokokScreen()));
                                        },
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    flex: 5,
                                                    child: Text("Simpanan Pokok : ", style: TextStyle(fontSize: 12))),
                                                Expanded(
                                                    flex: 4,
                                                    child: Text("Rp. " + session.simpananPokok,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: getColorFromHex('cccccc'),
                                                            fontWeight: FontWeight.w500))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(
                                                      CupertinoIcons.chevron_forward,
                                                      color: getColorFromHex('cccccc'),
                                                      size: 25.0,
                                                    ))
                                              ],
                                            )))),
                                Container(
                                    margin: const EdgeInsets.only(left: 30, top: 10),
                                    padding: const EdgeInsets.only(left: 13, right: 13, top: 17, bottom: 17),
                                    color: getColorFromHex('efefef'),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => SimpananWajibScreen()));
                                        },
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    flex: 5,
                                                    child: Text("Simpanan Wajib : ", style: TextStyle(fontSize: 12))),
                                                Expanded(
                                                    flex: 4,
                                                    child: Text("Rp. " + session.simpananWajib,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: getColorFromHex('cccccc'),
                                                            fontWeight: FontWeight.w400))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(
                                                      CupertinoIcons.chevron_forward,
                                                      color: getColorFromHex('cccccc'),
                                                      size: 25.0,
                                                    ))
                                              ],
                                            )))),
                                Container(
                                    margin: EdgeInsets.only(left: 30, top: 10),
                                    padding: const EdgeInsets.only(left: 13, right: 13, top: 17, bottom: 17),
                                    color: getColorFromHex('efefef'),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => SimpananSukarelaScreen()));
                                        },
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    flex: 5,
                                                    child:
                                                        Text("Simpanan Sukarela : ", style: TextStyle(fontSize: 12))),
                                                Expanded(
                                                    flex: 4,
                                                    child: Text("Rp. " + session.simpananSukarela,
                                                        style:
                                                            TextStyle(fontSize: 12, color: getColorFromHex('cccccc')))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(
                                                      CupertinoIcons.chevron_forward,
                                                      color: getColorFromHex('cccccc'),
                                                      size: 25.0,
                                                    ))
                                              ],
                                            )))),
                                Container(
                                    margin: EdgeInsets.only(left: 30, top: 10),
                                    padding: const EdgeInsets.only(left: 13, right: 13, top: 17, bottom: 17),
                                    color: getColorFromHex('efefef'),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => SimpananLainnyaScreen()));
                                        },
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                    flex: 5,
                                                    child:
                                                        Text("Simpanan Lain-lain : ", style: TextStyle(fontSize: 12))),
                                                Expanded(
                                                    flex: 4,
                                                    child: Text("Rp. " + session.simpananLainlain,
                                                        style:
                                                            TextStyle(fontSize: 12, color: getColorFromHex('cccccc')))),
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(
                                                      CupertinoIcons.chevron_forward,
                                                      color: getColorFromHex('cccccc'),
                                                      size: 25.0,
                                                    ))
                                              ],
                                            )))),
                              ],
                            )))),
                Positioned(
                    top: 380,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                  bottomRight: Radius.circular(6),
                                  bottomLeft: Radius.circular(6)),
                            ),
                            width: MediaQuery.of(context).size.width * 0.94,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        child: Image.asset(
                                      'icon_selamat.png',
                                      width: 28,
                                    )),
                                    Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: const Text("Selamat !",
                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)))
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 37),
                                    child: const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Kamu telah mengumpulkan SHU sementara sebesar : ",
                                            style: TextStyle(fontSize: 10, color: Colors.grey)))),
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 35),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Rp. " + session.shu + ",-",
                                            style: TextStyle(
                                                color: getColorFromHex('32C8B1'),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400)))),
                                Container(
                                    margin: const EdgeInsets.only(left: 37, top: 10),
                                    child: const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "Ayo tingkatkan terus transaksi Kamu untuk mendapatkan SHU yang lebih besar !",
                                            style: TextStyle(fontSize: 10, color: Colors.grey)))),
                              ],
                            )))),
                Positioned(
                    top: 535,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Container(
                            child: const Text("Petunjuk menggunakan simpanan Kamu untuk belanja..",
                                style: TextStyle(fontSize: 12))))),
                Positioned(
                    top: 565,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            // width: MediaQuery.of(context).size.width * 0.94,
                            child: Column(
                              children: [
                                Container(
                                    child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 30,
                                            alignment: Alignment.topCenter,
                                            child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text("1. ",
                                                    style: TextStyle(
                                                        color: getColorFromHex('32C8B1'),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w400))))),
                                    Expanded(
                                        flex: 9,
                                        child: Container(
                                            child: const Text(
                                                "Pembayaran belanja dengan menggunakan saldo simpanan akan diambil dari saldo simpanan lain-lain kemudian dilanjut dengan simpanan sukarela terlebih dahulu.",
                                                style: TextStyle(fontSize: 10))))
                                  ],
                                )),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: 30,
                                              alignment: Alignment.topCenter,
                                              child: Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Text("2. ",
                                                      style: TextStyle(
                                                          color: getColorFromHex('32C8B1'),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400))))),
                                      Expanded(
                                          flex: 9,
                                          child: Container(
                                              child: const Text(
                                                  "Saldo simpanan dapat digunakan untuk belanja di toko/mitra Koperasi, dan belanja digital melalui aplikasi Coop Zone. ",
                                                  style: TextStyle(fontSize: 10))))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              height: 30,
                                              alignment: Alignment.topCenter,
                                              child: Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Text("3. ",
                                                      style: TextStyle(
                                                          color: getColorFromHex('32C8B1'),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400))))),
                                      Expanded(
                                          flex: 9,
                                          child: Container(
                                              child: const Text(
                                                  "Dapatkan penawaran harga terbaik dengan berbelanja menggunakan Simpanan Kamu ",
                                                  style: TextStyle(fontSize: 10))))
                                    ],
                                  ),
                                )
                              ],
                            )))),
              ]))),
    );
  }
}
