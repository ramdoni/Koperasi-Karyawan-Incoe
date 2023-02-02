import 'dart:developer';
import 'dart:io';
import 'package:coopzone_application/helpers/bottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../helpers/util.dart';

class ScanProductScreen extends StatefulWidget {
  @override
  createState() {
    return ScanProductScreenState();
  }
}

class ScanProductScreenState extends State<ScanProductScreen> with TickerProviderStateMixin {
  Barcode resultBarcode;
  QRViewController controller;
  bool showBarcode = true, isLoading = false, isSubmit = false;
  Map data = {};
  String no;

  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerQty = TextEditingController();
  final TextEditingController _controllerHpp = TextEditingController();
  final TextEditingController _controllerHargaJual = TextEditingController();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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

                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
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

  Future _submit() async {
    try {
      if (no == "") {
        bottomInfo(context, "No Transaksi tidak ditemukan silahkan di scan ulang");
        return false;
      }

      if (_controllerNama.text == "") {
        bottomInfo(context, "Nominal pembayaran harus diisi");
        return false;
      }
      if (_controllerQty.text == "") {
        bottomInfo(context, "Qty pembayaran harus diisi");
        return false;
      }

      setState(() {
        isSubmit = true;
      });

      sendData('/product/store', {
        'no': no,
        'nama': _controllerNama.text,
        'qty': _controllerQty.text,
        'harga': _controllerHpp.text,
        'harga_jual': _controllerHargaJual.text
      }).then((res) {
        log(res.data.toString());
        setState(() {
          if (res.data['status'] == 'success') {
            displayDialog(context, 'Berhasil', 'Product berhasil disimpan');
          } else {
            bottomInfo(context, res.data['data']);
          }

          isSubmit = false;
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  Future _loadData() async {
    try {
      sendData('/product/scan', {'no': no}).then((res) {
        log(res.data.toString());
        setState(() {
          if (res.data['status'] == 'success') {
            data = res.data['data'];
            _controllerNama.value = TextEditingValue(text: data['nama']);
            _controllerQty.value = TextEditingValue(text: data['qty'].toString());
            _controllerHargaJual.value = TextEditingValue(text: data['harga_jual'].toString());
            _controllerHpp.value = TextEditingValue(text: data['harga'].toString());
          } else {
            bottomInfo(context, res.data['message']);
          }
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (showBarcode) {
      if (Platform.isAndroid) {
        controller.pauseCamera();
      } else if (Platform.isIOS) {
        controller.resumeCamera();
      }
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        resultBarcode = scanData;
        no = resultBarcode.code;
        showBarcode = false;
        _loadData();
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  Widget build(context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    return Scaffold(
        bottomNavigationBar: bottomNavBar(tabActive: 0),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColorFromHex('08CFB6'), //change your color here
          ),
          titleSpacing: 0,
          title: Text(
            "Scan Product",
            style: TextStyle(color: getColorFromHex('08CFB6')),
          ),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
        ),
        backgroundColor: getColorFromHex('EFEFEF'),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: [
            (showBarcode
                ? Container(
                    height: 300,
                    child: QRView(
                      key: qrKey,
                      overlay: QrScannerOverlayShape(
                          borderColor: Colors.red,
                          borderRadius: 10,
                          borderLength: 30,
                          borderWidth: 10,
                          cutOutSize: scanArea),
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  )
                : Column(children: [
                    InkWell(
                        child: Container(
                            alignment: Alignment.center, child: Icon(CupertinoIcons.qrcode_viewfinder, size: 100)),
                        onTap: () {
                          setState(() {
                            showBarcode = true;
                          });
                        }),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Scan Ulang", style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1.5, color: getColorFromHex('eeeeee')),
                                ),
                              ),
                              padding: EdgeInsets.only(bottom: 15),
                              margin: EdgeInsets.only(top: 10, bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(flex: 5, child: Text("No Produk")),
                                  Expanded(
                                      flex: 5,
                                      child: Text(no.toString(),
                                          textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600)))
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.topLeft,
                                child: const Text("Nama Produk")),
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              // margin: EdgeInsets.only(bottom: 15),
                              child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    maxLines: null,
                                    controller: _controllerNama,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Nama Produk harus isi";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(fontWeight: FontWeight.normal),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                        hintText: ""),
                                    onTap: () {},
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 10), alignment: Alignment.topLeft, child: Text("QTY")),
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLines: null,
                                    controller: _controllerQty,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Qty harus isi";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(fontWeight: FontWeight.normal),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                        hintText: "0"),
                                    onTap: () {},
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 10), alignment: Alignment.topLeft, child: Text("HPP")),
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLines: null,
                                    controller: _controllerHpp,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "HPP harus isi";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(fontWeight: FontWeight.normal),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                        hintText: "0"),
                                    onTap: () {},
                                  )),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.topLeft,
                                child: Text("Harga Jual")),
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Container(
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLines: null,
                                    controller: _controllerHargaJual,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "harga Jual harus isi";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(fontWeight: FontWeight.normal),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                        hintText: "0"),
                                    onTap: () {},
                                  )),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1.5, color: getColorFromHex('eeeeee')),
                                  ),
                                ),
                                padding: EdgeInsets.only(top: 10),
                                margin: const EdgeInsets.only(top: 20),
                                child: ButtonTheme(
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 40.0,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: getColorFromHex("4ec9b2"),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(32.0),
                                            ),
                                          ),
                                          onPressed: _submit,
                                          child: (isSubmit
                                              ? const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ))
                                              : const Text('Simpan',
                                                  style: TextStyle(color: Colors.white, fontSize: 14))),
                                        ))))
                          ],
                        ))
                  ])),
          ],
        ))));
  }
}
