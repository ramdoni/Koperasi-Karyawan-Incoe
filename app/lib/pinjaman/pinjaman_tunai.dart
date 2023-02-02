import 'dart:developer';

import 'package:coopzone_application/pinjaman/pinjaman_tunai_add.dart';
import 'package:coopzone_application/pinjaman/pinjaman_tunai_bayar.dart';
import 'package:coopzone_application/pinjaman/pinjaman_tunai_tagihan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;

class PinjamanTunaiScreen extends StatefulWidget {
  @override
  createState() {
    return PinjamanTunaiScreenState();
  }
}

class PinjamanTunaiScreenState extends State<PinjamanTunaiScreen> {
  int totalTagihan = 0, filterTahun;
  Map<String, dynamic> dataTagihan = {};
  List riwayat;

  @override
  void initState() {
    super.initState();
    _loadTagihan();
  }

  Future _loadTagihan() async {
    try {
      getData('/pembiayaan/first').then((res) {
        setState(() {
          log(res.data.toString());
          if (res.data['message'] == 'success') {
            dataTagihan = res.data['data'];
            riwayat = res.data['riwayat'];
          } else {
            bottomInfo(context, res.data['message']);
          }
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  Widget build(context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColorFromHex('efefef'), //change your color here
          ),
          title: const Text('Kembali', style: TextStyle(color: Colors.white, fontSize: 17)),
          backgroundColor: getColorFromHex('32c8b1'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 145,
                child: Stack(children: <Widget>[
                  Positioned(
                      top: 0,
                      child: Container(
                          height: 190,
                          width: MediaQuery.of(context).size.width,
                          color: getColorFromHex('32c8b1'),
                          child: Column(
                            children: [
                              const Center(
                                  child: Text("Sisa Angsuran",
                                      style:
                                          TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700))),
                              Center(
                                  child: Text("Rp. " + dataTagihan['sisa_angsuran'].toString() + ",-",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700))),
                              Center(
                                  child: Text("Total Pinjaman Tunai : Rp. " + dataTagihan['total_pinjaman'].toString(),
                                      style: const TextStyle(color: Colors.white, fontSize: 11))),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(builder: (context) => PinjamanTunaiAddScreen()));
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(3.0),
                                            border:
                                                Border.all(color: Colors.white, style: BorderStyle.solid, width: 0.80),
                                          ),
                                          child: const Text("Ajukan Pinjaman",
                                              style: TextStyle(
                                                  color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500)))))
                            ],
                          ))),
                  Positioned(
                      top: 120,
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ))
                ])),
            Container(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            Container(
                                child: const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Jumlah yang harus dibayar",
                                      textAlign: TextAlign.left,
                                    ))),
                            Container(
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        "Rp. " + (dataTagihan != null ? dataTagihan['tagihan'].toString() : '0'),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700)))),
                            Container(
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        (dataTagihan != null
                                            ? "Jatuh tempo pembayaran : " + dataTagihan['bulan'].toString()
                                            : '-'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: getColorFromHex('32c8b1'))))),
                          ],
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: (dataTagihan['tagihan'] != "-"
                                ? ButtonTheme(
                                    minWidth: double.infinity,
                                    height: 30.0,
                                    child: SizedBox(
                                        width: double.infinity,
                                        height: 30.0,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: getColorFromHex("4ec9b2"),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) => PinjamanTunaiBayarScreen()));
                                          },
                                          child:
                                              const Text('Bayar', style: TextStyle(color: Colors.white, fontSize: 12)),
                                        )))
                                : Container(
                                    height: 0,
                                    width: 0,
                                  ))))
                  ],
                )),
            Container(
                padding: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Icon(Icons.paste_outlined, color: getColorFromHex("41c8b1"))),
                    const Expanded(
                        flex: 8,
                        child: Text("Tagihan saya", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) => PinjamanTunaiTagihanScreen()));
                          },
                          child: Icon(
                            CupertinoIcons.chevron_forward,
                            color: getColorFromHex('41c8b1'),
                            size: 25.0,
                          ),
                        ))
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Row(children: [
                        // Expanded(flex: 1, child: Image.asset('icon_file.png')),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              CupertinoIcons.doc_text_fill,
                              color: getColorFromHex('41c8b1'),
                              size: 25.0,
                            )),
                        const Expanded(
                            flex: 9,
                            child:
                                Text("Riwayat Transaksi", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)))
                      ]),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            const Text("Filter"),
                            Container(
                                width: 130,
                                height: 30,
                                margin: EdgeInsets.only(left: 10, top: 6, bottom: 8),
                                padding: EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: const Text(" --- Tahun --- ",
                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                  value: filterTahun,
                                  underline: Container(),
                                  items: [2019, 2020, 2021, 2022].map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                      value: item,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterTahun = value;
                                    });
                                  },
                                )),
                            Container(
                                width: 140,
                                height: 30,
                                margin: EdgeInsets.only(left: 10, top: 5, bottom: 8),
                                padding: EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: const Text(" Semua Transaksi ",
                                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                  value: filterTahun,
                                  underline: Container(),
                                  items: [2019, 2020, 2021, 2022].map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                      value: item,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterTahun = value;
                                    });
                                  },
                                ))
                          ],
                        )),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: riwayat == null ? 0 : riwayat.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Container(
                                height: 50,
                                decoration: const BoxDecoration(color: Colors.white),
                                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 6,
                                        child: Column(children: [
                                          Container(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(riwayat[index]['bulan_name'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400,
                                                          color: getColorFromHex('434343'))))),
                                          Container(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text("Tanggal jatuh tempo  " + riwayat[index]['bulan'],
                                                      style:
                                                          TextStyle(fontSize: 12.0, color: getColorFromHex('434343')))))
                                        ])),
                                    Expanded(
                                        flex: 4,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Rp. " + riwayat[index]['tagihan'] + ",-",
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                            )))
                                  ],
                                )),
                            onTap: () {
                              // Navigator.of(context).push(
                              //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                            },
                          );
                        })
                  ],
                ))
          ]),
        ));
  }
}
