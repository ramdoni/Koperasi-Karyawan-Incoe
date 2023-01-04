import 'dart:async';
import 'dart:io';
import 'package:coopzone_application/belanja/riwayat.dart';
import 'package:coopzone_application/kirim_uang.dart';
import 'package:coopzone_application/pinjaman/pinjaman_tunai.dart';
import 'package:coopzone_application/simpanan/simpanan_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toast/toast.dart';
import 'package:upgrader/upgrader.dart';
import 'belanja_digital/listrikToken.dart';
import 'belanja_digital/pulsa.dart';
import 'copstore.dart';
import 'helpers/bottomNavBar.dart';
import 'helpers/util.dart';
import 'helpers/session.dart' as session;
import 'package:qr_code_scanner/qr_code_scanner.dart';

final _storage = FlutterSecureStorage();

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
  int backPressCounter = 0, backPressTotal = 2, isTabFocus = 1, _selectedIndex = 0, pageIndex = 0, tabActive = 1;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode resultBarcode;
  QRViewController controller;
  bool showBarcode = false;

  @override
  void initState() {
    super.initState();
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
        showBarcode = false;
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  void scanPembayaran(context) => showModalBottomSheet(
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
                      (showBarcode
                          ? Container(
                              height: 300,
                              child: QRView(
                                key: qrKey,
                                onQRViewCreated: _onQRViewCreated,
                              ),
                            )
                          : Container(height: 0, width: 0)),
                    ],
                  ),
                )));
          });
        },
      );

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                                                margin: const EdgeInsets.only(top: 10, left: 24),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Column(children: [
                                                        Container(
                                                            margin: const EdgeInsets.only(bottom: 4),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                    flex: 5,
                                                                    child: Container(
                                                                        // alignment: Alignment.topRight,
                                                                        child: const Text("SimpananKu",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontSize: 15))))
                                                              ],
                                                            )),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 5,
                                                                child: Container(
                                                                    child: Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Text(
                                                                            " Rp. " + session.simpananKu.toString(),
                                                                            style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w700)))))
                                                            // InkWell(
                                                            //     onTap: () {
                                                            //       Navigator.of(context).push(MaterialPageRoute(
                                                            //           builder: (context) => SimpananScreen()));
                                                            //     },
                                                            //     child: Container(
                                                            //         decoration: const BoxDecoration(
                                                            //           border: Border(
                                                            //             top:
                                                            //                 BorderSide(width: 1.5, color: Colors.white),
                                                            //             bottom:
                                                            //                 BorderSide(width: 1.5, color: Colors.white),
                                                            //             left:
                                                            //                 BorderSide(width: 1.5, color: Colors.white),
                                                            //             right:
                                                            //                 BorderSide(width: 1.5, color: Colors.white),
                                                            //           ),
                                                            //           borderRadius:
                                                            //               BorderRadius.all(Radius.circular(5)),
                                                            //         ),
                                                            //         margin: EdgeInsets.only(left: 10),
                                                            //         padding: const EdgeInsets.only(
                                                            //             left: 5, right: 5, top: 2, bottom: 2),
                                                            //         child: const Text("Detail",
                                                            //             style: TextStyle(
                                                            //                 color: Colors.white, fontSize: 12)))),
                                                          ],
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        )),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: MediaQuery.of(context).size.width * 0.70,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(builder: (context) => KirimUangScreen()));
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.asset('icon_transfer.png'),
                                                    const Text("Transfer",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 12))
                                                  ],
                                                ))),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Image.asset('icon_tarik.png'),
                                            const Text("Tarik",
                                                style: TextStyle(
                                                    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12))
                                          ],
                                        )),
                                        Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (context) => SimpananAddScreen()));
                                                },
                                                child: Column(
                                                  children: const [
                                                    Icon(
                                                      CupertinoIcons.plus_circle,
                                                      color: Colors.white,
                                                      size: 34.0,
                                                    ),
                                                    Text("Topup",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 12))
                                                  ],
                                                ))),
                                        Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  scanPembayaran(context);
                                                  setState(() {
                                                    showBarcode = true;
                                                  });
                                                },
                                                child: Column(
                                                  children: const [
                                                    Icon(
                                                      CupertinoIcons.qrcode_viewfinder,
                                                      color: Colors.white,
                                                      size: 34.0,
                                                    ),
                                                    Text("Bayar/Beli",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 12))
                                                  ],
                                                )))
                                      ],
                                    ))
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
                                                  "Sisa Limit",
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
                                                            child: Column(
                                                          children: [
                                                            Container(
                                                                margin: EdgeInsets.only(bottom: 8),
                                                                child: Icon(Icons.motorcycle,
                                                                    color: getColorFromHex('32c8b1'))),
                                                            const Text('Astra')
                                                          ],
                                                        )),
                                                        Expanded(
                                                            child: Column(
                                                          children: [
                                                            Container(
                                                                margin: const EdgeInsets.only(bottom: 8),
                                                                child: Icon(Icons.shopping_bag,
                                                                    color: getColorFromHex('32c8b1'))),
                                                            Text('Toko')
                                                          ],
                                                        )),
                                                        Expanded(
                                                            child: Column(
                                                          children: [
                                                            Container(
                                                                margin: const EdgeInsets.only(bottom: 8),
                                                                child: Icon(Icons.pedal_bike,
                                                                    color: getColorFromHex('32c8b1'))),
                                                            Text('Motor')
                                                          ],
                                                        ))
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
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(builder: (context) => PulsaScreen()));
                                                          },
                                                          child: Column(children: [
                                                            Container(
                                                                margin: EdgeInsets.only(bottom: 8),
                                                                child: Image.asset('icon_paket_data.png', height: 28)),
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
              Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    color: getColorFromHex('c1eee7'),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Container(
                          child: Text("Mau Punya toko sendiri dan jualan di Coop Zone ?",
                              style: TextStyle(
                                  fontSize: 16, color: getColorFromHex('0A4F45'), fontWeight: FontWeight.w500))),
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
      ),
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
