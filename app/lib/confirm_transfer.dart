import 'dart:io';
import 'package:flutter/material.dart';
import 'helpers/util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ConfirmTransferScreen extends StatefulWidget {
  @override
  createState() {
    return ConfirmTransferScreenState();
  }
}

class ConfirmTransferScreenState extends State<ConfirmTransferScreen> {
  final TextEditingController _controllerPaymentDate = TextEditingController();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  int totalIuran, bankAccountId;
  XFile fotoBuktiPembayaran;
  List listBank;
  String paymentDate, noForm;
  bool isSubmited = false;
  @override
  void initState() {
    loadBank();

    super.initState();
  }

  void loadBank() async {
    try {
      getDataNoLogin('/get-bank').then((res) {
        setState(() {
          if (res.data['message'] == 'success') {
            listBank = res.data['data'];
          } else {
            bottomInfo(context, res.data['message']);
          }
        });
      }, onError: (exception) {
        if (exception.message != null) {
          bottomInfo(context, exception.message.toString());
        }
      });
    } catch (e) {
      bottomInfo(context, "Gagal load bank silahkan di coba kembali :\n" + e.toString());
    }
  }

  void submit() async {
    try {
      if (noForm == null || bankAccountId == null || fotoBuktiPembayaran == null || paymentDate == null) {
        bottomInfo(context, "Lengkapi semua form");
        return;
      }
      setState(() {
        isSubmited = true;
      });
      sendImage(
          '/konfirmasi-pendaftaran',
          {'no_form': noForm, 'bank_account_id': bankAccountId, 'payment_date': paymentDate},
          {'file_konfirmasi': fotoBuktiPembayaran != null ? File(fotoBuktiPembayaran.path) : null}).then((res) {
        setState(() {
          if (res.data['status'] == 'success') {
            Alert(
              context: context,
              type: AlertType.success,
              title: "Berhasil",
              desc: "Data berhasil di submit, silahkan menunggu konfirmasi dari kami.",
              buttons: [
                DialogButton(
                  child: const Text(
                    "Oke",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed('/'),
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                  radius: BorderRadius.circular(0.0),
                ),
              ],
            ).show();
          } else {
            bottomInfo(context, res.data['message']);
          }
          setState(() {
            isSubmited = false;
          });
        });
      });
    } catch (e) {
      bottomInfo(context, "Gagal submt iuran silahkan di coba kembali :\n" + e.toString());
    }
  }

  void choosePaymentDate() async {
    var tempDate = await getDate();
    setState(() {
      if (tempDate != null) {
        paymentDate = tempDate.year.toString() + "-" + tempDate.month.toString() + "-" + tempDate.day.toString();
        _controllerPaymentDate.text = paymentDate;
      }
    });
  }

  Future<DateTime> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945, 1, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  void _chooseBuktiPembayaran() async {
    try {
      var file = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
      setState(() {
        fotoBuktiPembayaran = file;
      });
      // ignore: empty_catches
    } catch (error) {
      bottomInfo(context, "Gagal mengambil foto silahkan coba lagi");
    }
  }

  Widget build(context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('KONFIRMASI PEMBAYARAN', style: TextStyle()),
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: const [
                      Text("No Form"),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ])),
                Container(
                    child: TextFormField(
                  // keyboardType: TextInputType.,
                  maxLines: null,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "No Form harus diisi";
                    }
                    return null;
                  },
                  style: TextStyle(fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                      hintText: ""),
                  onChanged: (val) => noForm = val,
                ))
              ])),
          Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: const [
                        Text("Bank Tujuan"),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        )
                      ])),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 8),
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text(" --- Pilih --- ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                        value: bankAccountId,
                        underline: Container(),
                        items: listBank == null
                            ? []
                            : listBank.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item['bank'] + " - " + item['no_rekening'] + " a/n " + item['owner'],
                                      style: TextStyle(fontWeight: FontWeight.normal)),
                                  value: item['id'],
                                );
                              }).toList(),
                        onChanged: (value) {
                          setState(() {
                            bankAccountId = value;
                          });
                        },
                      ))
                ],
              )),
          Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Row(children: const [
                      Text("Tanggal Bayar"),
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ])),
                Container(
                    child: TextFormField(
                  keyboardType: TextInputType.none,
                  maxLines: null,
                  controller: _controllerPaymentDate,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Tanggal bayar harus diisi";
                    }
                    return null;
                  },
                  style: TextStyle(fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                      contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                      hintText: ""),
                  onTap: choosePaymentDate,
                ))
              ])),
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: const [
                        Text("Upload Bukti Pembayaran"),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        )
                      ])),
                  (fotoBuktiPembayaran != null
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          margin: EdgeInsets.only(top: 15.0),
                          child: Image.file(
                            File(fotoBuktiPembayaran.path),
                            fit: BoxFit.cover,
                          ))
                      : Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(border: Border.all(width: 1.0, color: Color(0xFFEBE6E6FF))),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt_sharp),
                            tooltip: 'Take Photo',
                            onPressed: _chooseBuktiPembayaran,
                          )))
                ],
              )),
          Container(
              padding: EdgeInsets.all(20),
              child: ButtonTheme(
                  minWidth: double.infinity,
                  height: 35.0,
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          submit();
                        },
                        child: (isSubmited
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                            : const Text('Submit', style: TextStyle(color: Colors.white))),
                      ))))
        ],
      ))),
    );
  }
}
