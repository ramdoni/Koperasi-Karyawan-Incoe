import 'dart:developer';
import 'package:coopzone_application/simpanan/simpanan_add.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;
import '../kirim_uang.dart';

class SimpananLainnyaScreen extends StatefulWidget {
  @override
  createState() {
    return SimpananLainnyaScreenState();
  }
}

class SimpananLainnyaScreenState extends State<SimpananLainnyaScreen> {
  int filterTahun;
  bool isSubmited = false;

  List dataTransaksi;

  bool isLoading = false;
  DateTime date = new DateTime.now();
  @override
  void initState() {
    super.initState();
    _loadTransaksi();
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

  Future _loadTransaksi() async {
    try {
      setState(() {
        isLoading = true;
      });
      getData('/simpanan/lainnya').then((res) {
        log(res.toString());
        setState(() {
          if (res.data['status'] == 'success') {
            dataTransaksi = res.data['data'];
          } else {
            bottomInfo(context, res.data['message']);
          }
          isLoading = false;
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: getColorFromHex('32c8b1'),
        elevation: 0,
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Column(children: [
                Stack(children: <Widget>[
                  Positioned(
                      child: Container(
                          height: 160,
                          width: MediaQuery.of(context).size.width,
                          color: getColorFromHex('32c8b1'),
                          child: Column(
                            children: [
                              const Center(
                                  child: Text("Simpanan Lain-lain",
                                      style:
                                          TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700))),
                              Center(
                                  child: Text("Rp. " + session.simpananSukarela + ",-",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700))),
                              Container(
                                  width: 240,
                                  margin: EdgeInsets.only(top: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(builder: (context) => KirimUangScreen()));
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(bottom: 5),
                                                      child: Image.asset('icon_transfer.png')),
                                                  const Text("Transfer",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white))
                                                ],
                                              ))),
                                      Expanded(
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(builder: (context) => SimpananAddScreen()));
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(bottom: 5),
                                                      child: Image.asset('icon_topup.png')),
                                                  const Text("Topup",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white))
                                                ],
                                              ))),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(bottom: 5), child: Image.asset('icon_tarik.png')),
                                          const Text("Tarik",
                                              style: TextStyle(
                                                  fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))
                                        ],
                                      ))
                                    ],
                                  ))
                            ],
                          ))),
                  Positioned(
                      top: 140,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            height: 0,
                            width: 100,
                          )))
                ]),
                Container(
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.only(top: 0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child:
                              Text('Riwayat Transaksi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700))),
                      Container(
                          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Column(
                            children: [
                              Row(
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
                                            child:
                                                Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
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
                                        items: ['Transaksi IN', 'Transaksi Out'].map((item) {
                                          return DropdownMenuItem(
                                            child:
                                                Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
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
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height - 420,
                                  padding: EdgeInsets.only(top: 10),
                                  child: (isLoading
                                      ? _buildProgressIndicator()
                                      : RefreshIndicator(
                                          onRefresh: _loadTransaksi,
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.all(8),
                                              itemCount: dataTransaksi == null ? 0 : dataTransaksi.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                return InkWell(
                                                  child: Container(
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border(
                                                          bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
                                                        ),
                                                      ),
                                                      padding: const EdgeInsets.only(
                                                          left: 10.0, right: 10.0, top: 15.0, bottom: 0.0),
                                                      margin: const EdgeInsets.only(bottom: 0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                child: Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: (dataTransaksi[index]['status'] == 1
                                                                        ? Icon(Icons.checklist, color: Colors.green)
                                                                        : Icon(Icons.timelapse_sharp,
                                                                            color: Colors.yellow[900])))),
                                                          ),
                                                          Expanded(
                                                              flex: 9,
                                                              child: Column(children: [
                                                                Container(
                                                                    margin: EdgeInsets.only(left: 10),
                                                                    alignment: Alignment.topLeft,
                                                                    child: Text(
                                                                      "Rp. " + dataTransaksi[index]['amount'] + ",-",
                                                                      style: const TextStyle(
                                                                          fontSize: 16, fontWeight: FontWeight.w400),
                                                                    )),
                                                                Container(
                                                                    margin: EdgeInsets.only(left: 10),
                                                                    child: Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Text(dataTransaksi[index]['date'],
                                                                            style: TextStyle(
                                                                                fontSize: 12.0,
                                                                                color: getColorFromHex('999999')))))
                                                              ]))
                                                        ],
                                                      )),
                                                  onTap: () {
                                                    // Navigator.of(context).push(
                                                    //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                                                  },
                                                );
                                              }))))
                            ],
                          )),
                    ])),
              ]),
            ],
          )),
    );
  }
}
