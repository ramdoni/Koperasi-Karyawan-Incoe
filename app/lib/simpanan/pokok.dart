import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;

class SimpananPokokScreen extends StatefulWidget {
  @override
  createState() {
    return SimpananPokokScreenState();
  }
}

class NominalPinjaman {
  const NominalPinjaman(this.id, this.name);
  final String name;
  final int id;
}

class SimpananPokokScreenState extends State<SimpananPokokScreen> {
  final TextEditingController _controllerPaymentDate = TextEditingController();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  List<NominalPinjaman> nominalPinjaman = <NominalPinjaman>[
    const NominalPinjaman(1, '500.000'),
    const NominalPinjaman(2, '1.000.000'),
    const NominalPinjaman(3, '1.500.000'),
    const NominalPinjaman(4, '2.000.000'),
    const NominalPinjaman(5, '2.500.000'),
  ];
  int filterTahun;
  bool isSubmited = false;

  Widget build(context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        // title: const Text('Ajukan Pinjaman', style: TextStyle(color: Colors.black)),
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
                            child: Text("Simpanan Pokok",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700))),
                        Center(
                            child: Text("Rp. " + session.simpananPokok + ",-",
                                style:
                                    const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700))),
                        Container(
                            width: 320,
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        child: Column(
                                  children: [
                                    Image.asset('icon_transfer.png'),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: const Text("Transfer",
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
                                  ],
                                ))),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 20, left: 20),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'icon_topup.png',
                                        height: 40,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: const Text("Topup",
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
                                    ],
                                  ),
                                )),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(right: 20, left: 20),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'icon_tarik.png',
                                              height: 40,
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text("Tarik",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
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
                        Container(
                            child: const Align(
                                alignment: Alignment.topLeft,
                                child: Text("Riwayat Transaksi : ",
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)))),
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
                            ))
                      ],
                    )))
          ])),
    );
  }
}
