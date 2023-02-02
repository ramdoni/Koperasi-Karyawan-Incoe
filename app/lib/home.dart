import 'dart:async';
import 'dart:io';
import 'package:coopzone_application/belanja/riwayat.dart';
import 'package:coopzone_application/pinjaman/pinjaman_tunai.dart';
import 'package:coopzone_application/qrcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:upgrader/upgrader.dart';
import 'belanja_digital/listrikToken.dart';
import 'belanja_digital/pulsa.dart';
import 'copstore.dart';
import 'helpers/bottomNavBar.dart';
import 'helpers/util.dart';
import 'helpers/session.dart' as session;
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final cfg = AppcastConfiguration(supportedOS: ['ios']);
  bool isLoadIuran = true;
  List dataIuran;
  int backPressCounter = 0, backPressTotal = 2, isTabFocus = 1, pageIndex = 0, tabActive = 1;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  List<Widget> imgSection = [
    Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
        // width: MediaQuery.of(context).size.width * 0.92,
        decoration: BoxDecoration(
          color: getColorFromHex('c1eee7'),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
                child: Text("Mau Punya toko sendiri dan jualan di Coop Zone ?",
                    style: TextStyle(fontSize: 16, color: getColorFromHex('0A4F45'), fontWeight: FontWeight.w500))),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                    "Coop Zone memfasilitasi semua anggota koperasi untuk berwirausaha mendirikan toko sendiri dan produknya dapat dipasarkan ke seluruh anggota koperasi",
                    style: TextStyle(color: getColorFromHex('0A4F45'), fontSize: 12))),
            Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                    height: 45.0,
                    child: SizedBox(
                        width: 160,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: getColorFromHex("4ec9b2"),
                          ),
                          onPressed: () {},
                          child: Text('Buka Toko',
                              style: TextStyle(
                                color: getColorFromHex('0A4F45'),
                              )),
                        ))))
          ],
        )),
    Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
        // width: MediaQuery.of(context).size.width * 0.92,
        decoration: BoxDecoration(
          color: getColorFromHex('c1eee7'),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
                child: Text("Perlu Dana Tunai ? silahkan ajukan melalui CoopZone",
                    style: TextStyle(fontSize: 16, color: getColorFromHex('0A4F45'), fontWeight: FontWeight.w500))),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                    "Coop Zone memfasilitasi semua anggota koperasi untuk melakukan peminjaman dana Tunai dengan cara mudah dan cepat",
                    style: TextStyle(color: getColorFromHex('0A4F45'), fontSize: 12))),
            Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 20),
                child: ButtonTheme(
                    height: 45.0,
                    child: SizedBox(
                        width: 180,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: getColorFromHex("4ec9b2"),
                          ),
                          onPressed: () {},
                          child: Row(children: const [
                            Expanded(
                                flex: 8,
                                child: Text('Ajukan Sekarang',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ))),
                            Expanded(flex: 2, child: Icon(Icons.double_arrow_outlined))
                          ]),
                        ))))
          ],
        )),
  ];
  final List<Widget> imgList = [
    Container(
        child: Row(
      children: [
        Expanded(
            flex: 3,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Colors.grey[200],
                  ),
                ),
                margin: EdgeInsets.only(right: 10, top: 10),
                child: Column(children: [
                  Image.asset('mitra_1.png', fit: BoxFit.fill),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 1, right: 2, top: 10),
                      child:
                          Text("Indomaret - Kota Depok", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10))),
                  Container(
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: Row(children: const [
                        Expanded(flex: 6, child: Text("Pondok Cina", style: TextStyle(fontSize: 9))),
                        Expanded(flex: 1, child: Icon(Icons.location_on, color: Colors.green, size: 9)),
                        Expanded(flex: 3, child: Text("6,21 km", style: TextStyle(color: Colors.green, fontSize: 9)))
                      ]))
                ]))),
        Expanded(
            flex: 3,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Colors.grey[200],
                  ),
                ),
                margin: EdgeInsets.only(right: 10, top: 10),
                child: Column(children: [
                  Image.asset('mitra_2.png', fit: BoxFit.fill),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 1, right: 2, top: 10),
                      child: Text("CFC - Kahuripan",
                          textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10))),
                  Container(
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: Row(children: const [
                        Expanded(flex: 6, child: Text("Kemang", style: TextStyle(fontSize: 9))),
                        Expanded(flex: 1, child: Icon(Icons.location_on, color: Colors.green, size: 9)),
                        Expanded(flex: 3, child: Text("3,43 km", style: TextStyle(color: Colors.green, fontSize: 9)))
                      ]))
                ]))),
        Expanded(
            flex: 3,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Colors.grey[200],
                  ),
                ),
                margin: EdgeInsets.only(right: 10, top: 10),
                child: Column(children: [
                  Image.asset('mitra_3.png', fit: BoxFit.fill),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 1, right: 2, top: 10),
                      child: Text("Toko Hj. Ali", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10))),
                  Container(
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: Row(children: const [
                        Expanded(flex: 6, child: Text("Kemang", style: TextStyle(fontSize: 9))),
                        Expanded(flex: 1, child: Icon(Icons.location_on, color: Colors.green, size: 9)),
                        Expanded(flex: 3, child: Text("3,13 km", style: TextStyle(color: Colors.green, fontSize: 9)))
                      ]))
                ]))),
      ],
    )),
    Container(
        child: Row(children: [
      Expanded(
          flex: 3,
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey[200],
                ),
              ),
              margin: EdgeInsets.only(right: 10, top: 10),
              child: Column(children: [
                Image.asset('mitra_4.png', fit: BoxFit.fill),
                Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 1, right: 2, top: 10),
                    child: const Text("Warteg Sukses Bahari",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10))),
                Container(
                    padding: EdgeInsets.only(left: 2, right: 2),
                    child: Row(children: const [
                      Expanded(flex: 6, child: Text("Tajurhalang", style: TextStyle(fontSize: 9))),
                      Expanded(flex: 1, child: Icon(Icons.location_on, color: Colors.green, size: 9)),
                      Expanded(flex: 3, child: Text("0,73 km", style: TextStyle(color: Colors.green, fontSize: 9)))
                    ]))
              ]))),
      Expanded(flex: 3, child: Container()),
      Expanded(flex: 3, child: Container())
    ]))
  ];
  @override
  void initState() {
    super.initState();
  }

  void setProfile(data) {
    setState(() {
      session.noAnggota = data['data']['no_anggota'].toString();
      session.noKtp = data['data']['no_ktp'].toString();
      session.name_ = data['data']['name'].toString();
      session.email = data['data']['email'];
      session.telepon = data['data']['telepon'].toString();
      session.umur = data['data']['umur'].toString();
      session.tanggalLahir = data['data']['tanggal_lahir'].toString();
      session.jenisKelamin = data['data']['jenis_kelamin'].toString();
      session.alamat = data['data']['alamat'].toString();
      session.saldoSimpanan = data['data']['saldo_simpan'].toString();
      session.simpananPokok = data['data']['simpanan_pokok'].toString();
      session.simpananWajib = data['data']['simpanan_wajib'].toString();
      session.simpananSukarela = data['data']['simpanan_sukarela'].toString();
      session.simpananLainlain = data['data']['simpanan_lain_lain'].toString();
      session.pinjamanUang = data['data']['pinjaman_uang'].toString();
      session.pinjamanAstra = data['data']['pinjaman_astra'].toString();
      session.pinjamanToko = data['data']['pinjama_toko'].toString();
      session.pinjamanAstra = data['data']['pinjama_astra'].toString();
      session.shu = data['data']['shu'].toString();
    });
  }

  Widget label_(label, value) {
    return Container(
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(children: [
          Expanded(flex: 3, child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 7, child: Text(" : " + value.toString()))
        ]));
  }

  @override
  Widget build(context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar(
        tabActive: 0,
      ),
      body: WillPopScope(
          onWillPop: onWillPop,
          child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 460,
                          child: Stack(
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(left: 15, top: 40, right: 15, bottom: 15),
                                  height: 255,
                                  decoration: BoxDecoration(
                                    color: getColorFromHex('08CFB6'),
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                                      image: const AssetImage("background-apps.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 7,
                                            child: Column(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(bottom: 0),
                                                    margin: EdgeInsets.only(bottom: 0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.only(right: 5),
                                                          alignment: Alignment.topCenter,
                                                          child: Image.asset('logo_white.png', height: 40),
                                                        ),
                                                        Align(
                                                            alignment: Alignment.topLeft,
                                                            child: Text(
                                                                "Hi, " +
                                                                    session.name_ +
                                                                    "\n" +
                                                                    session.koperasi +
                                                                    " | " +
                                                                    session.noAnggota,
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 15,
                                                                    color: Colors.white))),
                                                      ],
                                                    )),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 5),
                                                    // width: MediaQuery.of(context).size.width * 0.92,
                                                    // width: 140,
                                                    decoration: const BoxDecoration(
                                                      // color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(13)),
                                                    ),
                                                    margin: const EdgeInsets.only(top: 23),
                                                    child: Row(children: [
                                                      Expanded(
                                                          flex: 3,
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: 3, top: 5),
                                                            child: Column(children: [
                                                              Container(
                                                                  alignment: Alignment.topLeft,
                                                                  margin: EdgeInsets.only(right: 5, bottom: 5),
                                                                  child: Image.asset('coopay-1.png', height: 20)),
                                                              Container(
                                                                  child: Align(
                                                                      alignment: Alignment.topLeft,
                                                                      child: Text("Rp." + session.simpananKu.toString(),
                                                                          style: const TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600)))),
                                                            ]),
                                                          )),
                                                      Expanded(
                                                          flex: 2,
                                                          child: InkWell(
                                                              onTap: () {
                                                                bottomInfo(context, "Fitur masih dalam pengembangan");
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                    alignment: Alignment.center,
                                                                    child: Icon(
                                                                      Icons.send_rounded,
                                                                      color: Colors.red[900],
                                                                      size: 34.0,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                      margin: EdgeInsets.only(top: 5),
                                                                      child: Text("Transfer",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 12)))
                                                                ],
                                                              ))),
                                                      Expanded(
                                                          flex: 2,
                                                          child: InkWell(
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                      alignment: Alignment.center,
                                                                      child: Icon(
                                                                        Icons.inbox_sharp,
                                                                        color: Colors.red[900],
                                                                        size: 34.0,
                                                                      )),
                                                                  Container(
                                                                      margin: EdgeInsets.only(top: 5),
                                                                      child: Text("Tarik",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 12)))
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                bottomInfo(context, "Fitur masih dalam pengembangan");
                                                              })),
                                                      Expanded(
                                                          flex: 2,
                                                          child: InkWell(
                                                              onTap: () {
                                                                bottomInfo(context, "Fitur masih dalam pengembangan");

                                                                // Navigator.of(context).push(MaterialPageRoute(
                                                                //     builder: (context) => SimpananAddScreen()));
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                      alignment: Alignment.center,
                                                                      child: Icon(
                                                                        CupertinoIcons.plus_circle,
                                                                        color: Colors.red[900],
                                                                        size: 34.0,
                                                                      )),
                                                                  Container(
                                                                      margin: EdgeInsets.only(top: 5),
                                                                      child: Text("Topup",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 12)))
                                                                ],
                                                              ))),
                                                      Expanded(
                                                          flex: 2,
                                                          child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(context).push(MaterialPageRoute(
                                                                    builder: (context) => QrcodeScreen()));
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                      alignment: Alignment.center,
                                                                      child: Icon(
                                                                        CupertinoIcons.qrcode_viewfinder,
                                                                        color: Colors.red[900],
                                                                        size: 34.0,
                                                                      )),
                                                                  Container(
                                                                      margin: EdgeInsets.only(top: 5),
                                                                      child: Text("Bayar/Beli",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 12)))
                                                                ],
                                                              )))
                                                    ])),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ])),

                              /**
                     * Section Plafond 
                     * 
                     */
                              Positioned(
                                top: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                    child: Container(
                                        margin: const EdgeInsets.only(bottom: 15),
                                        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 13, right: 13),
                                        width: MediaQuery.of(context).size.width * 0.92,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 10,
                                              offset: Offset(-6, 4),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                                child: const Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      "Saldo Limit",
                                                      textAlign: TextAlign.left,
                                                    ))),
                                            Container(
                                                child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 4,
                                                    child: Text("Rp. " + session.sisaPlafond + ",-",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: getColorFromHex('32C8B1'),
                                                            fontWeight: FontWeight.w700))),
                                                Expanded(
                                                    flex: 4,
                                                    child: Text("Limit : Rp. " + session.plafond + ",-",
                                                        style: const TextStyle(fontSize: 12))),
                                                Expanded(
                                                    flex: 2,
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) => BelanjaRiwayatScreen()));
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                decoration: const BoxDecoration(
                                                                  color: Colors.white,
                                                                ),
                                                                child: Image.asset('icon_riwayat.png')),
                                                            const Text("Riwayat", style: TextStyle(fontSize: 10))
                                                          ],
                                                        )))
                                              ],
                                            )),
                                            Container(
                                                margin: EdgeInsets.only(top: 15),
                                                padding: EdgeInsets.only(top: 15),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(width: 1.5, color: Colors.grey[300]),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            tabActive = 1;
                                                          });
                                                        },
                                                        child: Container(
                                                            decoration: (tabActive == 1
                                                                ? BoxDecoration(
                                                                    border: Border(
                                                                      top: BorderSide(
                                                                          width: 1.5, color: getColorFromHex('32C8B1')),
                                                                      bottom: BorderSide(
                                                                          width: 1.5, color: getColorFromHex('32C8B1')),
                                                                      left: BorderSide(
                                                                          width: 1.5, color: getColorFromHex('32C8B1')),
                                                                      right: BorderSide(
                                                                          width: 1.5, color: getColorFromHex('32C8B1')),
                                                                    ),
                                                                  )
                                                                : const BoxDecoration(color: Colors.white)),
                                                            padding: const EdgeInsets.only(
                                                                top: 5, bottom: 5, right: 10, left: 10),
                                                            child: Text("Pembiayaan",
                                                                style: TextStyle(
                                                                    color: (tabActive == 1
                                                                        ? getColorFromHex('32C8B1')
                                                                        : getColorFromHex('434343')))))),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            tabActive = 2;
                                                          });
                                                        },
                                                        child: Container(
                                                            margin: EdgeInsets.only(left: 10),
                                                            decoration: (tabActive == 2
                                                                ? BoxDecoration(
                                                                    border: Border(
                                                                      top: BorderSide(
                                                                          width: 1.5, color: getColorFromHex('32C8B1')),
                                                                      bottom: BorderSide(
                                                                          width: 1.5, color: getColorFromHex('32C8B1')),
                                                                      left: BorderSide(
                                                                          width: 1.5, color: getColorFromHex('32C8B1')),
                                                                      right: BorderSide(
                                                                          width: 1.5, color: getColorFromHex('32C8B1')),
                                                                    ),
                                                                  )
                                                                : const BoxDecoration(color: Colors.white)),
                                                            padding: const EdgeInsets.only(
                                                                top: 5, bottom: 5, right: 10, left: 10),
                                                            child: Text("Belanja Digital",
                                                                style: TextStyle(
                                                                    color: (tabActive == 2
                                                                        ? getColorFromHex('32C8B1')
                                                                        : getColorFromHex('434343')))))),
                                                  ],
                                                )),
                                            (tabActive == 1
                                                ? Container(
                                                    margin: EdgeInsets.only(top: 20),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => PinjamanTunaiScreen()));
                                                                    },
                                                                    child: Column(
                                                                      children: [
                                                                        Container(
                                                                            margin: EdgeInsets.only(bottom: 8),
                                                                            child: Icon(Icons.wallet,
                                                                                color: getColorFromHex('32c8b1'))),
                                                                        const Text('Tunai')
                                                                      ],
                                                                    ))),
                                                            Expanded(
                                                                child: InkWell(
                                                                    child: Column(
                                                                      children: [
                                                                        Container(
                                                                            margin: EdgeInsets.only(bottom: 2, top: 3),
                                                                            child:
                                                                                Image.asset('astra.png', height: 30)),
                                                                        const Text('Astra')
                                                                      ],
                                                                    ),
                                                                    onTap: () {
                                                                      bottomInfo(
                                                                          context, "Fitur masih dalam pengembangan");
                                                                    })),
                                                            Expanded(
                                                                child: InkWell(
                                                                    child: Column(
                                                                      children: [
                                                                        Container(
                                                                            margin: const EdgeInsets.only(bottom: 8),
                                                                            child: Icon(Icons.shopping_bag,
                                                                                color: getColorFromHex('32c8b1'))),
                                                                        Text('Toko')
                                                                      ],
                                                                    ),
                                                                    onTap: () {
                                                                      bottomInfo(
                                                                          context, "Fitur masih dalam pengembangan");
                                                                    })),
                                                            Expanded(
                                                                child: InkWell(
                                                                    child: Column(
                                                                      children: [
                                                                        Container(
                                                                            margin: const EdgeInsets.only(bottom: 8),
                                                                            child: Icon(Icons.pedal_bike,
                                                                                color: getColorFromHex('32c8b1'))),
                                                                        Text('Motor')
                                                                      ],
                                                                    ),
                                                                    onTap: () {
                                                                      bottomInfo(
                                                                          context, "Fitur masih dalam pengembangan");
                                                                    }))
                                                          ],
                                                        ),
                                                      ],
                                                    ))
                                                : const Text("")),
                                            (tabActive == 2
                                                ? Container(
                                                    margin: const EdgeInsets.only(top: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => PulsaScreen()));
                                                                    },
                                                                    child: Column(
                                                                      children: [
                                                                        Container(
                                                                            margin: EdgeInsets.only(bottom: 8),
                                                                            child: Icon(Icons.phone_android,
                                                                                color: getColorFromHex('32c8b1'))),
                                                                        const Text('Pulsa')
                                                                      ],
                                                                    ))),
                                                            Expanded(
                                                                child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(context).push(MaterialPageRoute(
                                                                    builder: (context) => PulsaScreen()));
                                                              },
                                                              child: Column(children: [
                                                                Container(
                                                                    margin: EdgeInsets.only(bottom: 8),
                                                                    child:
                                                                        Image.asset('icon_paket_data.png', height: 28)),
                                                                const Text('Paket Data')
                                                              ]),
                                                            )),
                                                            Expanded(
                                                                child: InkWell(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                      margin: const EdgeInsets.only(bottom: 8),
                                                                      child: Icon(Icons.electric_bolt,
                                                                          color: getColorFromHex('32c8b1'))),
                                                                  Text('Listrik')
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                Navigator.of(context).push(MaterialPageRoute(
                                                                    builder: (context) => ListrikTokenScreen()));
                                                              },
                                                            )),
                                                            Expanded(
                                                              child: InkWell(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                          margin: const EdgeInsets.only(bottom: 8),
                                                                          child: Icon(Icons.menu,
                                                                              color: getColorFromHex('32c8b1'))),
                                                                      Text('Lainnya')
                                                                    ],
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.of(context).push(MaterialPageRoute(
                                                                        builder: (context) => CoopstoreScreen()));
                                                                  }),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ))
                                                : Text(""))
                                          ],
                                        ))),
                              ),
                            ],
                          ))
                    ],
                  ),
                  CarouselSlider(
                    options: CarouselOptions(viewportFraction: .96, autoPlay: true, height: 240),
                    items: imgSection
                        .map((item) => Container(
                              margin: EdgeInsets.only(right: 10, left: 10),
                              child: item,
                            ))
                        .toList(),
                  ),
                  Center(
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 0),
                          width: MediaQuery.of(context).size.width * 0.92,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                  child: Row(
                                children: [
                                  Expanded(
                                      flex: 6,
                                      child: Text("Mitra Coop Zone Sekitarmu",
                                          style: TextStyle(color: getColorFromHex('0A4F45'), fontSize: 16))),
                                  Expanded(
                                      flex: 3,
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("Lihat Semua",
                                              style: TextStyle(fontSize: 12, color: getColorFromHex('999999'))))),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        CupertinoIcons.chevron_forward,
                                        color: getColorFromHex('cccccc'),
                                        size: 25.0,
                                      ))
                                ],
                              )),
                              Container(margin: EdgeInsets.only(top: 10), child: Image.asset('banner_home.png'))
                            ],
                          ))),
                  CarouselSlider(
                    options: CarouselOptions(viewportFraction: .96, height: 170, autoPlay: true),
                    items: imgList
                        .map((item) => Container(
                              width: MediaQuery.of(context).size.width,
                              child: item,
                            ))
                        .toList(),
                  ),
                  UpgradeAlert(
                    upgrader: Upgrader(
                      dialogStyle: UpgradeDialogStyle.cupertino,
                      appcastConfig: cfg,
                      debugLogging: true,
                      showLater: false,
                      showIgnore: false,
                      minAppVersion: '1.5.0',
                    ),
                    child: Container(width: 0, height: 0),
                  ),
                ])),
          )),
    );
  }

  Future<bool> onWillPop() {
    if (backPressCounter < 1) {
      Toast.show("Press again time to exit app", context);
      backPressCounter++;
      Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      exit(0);
      // return Future.value(true);
    }
  }
}
