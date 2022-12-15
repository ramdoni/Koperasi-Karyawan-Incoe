import 'package:flutter/cupertino.dart';
import '../helpers/session.dart' as session;
import 'package:flutter/material.dart';
import '../helpers/util.dart';

class KirimUangScreen extends StatefulWidget {
  @override
  createState() {
    return KirimUangScreenState();
  }
}

class KirimUangScreenState extends State<KirimUangScreen> {
  final TextEditingController _controllerNominal = TextEditingController();

  var dataTagihan = {};
  String totalSimpananDibayarkan;
  bool isSubmited = false;

  // Map<String, dynamic> _sumberDana;
  List _sumberDana = [];

  @override
  void initState() {
    super.initState();
    _sumberDana.add(1);
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
          title: Text('Kirim Uang', style: TextStyle(color: getColorFromHex('41c8b1'), fontSize: 17)),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
          titleSpacing: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    alignment: Alignment.topLeft,
                    child: const Text("Masukan Nominal", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          height: 40,
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width * 0.63,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            controller: _controllerNominal,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Tanggal lahir harus diisi";
                              }
                              return null;
                            },
                            style: TextStyle(fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                hintText: ""),
                            onTap: () {},
                          )))
                ])),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child:
                          const Text("Pilih Sumber Dana", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                    ),
                    for (int i = 0; i < _sumberDana.length; i++)
                      Row(
                        children: [
                          Expanded(
                              flex: 9,
                              child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(top: 10, bottom: 8),
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: const Text("-- Pilih --",
                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                    // value: _nominalPinjaman,
                                    underline: Container(),
                                    items: ['Simpanan Pokok', 'Simpanan Sukarela', 'Simpanan Lain-lain'].map((item) {
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
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  child: (i == 0
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _sumberDana.add(i);
                                            });
                                          },
                                          icon: Icon(CupertinoIcons.add_circled_solid,
                                              size: 35, color: getColorFromHex('41c8b1')))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _sumberDana.removeAt(i);
                                            });
                                          },
                                          icon: Icon(CupertinoIcons.delete_solid, size: 20, color: Colors.red)))))
                        ],
                      )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(children: [
                  Align(alignment: Alignment.topLeft, child: Container(child: Text("Pilih Tujuan"))),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          height: 40,
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width * 0.63,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            controller: _controllerNominal,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "";
                              }
                              return null;
                            },
                            style: TextStyle(fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                hintText: ""),
                            onTap: () {},
                          )))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 20),
                child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 35.0,
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getColorFromHex("4ec9b2"),
                          ),
                          onPressed: () {},
                          child: (isSubmited
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                              : const Text('Top Up Sekarang', style: TextStyle(color: Colors.white))),
                        ))))
          ],
        )));
  }
}
