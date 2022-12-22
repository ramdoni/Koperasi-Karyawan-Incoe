import 'dart:developer';

import 'package:flutter/material.dart';
import '../helpers/util.dart';
import 'package:intl/intl.dart';

import 'lainnya.dart';
import 'sukarela.dart';

class SimpananAddScreen extends StatefulWidget {
  @override
  createState() {
    return SimpananAddScreenState();
  }
}

class SimpananAddScreenState extends State<SimpananAddScreen> {
  var dataTagihan = {};
  final TextEditingController _controllerAmount = TextEditingController();
  var f = NumberFormat("###,###.0#", "en_US");
  String jenisSimpanan;
  bool isSubmited = false, showTransferBank = false;
  int amount, totalDibayarkan;
  List listBank;

  @override
  void initState() {
    super.initState();
    _loadBank();
  }

  Future _loadBank() async {
    try {
      getData('/get-bank').then((res) {
        log(res.toString());
        setState(() {
          if (res.data['message'] == 'success') {
            listBank = res.data['data'];
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

  void calculate_(val) {
    setState(() {
      amount = val == "" ? 0 : int.parse(val);
      totalDibayarkan = amount != 0 ? (amount + 1000) : 0;
    });
  }

  void modalEmoney(context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
            return Padding(
                padding: EdgeInsets.all(10), //MediaQuery.of(context).viewInsets,
                child: SingleChildScrollView(
                    child: Container(
                  // padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 14.0),
                          child: Text("E-Money", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))),
                      Container(child: Text("Fitur masih dalam pengembangan.")),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 15),
                        child: ButtonTheme(
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
                                    mystate(() {});
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Oke', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ))),
                      ),
                    ],
                  ),
                )));
          });
        },
      );

  void modalTransfer(context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
            return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(bottom: 14.0),
                          child: Text("Transfer Bank", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))),
                      Container(
                          margin: EdgeInsets.only(top: 20, left: 10),
                          child: const Text(
                              "Silahkan melakukan transfer ke salah satu rekening dibawah ini kemudia upload bukti pembayaran",
                              style: TextStyle(fontSize: 12))),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 15),
                        child: ButtonTheme(
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
                                    mystate(() {});
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ))),
                      ),
                    ],
                  ),
                )));
          });
        },
      );

  void modalMerchant(context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
            return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 14.0),
                          child: Text("Merchant / Mitra", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))),
                      Container(child: Text("Fitur masih dalam pengembangan.")),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 15),
                        child: ButtonTheme(
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
                                    mystate(() {});
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Oke', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ))),
                      ),
                    ],
                  ),
                )));
          });
        },
      );

  void displayDialog(context, title, message) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              actions: [
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 50.0,
                  child: SizedBox(
                      height: 30.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getColorFromHex("4ec9b2"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);

                            if (jenisSimpanan == 'Simpanan Sukarela') {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => SimpananSukarelaScreen()));
                            }
                            if (jenisSimpanan == 'Simpanan Lain-lain') {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => SimpananLainnyaScreen()));
                            }
                            setState(() {
                              amount = 0;
                              jenisSimpanan = null;
                            });
                          },
                          child: const Text("Oke"))),
                )
              ],
              title: Row(children: [
                Container(
                    margin: const EdgeInsets.only(right: 10.0), child: Icon(Icons.info, color: Colors.amber[800])),
                Text(title, style: TextStyle(fontSize: 16))
              ]),
              content: Text(message, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14))));
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColorFromHex('41c8b1'), //change your color here
          ),
          title: Text('Top Up Simpanan', style: TextStyle(color: getColorFromHex('41c8b1'), fontSize: 17)),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
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
                        height: 40,
                        margin: EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: getColorFromHex('CCCCCC'), style: BorderStyle.solid, width: 0.80),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  margin: EdgeInsets.only(top: 2),
                                  padding: EdgeInsets.all(5),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: const Text(" --- Jenis Simpanan --- ",
                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                    value: jenisSimpanan,
                                    underline: Container(),
                                    items: ['Simpanan Sukarela', 'Simpanan Lain-lain'].map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        jenisSimpanan = value;
                                      });
                                    },
                                  ),
                                )),
                            Expanded(
                                flex: 5,
                                child: Container(
                                    alignment: Alignment.topCenter,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      maxLines: null,
                                      controller: _controllerAmount,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Nominal harus diisi";
                                        }
                                        return null;
                                      },
                                      style: TextStyle(fontWeight: FontWeight.normal),
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          // border: OutlineInputBorder(),
                                          // hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                          contentPadding: EdgeInsets.only(top: 0, bottom: 10, right: 5, left: 10),
                                          hintText: "Rp. ",
                                          hintStyle: TextStyle(fontSize: 12),
                                          labelStyle: TextStyle(fontSize: 12)),
                                      onChanged: calculate_,
                                    )))
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: getColorFromHex('ccf1eb'),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                        child: Text("Biaya Top Up Rp. 1.000,-",
                                            style: TextStyle(fontSize: 12, color: getColorFromHex('33c8b1')))))),
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
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            const Expanded(
                                flex: 6,
                                child: Text("Total simpanan yang harus dibayarkan", style: TextStyle(fontSize: 12))),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: getColorFromHex('e7f4f2'),
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: getColorFromHex('32c8b1'), style: BorderStyle.solid, width: 0.80),
                                  ),
                                  child: Text("Rp." + (totalDibayarkan == null ? '0' : f.format(totalDibayarkan)),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: getColorFromHex('32c8b1'),
                                          fontWeight: FontWeight.w500))),
                            )
                          ],
                        ))
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text("Metode Pembayaran", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                  ),
                  InkWell(
                    onTap: () {
                      modalEmoney(context);
                    },
                    child: Container(
                        color: getColorFromHex('efefef'),
                        margin: const EdgeInsets.only(top: 20),
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Image.asset('icon_emoney_grey.png')),
                            const Expanded(flex: 8, child: Text("E-Money"))
                          ],
                        )),
                  ),
                  InkWell(
                      onTap: () {
                        // modalTransfer(context);
                        setState(() {
                          showTransferBank = showTransferBank ? false : true;
                        });
                      },
                      child: Container(
                          color: getColorFromHex('efefef'),
                          margin: const EdgeInsets.only(top: 10),
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Image.asset('icon_transfer_bank_grey.png')),
                              const Expanded(flex: 8, child: Text("Transfer Bank"))
                            ],
                          ))),
                  (showTransferBank
                      ? Container(
                          // margin: EdgeInsets.all(10),
                          child: Column(children: [
                          Container(
                              margin: const EdgeInsets.only(top: 20, left: 10),
                              alignment: Alignment.topLeft,
                              child: const Text("Silahkan melakukan transfer pada rekening dibawah ini",
                                  style: TextStyle(fontSize: 13))),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: listBank == null ? 0 : listBank.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: getColorFromHex('fafafa'),
                                      border: Border(
                                        bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
                                        top: BorderSide(width: 1.5, color: Colors.grey[300]),
                                        left: BorderSide(width: 1.5, color: Colors.grey[300]),
                                        right: BorderSide(width: 1.5, color: Colors.grey[300]),
                                      ),
                                    ),
                                    padding: EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
                                    child: Column(children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text(listBank[index]['bank'],
                                            style: TextStyle(fontWeight: FontWeight.w700)),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(flex: 4, child: Text(listBank[index]['no_rekening'])),
                                          Expanded(flex: 6, child: Text(" a/n " + listBank[index]['owner']))
                                        ],
                                      )
                                    ]));
                              })
                        ]))
                      : Container(
                          height: 0,
                          width: 0,
                        )),
                  InkWell(
                      onTap: () {
                        modalMerchant(context);
                      },
                      child: Container(
                          color: getColorFromHex('efefef'),
                          margin: const EdgeInsets.only(top: 10),
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Image.asset('icon_merchant.png')),
                              const Expanded(flex: 8, child: Text("Merchant / Mitra"))
                            ],
                          )))
                ])),
            Container(
                // padding: EdgeInsets.all(20),
                child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 35.0,
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getColorFromHex("4ec9b2"),
                          ),
                          onPressed: () {
                            if (jenisSimpanan == "" || jenisSimpanan == null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Jenis simpanan harus dipilih"),
                              ));
                              return;
                            }
                            if (amount == "" || amount == 0 || amount == null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Nominal simpanan harus diisi"),
                              ));
                              return;
                            }
                            setState(() {
                              isSubmited = true;
                            });
                            sendData('/simpanan/store', {'jenis_simpanan': jenisSimpanan, 'amount': amount})
                                .then((res) {
                              setState(() {
                                isSubmited = false;
                                log(res.data.toString());
                                if (res.data['message'] == 'success') {
                                  displayDialog(context, 'Success',
                                      "Simpanan berhasil di submit, selanjutanya silahkan melakukan pembayaran ke salah satu rekening kami");
                                }
                              });
                            });
                          },
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
