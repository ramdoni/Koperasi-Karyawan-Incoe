import 'package:coopzone_application/simpanan/simpanan_add.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;

class SimpananWajibScreen extends StatefulWidget {
  @override
  createState() {
    return SimpananWajibScreenState();
  }
}

class SimpananWajibScreenState extends State<SimpananWajibScreen> {
  int filterTahun, tabActive = 1;
  bool isSubmited = false;

  Widget build(context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: getColorFromHex('32c8b1'),
        elevation: 0,
      ),
      body: Container(
          // padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Stack(children: <Widget>[
            Positioned(
                top: 0,
                child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    color: getColorFromHex('32c8b1'),
                    child: Column(
                      children: [
                        const Center(
                            child: Text("Simpanan Wajib",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700))),
                        Center(
                            child: Text("Rp. " + session.simpananWajib + ",-",
                                style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700))),
                        Container(
                            width: 300,
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Image.asset('icon_transfer.png', height: 50),
                                        Text("Transfer", style: TextStyle(color: Colors.white))
                                      ],
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => SimpananAddScreen()));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 20, left: 20),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'icon_simpanan_topup.png',
                                                height: 40,
                                              ),
                                              Text("Topup", style: TextStyle(color: Colors.white))
                                            ],
                                          ),
                                        ))),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 20, left: 20),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'icon_simpanan_penarikan.png',
                                              height: 40,
                                            ),
                                            const Text("Tarik", style: TextStyle(color: Colors.white))
                                          ],
                                        ))),
                              ],
                            ))
                      ],
                    ))),
            Positioned(
                top: 140,
                child: Container(
                    // height: 200,
                    padding: EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                    child: const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Riwayat Transaksi ",
                                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14))))),
                            Expanded(
                                flex: 5,
                                child: Container(
                                    child: const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Status Simpanan",
                                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)))))
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Text("Filter"),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                        width: 120,
                                        height: 30,
                                        margin: EdgeInsets.only(left: 10, top: 6, bottom: 8),
                                        padding: EdgeInsets.only(left: 10.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3.0),
                                          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                        ),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: const Text("Tahun",
                                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
                                          value: filterTahun,
                                          underline: Container(),
                                          items: [2019, 2020, 2021, 2022].map((item) {
                                            return DropdownMenuItem(
                                              child: Text(item.toString(),
                                                  style: TextStyle(fontWeight: FontWeight.normal)),
                                              value: item,
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              filterTahun = value;
                                            });
                                          },
                                        ))),
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                        width: 150,
                                        height: 30,
                                        margin: EdgeInsets.only(left: 10, top: 5, bottom: 8),
                                        padding: EdgeInsets.only(left: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3.0),
                                          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                        ),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: const Text(" Semua Transaksi ",
                                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
                                          value: filterTahun,
                                          underline: Container(),
                                          items: [2019, 2020, 2021, 2022].map((item) {
                                            return DropdownMenuItem(
                                              child: Text(item.toString(),
                                                  style: TextStyle(fontWeight: FontWeight.normal)),
                                              value: item,
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              filterTahun = value;
                                            });
                                          },
                                        )))
                              ],
                            ))
                      ],
                    )))
          ])),
    );
  }
}
