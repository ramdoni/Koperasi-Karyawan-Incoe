import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';

class PinjamanTunaiAddScreen extends StatefulWidget {
  @override
  createState() {
    return PinjamanTunaiAddScreenState();
  }
}

class PinjamanTunaiAddScreenState extends State<PinjamanTunaiAddScreen> {
  var dataKuotaPinjaman = {};
  int durasiPinjaman;
  bool proteksiPinjaman = false;
  final TextEditingController _controllerJumlahPinjaman = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLimitPinjaman();
  }

  Future _loadLimitPinjaman() async {
    try {
      getData('/pinjaman/kuota').then((res) {
        setState(() {
          if (res.data['message'] == 'success') {
            dataKuotaPinjaman = res.data['data'];
            log('Kuota : ' + dataKuotaPinjaman.toString());
          } else {
            bottomInfo(context, res.data['message']);
          }
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  void konfirmasiProteksi(context) => showModalBottomSheet(
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
                          child:
                              Text("Kebijakan Privasi", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))),
                      Container(
                          alignment: Alignment.topLeft,
                          child: const Text("I. PENGUMPULAN INFORMASI PRIBADI",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
                      Container(
                          margin: EdgeInsets.only(left: 5, top: 10),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Expanded(flex: 1, child: Icon(CupertinoIcons.circle_fill, size: 10)),
                                  Expanded(
                                    flex: 9,
                                    child: Text("Informasi tentang komputer dan kunjungan ke serta penggunaan website"),
                                  )
                                ],
                              ),
                              Row(
                                children: const [
                                  Expanded(flex: 1, child: Icon(CupertinoIcons.circle_fill, size: 10)),
                                  Expanded(
                                    flex: 9,
                                    child: Text("Informasi yang diberikan ketika mendaftar melalui website"),
                                  )
                                ],
                              ),
                              Row(
                                children: const [
                                  Expanded(flex: 1, child: Icon(CupertinoIcons.circle_fill, size: 10)),
                                  Expanded(
                                    flex: 9,
                                    child: Text(
                                        "Informasi yang diberikan untuk tujuan berlangganan pemberitahuan melalui email"),
                                  )
                                ],
                              ),
                              Row(
                                children: const [
                                  Expanded(flex: 1, child: Icon(CupertinoIcons.circle_fill, size: 10)),
                                  Expanded(
                                    flex: 9,
                                    child: Text("Informasi yang diberikan ketika menggunakan layanan website"),
                                  )
                                ],
                              ),
                              Row(
                                children: const [
                                  Expanded(flex: 1, child: Icon(CupertinoIcons.circle_fill, size: 10)),
                                  Expanded(
                                    flex: 9,
                                    child: Text("Informasi yang diposting di website untuk publikasi di internet"),
                                  )
                                ],
                              ),
                              Row(
                                children: const [
                                  Expanded(flex: 1, child: Icon(CupertinoIcons.circle_fill, size: 10)),
                                  Expanded(
                                    flex: 9,
                                    child: Text("Informasi pribadi lainnya yang dipilih untuk dikirimkan"),
                                  )
                                ],
                              )
                            ],
                          )),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 37, top: 15),
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
                                    mystate(() {
                                      proteksiPinjaman = true;
                                    });
                                    setState(() {
                                      proteksiPinjaman = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Setuju', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ))),
                      ),
                    ],
                  ),
                )));
          });
        },
      );

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
          title: Text('Ajukan Pinjaman', style: TextStyle(color: getColorFromHex('41c8b1'), fontSize: 17)),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
        ),
        body: Column(
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
                      child: const Text("Masukan jumlah pinjaman",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Tersedia limit pinjaman tunai untuk kamu senilai Rp. " +
                                (dataKuotaPinjaman['kuota_sisa'] ?? '0'),
                            style: TextStyle(fontSize: 12))),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Container(
                              child: TextFormField(
                            keyboardType: TextInputType.none,
                            maxLines: null,
                            controller: _controllerJumlahPinjaman,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Nominal pinjaman harus isi";
                              }
                              return null;
                            },
                            style: TextStyle(fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                hintText: "Rp. 1.000.000,-"),
                            onTap: () {},
                          ))
                        ])),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text("Pilih durasi pinjaman",
                            style: TextStyle(fontSize: 12, color: getColorFromHex('00000A')))),
                    Row(children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  bottom: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  left: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  right: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text("3 Bulan", style: TextStyle(color: getColorFromHex('999999'))))),
                      Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  bottom: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  left: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  right: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text("6 Bulan", style: TextStyle(color: getColorFromHex('999999'))))),
                      Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  bottom: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  left: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  right: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text("12 Bulan", style: TextStyle(color: getColorFromHex('999999'))))),
                      Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  bottom: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  left: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                  right: BorderSide(width: 1.5, color: getColorFromHex('999999')),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text("24 Bulan", style: TextStyle(color: getColorFromHex('999999'))))),
                    ])
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(margin: EdgeInsets.only(right: 8), child: Image.asset('icon_proteksi.png')),
                        ),
                        Expanded(
                            flex: 9,
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: Text("Proteksi Pinjaman",
                                    style: TextStyle(
                                        fontSize: 12, color: getColorFromHex('000000'), fontWeight: FontWeight.w500))))
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 37),
                        child: Column(
                          children: [
                            Text(
                                "Kamu akan mendapatkan perlindungan asuransi bebas biaya untuk pelunasan pembayaran sisa angsuran, jika : ",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400, color: getColorFromHex('666666'))),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(top: 10, bottom: 4),
                                child: Text("1. Meninggal Dunia",
                                    style: TextStyle(fontSize: 12, color: getColorFromHex('666666')))),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text("2. Cacat Total & Tetap",
                                    style: TextStyle(fontSize: 12, color: getColorFromHex('666666'))))
                          ],
                        )),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 37, top: 15),
                      child: ButtonTheme(
                          minWidth: double.infinity,
                          height: 30.0,
                          child: SizedBox(
                              width: 100,
                              height: 30.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: getColorFromHex("4ec9b2"),
                                ),
                                onPressed: () {
                                  konfirmasiProteksi(context);
                                },
                                child: const Text('Konfirmasi', style: TextStyle(color: Colors.white, fontSize: 12)),
                              ))),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 34, top: 15),
                        child: Row(
                          children: [
                            Icon(proteksiPinjaman ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.app,
                                color: getColorFromHex('32c8b1')),
                            const Text("Setuju")
                          ],
                        ))
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                color: Colors.white,
                child: Row(
                  children: [
                    const Expanded(
                        flex: 4, child: Text("Jumlah angsuran Kamu senilai", style: TextStyle(fontSize: 12))),
                    Expanded(
                        flex: 3, child: Text(" Rp.", style: TextStyle(color: getColorFromHex('32C8B1'), fontSize: 16))),
                    Expanded(flex: 2, child: Text("/bulan", style: TextStyle(fontSize: 12)))
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                        flex: 8, child: Text("Pilih metode pencairan pinjaman kamu", style: TextStyle(fontSize: 12))),
                    Expanded(
                        flex: 1,
                        child: Text("Pilih", style: TextStyle(fontSize: 12, color: getColorFromHex('CCCCCC')))),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {},
                            child: Icon(
                              CupertinoIcons.chevron_forward,
                              color: getColorFromHex('cccccc'),
                              size: 25.0,
                            )))
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 40.0,
                    child: SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getColorFromHex("4ec9b2"),
                          ),
                          onPressed: () {},
                          child: const Text('Ajukan Sekarang', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ))))
          ],
        ));
  }
}
