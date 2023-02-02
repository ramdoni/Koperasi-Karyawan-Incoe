import 'dart:developer';
import 'package:coopzone_application/belanja/riwayat.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;

class ListrikTokenScreen extends StatefulWidget {
  @override
  createState() {
    return ListrikTokenScreenState();
  }
}

class ListrikTokenScreenState extends State<ListrikTokenScreen> with TickerProviderStateMixin {
  bool isLoading = false;
  TabController controller;
  final TextEditingController _controllerNo = TextEditingController(), _controllerNoTagihan = TextEditingController();

  List dataToken;
  Map detailTagihan, detailTagihanListrik;
  String kodeProduk, _msgErrorTagihan = "", refId;
  int metodePembayaran, metodePembayaranTagihan;
  @override
  void initState() {
    super.initState();
    _loadToken();
    controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
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

  Future _loadToken() async {
    try {
      setState(() {
        isLoading = true;
      });
      getData('/pln/get-token').then((res) {
        setState(() {
          log(res.data['data'].toString());
          if (res.data['message'] == 'success') {
            dataToken = res.data['data'];
          }
          isLoading = false;
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  Future _cekToken() async {
    try {
      sendData('/pln/cek-tagihan-token', {'no': _controllerNo.text, 'kode_produk': kodeProduk}).then((res) {
        setState(() {
          log(res.data['data'].toString());
          if (res.data['message'] == 'success') {
            detailTagihan = res.data['data'];
          }
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

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

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => BelanjaRiwayatScreen()));
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

  List<Container> _buildListToken(int count) => List.generate(
      count,
      (i) => Container(
          padding: EdgeInsets.only(top: 10),
          height: 10,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.5,
                color: dataToken[i]['kode_produk'] == kodeProduk ? getColorFromHex("4ec9b2") : Colors.grey[200]),
          ),
          child: InkWell(
            child: Column(
              children: [
                Text(dataToken[i]['keterangan'] ?? '-',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: dataToken[i]['kode_produk'] == kodeProduk ? getColorFromHex("4ec9b2") : Colors.black)),
                Text('Bayar ' + dataToken[i]['harga'] ?? '-',
                    style: TextStyle(
                        fontSize: 10,
                        color: dataToken[i]['kode_produk'] == kodeProduk ? getColorFromHex("4ec9b2") : Colors.black))
              ],
            ),
            onTap: () {
              if (_controllerNo.text != "") {
                setState(() {
                  kodeProduk = dataToken[i]['kode_produk'];
                });
                _cekToken();
              }
            },
          )));

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
          bottom: TabBar(
            labelColor: getColorFromHex('41c8b1'),
            indicatorColor: getColorFromHex('41c8b1'),
            controller: controller,
            tabs: const <Widget>[
              Tab(
                text: "Token Listrik",
              ),
              Tab(
                text: "Tagihan PLN",
              )
            ],
          ),
        ),
        body: TabBarView(controller: controller, children: <Widget>[
          SingleChildScrollView(
              child: Column(children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      child: const Text("Masukan No Pelanggan",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                    ),
                    Container(
                        child: Container(
                            child: TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLines: null,
                      controller: _controllerNo,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "No Pelanggan harus isi";
                        }
                        return null;
                      },
                      style: TextStyle(fontWeight: FontWeight.normal),
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                          contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                          hintText: "No Pelanggan"),
                      onTap: () {},
                    ))),
                    Container(
                        // height: MediaQuery.of(context).size.height - 320,
                        padding: EdgeInsets.only(top: 10),
                        child: (isLoading
                            ? _buildProgressIndicator()
                            : RefreshIndicator(
                                onRefresh: _loadToken,
                                child: GridView.count(
                                    primary: false,
                                    shrinkWrap: true,
                                    childAspectRatio: (1 / .5),
                                    padding: const EdgeInsets.all(5),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3,
                                    children: _buildListToken(dataToken.length))))),
                  ],
                )),
            (detailTagihan != null
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child: Text("Nominal", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihan['keterangan'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child: Text("Nama Pelanggan",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihan['name'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child: Text("Segement Power",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihan['segment_power'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child: Text("Biaya Admin PLN",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihan['biaya_admin'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child: Text("Total", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihan['harga'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w800, color: getColorFromHex("4ec9b2"))))
                          ]),
                        ),
                      ],
                    ))
                : Container(height: 0, width: 0)),
            Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: const Text("Metode Pembayaran", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      margin: const EdgeInsets.only(bottom: 5, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1.5, color: metodePembayaran == 4 ? getColorFromHex('#32C8B1') : Colors.grey[200]),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              metodePembayaran = 4;
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Image.asset('icon_wallet.png', height: 30)),
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                      child: Text("Simpanan Ku",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: (metodePembayaran == 4
                                                  ? getColorFromHex('#32C8B1')
                                                  : Colors.black))))),
                              Expanded(
                                  flex: 2,
                                  child: Text(session.simpananKu,
                                      style: TextStyle(fontSize: 12, color: getColorFromHex('CCCCCC')))),
                            ],
                          ))),
                  Container(
                      margin: EdgeInsets.only(bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1.5, color: metodePembayaran == 3 ? getColorFromHex('#32C8B1') : Colors.grey[200]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              metodePembayaran = 3;
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Image.asset('icon_wallet.png', height: 30)),
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                      child: Text("Bayar Nanti",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: (metodePembayaran == 3
                                                  ? getColorFromHex('#32C8B1')
                                                  : Colors.black))))),
                              Expanded(
                                  flex: 2,
                                  child: Text(session.sisaPlafond,
                                      style: TextStyle(fontSize: 12, color: getColorFromHex('CCCCCC')))),
                            ],
                          )))
                ])),
            Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width * 0.95,
                child: ButtonTheme(
                    height: 40.0,
                    child: SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getColorFromHex("4ec9b2"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          // ignore: void_checks
                          onPressed: () {
                            if (_controllerNo.text == "") {
                              bottomInfo(context, "No Telepon harus diisi");
                              return false;
                            }

                            // ignore: unrelated_type_equality_checks
                            if (metodePembayaran == "") {
                              bottomInfo(context, "Metode Pembayaran harus dipilih");
                              return false;
                            }
                            if (kodeProduk == "") {
                              bottomInfo(context, "Product harus dipilih");
                              return false;
                            }

                            sendData('/pln/transaction-token', {
                              'no': _controllerNo.text,
                              'product_code': kodeProduk,
                              'metode_pembayaran': metodePembayaran
                            }).then((response) {
                              if (response.data['message'] == 'success') {
                                displayDialog(context, 'Info', "Transaksi anda berhasil di submit, silakan menunggu.");
                              }
                            });
                          },
                          child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 14)),
                        ))))
          ])),
          SingleChildScrollView(
              child: Container(
                  // padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
            Container(
              color: Colors.white,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
              child: const Text("Masukan No Pelanggan", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ),
            Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                    child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  controller: _controllerNoTagihan,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "No Pelanggan harus isi";
                    }
                    return null;
                  },
                  style: TextStyle(fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                      hintText: "No Pelanggan"),
                  onTap: () {},
                  onChanged: (str) {
                    setState(() {
                      detailTagihanListrik = null;
                    });
                  },
                ))),
            (_msgErrorTagihan != ""
                ? Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(_msgErrorTagihan, style: TextStyle(color: Colors.red, fontSize: 12)))
                : Container(
                    height: 0,
                    width: 0,
                  )),
            (detailTagihanListrik != null
                ? Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child:
                                    Text("No Pelanggan", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihanListrik['no'].toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child: Text("Nama Pelanggan",
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihanListrik['name'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
                            ),
                          ),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child:
                                    Text("Daya / Tarif", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(
                                    detailTagihanListrik['daya'].toString() +
                                        ' / ' +
                                        detailTagihanListrik['tarif'].toString(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
                          ]),
                        ),
                        for (var keyDetail = 0; keyDetail < detailTagihanListrik['detail'].length; keyDetail++)
                          Container(
                              padding: EdgeInsets.only(left: 30),
                              child: Column(children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10, top: 10),
                                  child: Row(children: [
                                    const Expanded(
                                      flex: 5,
                                      child: Text("Periode",
                                          textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600)),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Text(detailTagihanListrik['detail'][keyDetail]['periode'],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                    )
                                  ]),
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(children: [
                                      const Expanded(
                                        flex: 5,
                                        child: Text("Tagihan",
                                            textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600)),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(detailTagihanListrik['detail'][keyDetail]['tagihan'],
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                      )
                                    ])),
                                Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(children: [
                                      const Expanded(
                                        flex: 5,
                                        child: Text("Admin",
                                            textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600)),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(detailTagihanListrik['detail'][keyDetail]['admin'],
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                      )
                                    ])),
                                Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(children: [
                                      const Expanded(
                                        flex: 5,
                                        child: Text("Denda",
                                            textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600)),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(detailTagihanListrik['detail'][keyDetail]['denda'],
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                      )
                                    ]))
                              ])),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.5, color: Colors.grey[300]),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child:
                                    Text("Biaya Admin", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihanListrik['admin'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                          child: Row(children: [
                            const Expanded(
                                flex: 5,
                                child: Text("Total", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
                            Expanded(
                                flex: 5,
                                child: Text(detailTagihanListrik['price'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w800, color: getColorFromHex("4ec9b2"))))
                          ]),
                        ),
                      ],
                    ))
                : Container(height: 0, width: 0)),
            Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: const Text("Metode Pembayaran", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      margin: const EdgeInsets.only(bottom: 5, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1.5,
                            color: metodePembayaranTagihan == 4 ? getColorFromHex('#32C8B1') : Colors.grey[200]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              metodePembayaranTagihan = 4;
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Image.asset('icon_wallet.png', height: 30)),
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                      child: Text("Co-Pay",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: (metodePembayaranTagihan == 4
                                                  ? getColorFromHex('#32C8B1')
                                                  : Colors.black))))),
                              Expanded(
                                  flex: 2,
                                  child: Text(session.simpananKu,
                                      style: TextStyle(fontSize: 12, color: getColorFromHex('CCCCCC')))),
                            ],
                          ))),
                  Container(
                      margin: EdgeInsets.only(bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1.5,
                            color: metodePembayaranTagihan == 3 ? getColorFromHex('#32C8B1') : Colors.grey[200]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              metodePembayaranTagihan = 3;
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Image.asset('icon_wallet.png', height: 30)),
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                      child: Text("Bayar Nanti",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: (metodePembayaranTagihan == 3
                                                  ? getColorFromHex('#32C8B1')
                                                  : Colors.black))))),
                              Expanded(
                                  flex: 2,
                                  child: Text(session.sisaPlafond,
                                      style: TextStyle(fontSize: 12, color: getColorFromHex('CCCCCC')))),
                            ],
                          )))
                ])),
            (detailTagihanListrik == null
                ? Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ButtonTheme(
                        height: 40.0,
                        child: SizedBox(
                            width: double.infinity,
                            height: 40.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: getColorFromHex("4ec9b2"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              // ignore: void_checks
                              onPressed: () {
                                if (_controllerNoTagihan.text == "") {
                                  bottomInfo(context, "No Pelanggan harus diisi");
                                  return false;
                                }
                                setState(() {
                                  _msgErrorTagihan = '';
                                  detailTagihanListrik = null;
                                });
                                sendData('/pln/cek-tagihan', {'no': _controllerNoTagihan.text}).then((response) {
                                  log(response.data.toString());
                                  if (response.data['status'] == 'success') {
                                    setState(() {
                                      detailTagihanListrik = response.data['response'];
                                      refId = response.data['ref_id'].toString();
                                    });
                                  } else {
                                    setState(() {
                                      _msgErrorTagihan = response.data['message'];
                                    });
                                  }
                                });
                              },
                              child: Text('Cek Tagihan', style: TextStyle(color: Colors.white)),
                            ))))
                : Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ButtonTheme(
                        height: 40.0,
                        child: SizedBox(
                            width: double.infinity,
                            height: 40.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: getColorFromHex("4ec9b2"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              // ignore: void_checks
                              onPressed: () {
                                if (_controllerNoTagihan.text == "") {
                                  bottomInfo(context, "No Pelanggan harus diisi");
                                  return false;
                                }
                                // ignore: unrelated_type_equality_checks
                                if (metodePembayaranTagihan == "") {
                                  bottomInfo(context, "Metode Pembayaran harus diisi");
                                  return false;
                                }

                                sendData('/pln/transaction', {
                                  'no': _controllerNoTagihan.text,
                                  'metode_pembayaran': metodePembayaranTagihan,
                                  'ref_id': refId
                                }).then((response) {
                                  log(response.data.toString());

                                  if (response.data['status'] == 'success') {
                                    displayDialog(
                                        context, 'Info', "Transaksi anda berhasil di submit, silakan menunggu.");
                                  }
                                });
                              },
                              child: const Text('Bayar Tagihan', style: TextStyle(color: Colors.white)),
                            )))))
          ])))
        ]));
  }
}
