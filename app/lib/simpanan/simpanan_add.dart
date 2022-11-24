import 'package:flutter/cupertino.dart';
import '../helpers/session.dart' as session;
import 'package:flutter/material.dart';
import '../helpers/util.dart';

class SimpananAddScreen extends StatefulWidget {
  @override
  createState() {
    return SimpananAddScreenState();
  }
}

class SimpananAddScreenState extends State<SimpananAddScreen> {
  var dataTagihan = {};

  @override
  void initState() {
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
    _loadTagihan();
  }

  Future _loadTagihan() async {
    try {
      getData('/tagihan/first').then((res) {
        setState(() {
          if (res.data['message'] == 'success') {
            dataTagihan = res.data['data'];
          } else {
            bottomInfo(context, res.data['message']);
          }
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 15, bottom: 8),
      child: Center(
        child: Opacity(
          opacity: 1.0,
          child: Column(children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(top: 10.0), child: const Text("Please wait ..."))
          ]),
        ),
      ),
    );
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColorFromHex('41c8b1'), //change your color here
          ),
          title: Text('Tagihan Saya', style: TextStyle(color: getColorFromHex('41c8b1'), fontSize: 17)),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text("Pilih jenis simpanan yang akan kamu bayarkan",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                    ),
                    Container(
                        child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Container(
                                margin: EdgeInsets.only(top: 6),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: getColorFromHex('32C8B1'), style: BorderStyle.solid, width: 0.80),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("Simpanan Pokok",
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('32C8B1')))),
                                    Expanded(
                                        child: Text("Rp. " + session.simpananPokok,
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('CCCCCC'))))
                                  ],
                                ))),
                        Expanded(
                          flex: 3,
                          child: Container(
                              margin: EdgeInsets.only(left: 5, top: 10, bottom: 8),
                              padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                              ),
                              height: 30,
                              child: DropdownButton(
                                isExpanded: true,
                                hint:
                                    const Text("Pilih ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                // value: _nominalPinjaman,
                                underline: Container(),
                                items: [
                                  '1 Bulan',
                                  '2 Bulan',
                                  '3 Bulan',
                                  '4 Bulan',
                                  '5 Bulan',
                                  '6 Bulan',
                                  '7 Bulan',
                                  '8 Bulan',
                                  '9 Bulan',
                                  '10 Bulan',
                                  '11 Bulan',
                                  '12 Bulan'
                                ].map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                    value: item,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    // _nominalPinjaman = value;
                                  });
                                },
                              )),
                        )
                      ],
                    )),
                    Container(
                        child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Container(
                                margin: EdgeInsets.only(top: 6),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: getColorFromHex('32C8B1'), style: BorderStyle.solid, width: 0.80),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("Simpanan Wajib",
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('32C8B1')))),
                                    Expanded(
                                        child: Text("Rp. " + session.simpananWajib,
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('CCCCCC'))))
                                  ],
                                ))),
                        Expanded(
                          flex: 3,
                          child: Container(
                              margin: EdgeInsets.only(left: 5, top: 10, bottom: 8),
                              padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                              ),
                              height: 30,
                              child: DropdownButton(
                                isExpanded: true,
                                hint:
                                    const Text("Pilih ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                // value: _nominalPinjaman,
                                underline: Container(),
                                items: [
                                  '1 Bulan',
                                  '2 Bulan',
                                  '3 Bulan',
                                  '4 Bulan',
                                  '5 Bulan',
                                  '6 Bulan',
                                  '7 Bulan',
                                  '8 Bulan',
                                  '9 Bulan',
                                  '10 Bulan',
                                  '11 Bulan',
                                  '12 Bulan'
                                ].map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                    value: item,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    // _nominalPinjaman = value;
                                  });
                                },
                              )),
                        )
                      ],
                    )),
                    Container(
                        child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Container(
                                margin: EdgeInsets.only(top: 6),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: getColorFromHex('CCCCCC'), style: BorderStyle.solid, width: 0.80),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("Simpanan Sukarela",
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('666666')))),
                                    Expanded(
                                        child: Text("Rp. " + session.simpananSukarela,
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('666666'))))
                                  ],
                                ))),
                        Expanded(
                            flex: 3,
                            child: Container(
                              width: 0,
                              height: 0,
                            ))
                      ],
                    )),
                    Container(
                        child: Row(
                      children: [
                        Expanded(
                            flex: 7,
                            child: Container(
                                margin: EdgeInsets.only(top: 6),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: getColorFromHex('CCCCCC'), style: BorderStyle.solid, width: 0.80),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("Simpanan Lain-lain",
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('666666')))),
                                    Expanded(
                                        child: Text("Rp. " + session.simpananLainlain,
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('666666'))))
                                  ],
                                ))),
                        Expanded(
                            flex: 3,
                            child: Container(
                              width: 0,
                              height: 0,
                            ))
                      ],
                    )),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: getColorFromHex('ccf1eb'),
                                    ),
                                    child: Text("Biaya Top Up Rp. 1.000,-",
                                        style: TextStyle(fontSize: 12, color: getColorFromHex('33c8b1'))))),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: 0,
                                  height: 0,
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  width: 0,
                                  height: 0,
                                ))
                          ],
                        )),
                  ],
                ))
          ],
        ));
  }
}
