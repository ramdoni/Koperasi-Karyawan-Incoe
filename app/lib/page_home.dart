import 'package:flutter/material.dart';

import 'pinjaman/pinjaman_add.dart';
import 'simpanan/simpanan_add.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration:
                      const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text("Simpanan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(children: [
                              Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.list_alt_rounded, color: Colors.green[600])),
                              Text("Pokok")
                            ]))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(children: [
                              Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.list_alt_rounded, color: Colors.green[600])),
                              Text("Wajib")
                            ]))),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(children: [
                              Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.list_alt_rounded, color: Colors.green[600])),
                              Text("Sukarela")
                            ]))),
                  ]))),
          Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 15),
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Icon(Icons.phone_android, color: Colors.blue[800])),
                              Text('Pulsa')
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 8), child: Icon(Icons.public, color: Colors.green)),
                              Text('Paket Data')
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Icon(Icons.electric_bolt, color: Colors.yellow[800])),
                              Text('PLN')
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Icon(Icons.list_alt_rounded, color: Colors.green[800])),
                              Text('Pajak PBB')
                            ],
                          ))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Icon(Icons.pedal_bike_sharp, color: Colors.red[800])),
                                  Text('STNK')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Icon(Icons.note, color: Colors.orange)),
                                  Text('BPKB')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Icon(Icons.motorcycle, color: Colors.blue[900])),
                                  Text('SIM')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Icon(Icons.tv_outlined, color: Colors.red[200])),
                                  const Text(
                                    'Internet & TV Kabel',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ))
                            ],
                          )),
                    ],
                  ))),
          Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Container(
                    width: 150,
                    height: 45,
                    margin: EdgeInsets.all(10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xffF18265),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PinjamanAddScreen()));
                      },
                      child: const Text(
                        "Ajukan Pinjaman",
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 5,
                  child: Container(
                    width: 150,
                    height: 45,
                    margin: EdgeInsets.all(10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 91, 87, 194),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SimpananAddScreen()));
                      },
                      child: const Text(
                        "Bayar Simpanan",
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
