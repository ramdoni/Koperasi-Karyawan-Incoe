import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';

class PinjamanTunaiBayarScreen extends StatefulWidget {
  @override
  createState() {
    return PinjamanTunaiBayarScreenState();
  }
}

class PinjamanTunaiBayarScreenState extends State<PinjamanTunaiBayarScreen> {
  var dataTagihan = {};

  @override
  void initState() {
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
    _loadTagihan();
  }

  Future _loadTagihan() async {
    try {
      getData('/tagihan/first').then((res) {
        setState(() {
          if (res.data['message'] == 'success') {
            dataTagihan = res.data['data'];
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

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColorFromHex('41c8b1'), //change your color here
          ),
          title: Text('Tagihan Saya', style: TextStyle(color: getColorFromHex('41c8b1'), fontSize: 17)),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text("Jumlah yang harus dibayar",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Rp. " + dataTagihan['tagihan'].toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900))),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                            "Jatuh tempo pembayaran : " +
                                (dataTagihan['bulan'] != null ? dataTagihan['bulan'].toString() : '-'),
                            style: TextStyle(
                                color: getColorFromHex('32C8B1'), fontSize: 12, fontWeight: FontWeight.w700))),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text("Kode Pembayaran : ", style: TextStyle(fontSize: 12))),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(10),
                        color: getColorFromHex('efefef'),
                        child: const Text(
                            "Pembayaran angsuran kamu otomatis akan terdebit setiap tanggal 25 setiap bulanya dengan metode pemotongan gaji secara otomatis",
                            style: TextStyle(fontSize: 12)))
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("Metode Pembayaran",
                            style: TextStyle(fontSize: 12, color: getColorFromHex('666666')))),
                    Container(
                        color: getColorFromHex('efefef'),
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.wallet, color: getColorFromHex('41c8b1')),
                          ),
                          Expanded(flex: 8, child: Container(child: Text("Saldo Simpanan"))),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => SimpananPokokScreen()));
                                  },
                                  child: Icon(
                                    CupertinoIcons.chevron_forward,
                                    color: getColorFromHex('cccccc'),
                                    size: 25.0,
                                  )))
                        ])),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        color: getColorFromHex('efefef'),
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
                          Expanded(
                            flex: 1,
                            child: Icon(CupertinoIcons.arrowtriangle_right_fill, color: getColorFromHex('41c8b1')),
                          ),
                          Expanded(flex: 8, child: Container(child: Text("Transfer Bank"))),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => SimpananPokokScreen()));
                                  },
                                  child: Icon(
                                    CupertinoIcons.chevron_forward,
                                    color: getColorFromHex('cccccc'),
                                    size: 25.0,
                                  )))
                        ])),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        color: getColorFromHex('efefef'),
                        padding: EdgeInsets.all(10),
                        child: Row(children: [
                          Expanded(
                            flex: 1,
                            child: Icon(Icons.person, color: getColorFromHex('41c8b1')),
                          ),
                          Expanded(flex: 8, child: Container(child: Text("Via Loket / Mitra"))),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => SimpananPokokScreen()));
                                  },
                                  child: Icon(
                                    CupertinoIcons.chevron_forward,
                                    color: getColorFromHex('cccccc'),
                                    size: 25.0,
                                  )))
                        ])),
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
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (context) => PinjamanTunaiBayarScreen()));
                                  },
                                  child:
                                      const Text('Bayar Sekarang', style: TextStyle(color: Colors.white, fontSize: 12)),
                                )))),
                  ],
                ))
          ],
        ));
  }
}
