import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/util.dart';
import 'pinjaman_tunai.dart';

class PinjamanTunaiAddScreen extends StatefulWidget {
  @override
  createState() {
    return PinjamanTunaiAddScreenState();
  }
}

class PinjamanTunaiAddScreenState extends State<PinjamanTunaiAddScreen> {
  final TextEditingController _controller = TextEditingController();
  String _formatNumber(String s) => NumberFormat.decimalPattern('en').format(int.parse(s));

  Map dataKuotaPinjaman = {}, data = {};
  List dataDurasi = [];
  int durasiPinjaman = 0, metodePencairan = 0, bankId = 0;
  bool proteksiPinjaman = false, isSubmitPinjaman = false, isHitung = false;
  String angsuranPerbulan = "", proteksiPinjamanAmount = "", platformFee = "", keperuntukan = "";
  final TextEditingController _controllerJumlahPinjaman = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLimitPinjaman();
  }

  Future _loadLimitPinjaman() async {
    try {
      getData('/pembiayaan/tunai/kuota').then((res) {
        setState(() {
          if (res.data['status'] == 'success') {
            dataKuotaPinjaman = res.data['data'];
          } else {
            bottomInfo(context, res.data['message']);
          }
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  Future _hitung() async {
    try {
      setState(() {
        isHitung = true;
      });
      if (_controllerJumlahPinjaman.text.isNotEmpty) {
        sendData('/pembiayaan/tunai/hitung',
            {'jumlah_pinjaman': _controllerJumlahPinjaman.text, 'bulan': durasiPinjaman}).then((res) {
          setState(() {
            if (res.data['status'] == 'success') {
              angsuranPerbulan = res.data['angsuran_perbulan'];
              data = res.data['data'];
              dataDurasi = res.data['items'];
              proteksiPinjamanAmount = res.data['proteksi_pinjaman'];
              platformFee = res.data['platform_fee'];
            } else {
              bottomInfo(context, res.data['message']);
            }
            setState(() {
              isHitung = false;
            });
          });
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

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PinjamanTunaiScreen()));
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
      if (_controllerJumlahPinjaman.text == "") {
        bottomInfo(context, "Nominal Pinjaman harus diisi");

        return false;
      }
      if (durasiPinjaman == 0) {
        bottomInfo(context, "Durasi Pinjaman harus dipilih");

        return false;
      }

      if (keperuntukan == "") {
        bottomInfo(context, "Peruntukan harus diisi");

        return false;
      }

      setState(() {
        isSubmitPinjaman = true;
      });
      if (_controllerJumlahPinjaman.text != "" && durasiPinjaman > 0 && metodePencairan > 0) {
        sendData('/pembiayaan/tunai/store', {
          'jumlah_pinjaman': _controllerJumlahPinjaman.text,
          'bulan': durasiPinjaman,
          'metode_pencairan': metodePencairan,
          'bank_id': bankId,
          'keperuntukan': keperuntukan
        }).then((res) {
          setState(() {
            log(res.data.toString());
            if (res.data['status'] == 'success') {
              displayDialog(context, "Success", res.data['message']);
            } else {
              bottomInfo(context, res.data['message']);
            }
            setState(() {
              isSubmitPinjaman = false;
            });
          });
        });
      }
    } catch (error) {
      setState(() {
        isSubmitPinjaman = false;
      });
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

  List<Container> _buildListToken(int count) => List.generate(
      count,
      (i) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: getColorFromHex('32C8B1')),
            ),
          ),
          child: InkWell(
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(dataDurasi[i]['cicilan_ke'],
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: dataDurasi[i]['number'] == durasiPinjaman
                                    ? getColorFromHex("4ec9b2")
                                    : Colors.black)))),
                Expanded(
                    flex: 3,
                    child: Text(dataDurasi[i]['total_angsuran_perbulan'],
                        style: TextStyle(
                            color:
                                dataDurasi[i]['number'] == durasiPinjaman ? getColorFromHex("4ec9b2") : Colors.black))),
                Expanded(
                    flex: 2,
                    child: dataDurasi[i]['number'] == durasiPinjaman
                        ? Container(child: Icon(Icons.check_outlined, color: getColorFromHex("4ec9b2")))
                        : Container(height: 0, width: 0))
              ],
            ),
            onTap: () {
              setState(() {
                durasiPinjaman = dataDurasi[i]['number'];
              });
            },
          )));

  @override
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 20, bottom: 5),
                      child: const Text("Masukan jumlah pinjaman",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Tersedia limit pinjaman tunai untuk kamu senilai Rp. " +
                                (dataKuotaPinjaman['kuota_idr'] ?? '0'),
                            style: TextStyle(fontSize: 12))),
                    Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(children: [
                          Expanded(
                              flex: 7,
                              child: Container(
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      maxLines: null,
                                      controller: _controllerJumlahPinjaman,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "Nominal pinjaman harus isi";
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(fontWeight: FontWeight.normal),
                                      decoration: const InputDecoration(
                                          hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                          contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                          hintText: "Min : Rp. 500.000,-"),
                                      onTap: () {},
                                      onChanged: (String string) {
                                        string = '${_formatNumber(string.replaceAll(',', ''))}';
                                        _controllerJumlahPinjaman.value = TextEditingValue(
                                          text: string,
                                          selection: TextSelection.collapsed(offset: string.length),
                                        );
                                      }))),
                          Expanded(
                              flex: 3,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: ButtonTheme(
                                      child: SizedBox(
                                          width: 50,
                                          height: 30.0,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: getColorFromHex("4ec9b2"),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(32.0),
                                              ),
                                            ),
                                            onPressed: _hitung,
                                            child: (isHitung
                                                ? const SizedBox(
                                                    height: 13,
                                                    width: 13,
                                                    child: CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ))
                                                : const Text('Hitung',
                                                    style: TextStyle(color: Colors.white, fontSize: 12))),
                                          )))))
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
                        child: Text("Pilih durasi pinjaman",
                            style: TextStyle(fontSize: 12, color: getColorFromHex('00000A')))),
                    (dataDurasi.isNotEmpty
                        ? GridView.count(
                            primary: false,
                            shrinkWrap: true,
                            childAspectRatio: 7,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            crossAxisCount: 1,
                            children: _buildListToken(dataKuotaPinjaman['bulan']))
                        : Container(height: 0, width: 0))
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
                      child: Text("Keperuntukan", style: TextStyle(fontSize: 12)),
                    ),
                    Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 5),
                        child: TextFormField(
                          obscureText: true,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Keperuntukan harus diisi";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 10, left: 10),
                              border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(8.0),
                                  )),
                          onSaved: (value) {
                            setState(() {
                              keperuntukan = value;
                            });
                          },
                        ))
                    /**
                     * 
                     * ditambah keperuntukan  bisa multiple 

                     */
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(top: 10),
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
                        margin: const EdgeInsets.only(left: 37),
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
                                child: Text("2. Cacat Tetap Total",
                                    style: TextStyle(fontSize: 12, color: getColorFromHex('666666'))))
                          ],
                        )),
                    (proteksiPinjaman
                        ? Container(
                            margin: EdgeInsets.only(left: 34, top: 15),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.checkmark_square_fill, size: 20, color: getColorFromHex('32c8b1')),
                                const Text("Setuju", style: TextStyle(fontSize: 12))
                              ],
                            ))
                        : Container(
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
                                      child:
                                          const Text('Konfirmasi', style: TextStyle(color: Colors.white, fontSize: 12)),
                                    ))),
                          ))
                  ],
                )),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  "Pilih bank untuk pencairan pinjaman kamu",
                  style: TextStyle(fontSize: 12),
                )),
            Container(
                margin: const EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: metodePencairan == 2 ? getColorFromHex('#32C8B1') : Colors.grey[50],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        metodePencairan = 2;
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Image.asset('icon_wallet.png', height: 30)),
                        Expanded(
                            flex: 6,
                            child: Container(
                                child: Text("Pilih Bank",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: (metodePencairan == 2 ? getColorFromHex('#32C8B1') : Colors.black))))),
                        const Expanded(flex: 2, child: Icon(Icons.arrow_right_outlined, color: Colors.grey)),
                      ],
                    ))),
            Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                color: Colors.white,
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: Icon(Icons.info, color: getColorFromHex('#32C8B1'))),
                      ),
                      Expanded(
                          flex: 9,
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text("Detail Pinjaman",
                                  style: TextStyle(
                                      fontSize: 12, color: getColorFromHex('000000'), fontWeight: FontWeight.w500))))
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 5,
                              child: Text("Jumlah Pengajuan",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                          Expanded(
                              flex: 5,
                              child: Text(_controllerJumlahPinjaman.text != "" ? _controllerJumlahPinjaman.text : '-',
                                  textAlign: TextAlign.right))
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Expanded(
                              flex: 5,
                              child:
                                  Text("Biaya Layanan", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                          Expanded(flex: 5, child: Text("Rp. 5.000,-", textAlign: TextAlign.right))
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text("Proteksi Pinjaman",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                          Expanded(
                              flex: 5,
                              child: Text(proteksiPinjamanAmount == "" ? "-" : proteksiPinjamanAmount,
                                  textAlign: TextAlign.right))
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text("Angsuran Perbulan",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                          Expanded(
                              flex: 5,
                              child: Text(angsuranPerbulan == "" ? "-" : angsuranPerbulan, textAlign: TextAlign.right))
                        ],
                      )),
                ]))
          ],
        )),
        bottomNavigationBar: Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
              ),
            ),
            child: Row(children: [
              Expanded(
                  flex: 6,
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Text("Rp. " + (data.isNotEmpty ? data['jumlah_pinjaman'] : '0'),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, color: getColorFromHex('32C8B1'), fontWeight: FontWeight.w600)),
                          Text('Jumlah Diterima', textAlign: TextAlign.left, style: TextStyle(fontSize: 13))
                        ],
                      ))),
              Expanded(
                  flex: 4,
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: ButtonTheme(
                          child: SizedBox(
                              width: 50,
                              height: 40.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: getColorFromHex("4ec9b2"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                onPressed: _submit,
                                child: (isSubmitPinjaman
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                    : const Text('Ajukan Sekarang',
                                        style: TextStyle(color: Colors.white, fontSize: 12))),
                              )))))
            ])));
  }
}
