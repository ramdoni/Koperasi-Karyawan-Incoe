import 'dart:developer';
import 'package:contacts_service/contacts_service.dart';
import 'package:coopzone_application/belanja/riwayat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import 'package:permission_handler/permission_handler.dart';
import '../helpers/session.dart' as session;

class PulsaScreen extends StatefulWidget {
  @override
  createState() {
    return PulsaScreenState();
  }
}

class PulsaScreenState extends State<PulsaScreen> {
  bool isLoading = false;
  final TextEditingController _controllerNo = TextEditingController();
  Contact _contact;
  List dataPulsa, dataPaketdata;
  String productCode;
  int metodePembayaran;
  @override
  void initState() {
    super.initState();
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

  Future _cekPulsa() async {
    try {
      setState(() {
        isLoading = true;
      });
      int noLength = _controllerNo.text.length;
      if (noLength > 4) {
        sendData('/pulsa/cek-prefix', {'no': _controllerNo.text.toString()}).then((res) {
          setState(() {
            log(res.data.toString());
            if (res.data['message'] == 'success') {
              dataPulsa = res.data['data']['data_pulsa'];
              dataPaketdata = res.data['data']['data_paketdata'];
            } else {
              bottomInfo(context, res.data['message']);
            }
            isLoading = false;
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
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

  Future<void> _openContact() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      try {
        final Contact contact = await ContactsService.openDeviceContactPicker();
        setState(() {
          _contact = contact;
          for (var i in _contact.phones) {
            _controllerNo.text = i.value;
          }
        });
        _cekPulsa();
      } catch (e) {}
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar = SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColorFromHex('41c8b1'), //change your color here
          ),
          title: Text('Pulsa', style: TextStyle(color: getColorFromHex('41c8b1'), fontSize: 17)),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      child:
                          const Text("Masukan No Telepon", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
                          Expanded(
                              flex: 9,
                              child: Container(
                                  child: TextFormField(
                                keyboardType: TextInputType.phone,
                                maxLines: null,
                                controller: _controllerNo,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "No Telepon harus isi";
                                  }
                                  return null;
                                },
                                style: TextStyle(fontWeight: FontWeight.normal),
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                    contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                    hintText: "Contoh : 08777534543"),
                                onTap: () {},
                                onChanged: (val) {
                                  _cekPulsa();
                                },
                              ))),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    _openContact();
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 20, left: 10),
                                      child: Icon(Icons.contacts, size: 30, color: getColorFromHex('41c8b1')))))
                        ])),
                  ],
                )),
            DefaultTabController(
                length: 2, // length of tabs
                initialIndex: 0,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  Container(
                    child: TabBar(
                      labelColor: getColorFromHex('32c8b1'),
                      unselectedLabelColor: Colors.black,
                      indicatorColor: getColorFromHex('32c8b1'),
                      tabs: [Tab(text: 'Pulsa'), Tab(text: 'Paket Data')],
                    ),
                  ),
                  Container(
                      height: 300, //height of TabBarView
                      child: TabBarView(children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height - 320,
                            padding: EdgeInsets.only(top: 10),
                            child: (isLoading
                                ? _buildProgressIndicator()
                                : RefreshIndicator(
                                    onRefresh: _cekPulsa,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(8),
                                        itemCount: dataPulsa == null ? 0 : dataPulsa.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return InkWell(
                                            child: Container(
                                                alignment: Alignment.topLeft,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 1.5,
                                                        color: productCode == dataPulsa[index]['kode_produk']
                                                            ? getColorFromHex('#32C8B1')
                                                            : Colors.grey[100]),
                                                    top: BorderSide(
                                                        width: 1.5,
                                                        color: productCode == dataPulsa[index]['kode_produk']
                                                            ? getColorFromHex('#32C8B1')
                                                            : Colors.grey[100]),
                                                    left: BorderSide(
                                                        width: 1.5,
                                                        color: productCode == dataPulsa[index]['kode_produk']
                                                            ? getColorFromHex('#32C8B1')
                                                            : Colors.grey[100]),
                                                    right: BorderSide(
                                                        width: 1.5,
                                                        color: productCode == dataPulsa[index]['kode_produk']
                                                            ? getColorFromHex('#32C8B1')
                                                            : Colors.grey[100]),
                                                  ),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                                margin: const EdgeInsets.only(bottom: 8),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(dataPulsa[index]['keterangan'],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w500,
                                                                color: (dataPulsa[index]['kode_produk'] == productCode
                                                                    ? getColorFromHex('#32C8B1')
                                                                    : Colors.black)))),
                                                    Container(
                                                        margin: EdgeInsets.only(top: 5),
                                                        alignment: Alignment.topLeft,
                                                        child: Text("Harga",
                                                            style: TextStyle(fontSize: 12, color: Colors.grey[700]))),
                                                    Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(dataPulsa[index]['harga_jual'],
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w700,
                                                                color: (dataPulsa[index]['kode_produk'] == productCode
                                                                    ? getColorFromHex('#32C8B1')
                                                                    : Colors.black)))),
                                                  ],
                                                )),
                                            onTap: () {
                                              setState(() {
                                                productCode = dataPulsa[index]['kode_produk'];
                                              });
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                                            },
                                          );
                                        })))),
                        Container(
                            // height: MediaQuery.of(context).size.height - 320,
                            height: 350,
                            padding: EdgeInsets.only(top: 10),
                            child: (isLoading
                                ? _buildProgressIndicator()
                                : RefreshIndicator(
                                    onRefresh: _cekPulsa,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(8),
                                        itemCount: dataPaketdata == null ? 0 : dataPaketdata.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return InkWell(
                                            child: Container(
                                                alignment: Alignment.topLeft,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 1.5,
                                                        color: productCode == dataPaketdata[index]['kode_produk']
                                                            ? getColorFromHex('#32C8B1')
                                                            : Colors.grey[100]),
                                                    top: BorderSide(
                                                        width: 1.5,
                                                        color: productCode == dataPaketdata[index]['kode_produk']
                                                            ? getColorFromHex('#32C8B1')
                                                            : Colors.grey[100]),
                                                    left: BorderSide(
                                                        width: 1.5,
                                                        color: productCode == dataPaketdata[index]['kode_produk']
                                                            ? getColorFromHex('#32C8B1')
                                                            : Colors.grey[100]),
                                                    right: BorderSide(
                                                        width: 1.5,
                                                        color: productCode == dataPaketdata[index]['kode_produk']
                                                            ? getColorFromHex('#32C8B1')
                                                            : Colors.grey[100]),
                                                  ),
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                                margin: const EdgeInsets.only(bottom: 8),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(dataPaketdata[index]['keterangan'],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w500,
                                                                color:
                                                                    (dataPaketdata[index]['kode_produk'] == productCode
                                                                        ? getColorFromHex('#32C8B1')
                                                                        : Colors.black)))),
                                                    Container(
                                                        margin: EdgeInsets.only(top: 5),
                                                        alignment: Alignment.topLeft,
                                                        child: Text("Harga",
                                                            style: TextStyle(fontSize: 12, color: Colors.grey[700]))),
                                                    Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(dataPaketdata[index]['harga_jual'],
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w700,
                                                                color:
                                                                    (dataPaketdata[index]['kode_produk'] == productCode
                                                                        ? getColorFromHex('#32C8B1')
                                                                        : Colors.black)))),
                                                  ],
                                                )),
                                            onTap: () {
                                              setState(() {
                                                productCode = dataPaketdata[index]['kode_produk'];
                                              });
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                                            },
                                          );
                                        }))))
                      ]))
                ])),
            Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: const Text("Metode Pembayaran", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      margin: const EdgeInsets.only(bottom: 8, top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 1.5, color: metodePembayaran == 1 ? getColorFromHex('#32C8B1') : Colors.grey[200]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              metodePembayaran = 1;
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Image.asset('icon_wallet.png', height: 30)),
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                      child: Text("SimpananKu",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: (metodePembayaran == 1
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
                          ),
                          // ignore: void_checks
                          onPressed: () {
                            if (_controllerNo.text == "") {
                              bottomInfo(context, "No Telepon harus diisi");
                              return false;
                            }

                            if (metodePembayaran == "") {
                              bottomInfo(context, "Metode Pembayaran harus dipilih");
                              return false;
                            }
                            if (productCode == "") {
                              bottomInfo(context, "Product code harus dipilih");
                              return false;
                            }

                            sendData('/pulsa/transaction', {
                              'no': _controllerNo.text,
                              'product_code': productCode,
                              'metode_pembayaran': metodePembayaran
                            }).then((response) {
                              log(response.data.toString());
                              if (response.data['message'] == 'success') {
                                displayDialog(context, 'Info', "Transaksi anda berhasil di submit, silakan menunggu.");
                              }
                            });
                          },
                          child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ))))
          ],
        )));
  }
}
