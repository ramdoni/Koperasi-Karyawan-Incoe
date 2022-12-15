import 'package:flutter/material.dart';
import '../helpers/util.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PinjamanAddScreen extends StatefulWidget {
  @override
  createState() {
    return PinjamanAddScreenState();
  }
}

class NominalPinjaman {
  const NominalPinjaman(this.id, this.name);
  final String name;
  final int id;
}

class PinjamanAddScreenState extends State<PinjamanAddScreen> {
  final TextEditingController _controllerPaymentDate = TextEditingController();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  List<NominalPinjaman> nominalPinjaman = <NominalPinjaman>[
    const NominalPinjaman(1, '500.000'),
    const NominalPinjaman(2, '1.000.000'),
    const NominalPinjaman(3, '1.500.000'),
    const NominalPinjaman(4, '2.000.000'),
    const NominalPinjaman(5, '2.500.000'),
  ];
  int _nominalPinjaman, _lamaPinjaman;
  bool isSubmited = false;
  void submitIuran() async {
    try {
      if (_nominalPinjaman == null || _lamaPinjaman == null) {
        bottomInfo(context, "Lengkapi semua form");
        return;
      }
      setState(() {
        isSubmited = true;
      });
      sendData('/iuran/store',
          {'nominal_pinjaman': _nominalPinjaman, 'lama_pinjaman': _lamaPinjaman, 'device': _deviceData}).then((res) {
        setState(() {
          if (res.data['status'] == 'success') {
            Alert(
              context: context,
              type: AlertType.success,
              title: "Berhasil",
              desc: "Data pembayaran iuran berhasil di submit, silahkan menunggu konfirmasi dari kami.",
              buttons: [
                DialogButton(
                  child: const Text(
                    "Oke",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed('/home'),
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

  Widget build(context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text('Ajukan Pinjaman', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(children: const [
                                Text("Jumlah Pinjaman"),
                                Text(
                                  '*',
                                  style: TextStyle(color: Colors.red),
                                )
                              ]))),
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 8),
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: const Text(" --- Pilih Nominal Pinjaman --- ",
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                            value: _nominalPinjaman,
                            underline: Container(),
                            items: nominalPinjaman.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.name.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                value: item.id,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _nominalPinjaman = value;
                              });
                            },
                          ))
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(children: const [
                            Text("Lama Pinjaman"),
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
                            hint: const Text(" --- Tenor 1 Bulan --- ",
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                            value: _lamaPinjaman,
                            underline: Container(),
                            items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map((item) {
                              return DropdownMenuItem(
                                child: Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _lamaPinjaman = value;
                              });
                            },
                          ))
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
                              submitIuran();
                            },
                            child: (isSubmited
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : const Text('Submit Pinjaman', style: TextStyle(color: Colors.white))),
                          ))))
            ],
          )),
    );
  }
}
