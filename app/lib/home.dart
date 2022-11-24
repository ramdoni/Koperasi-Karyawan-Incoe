import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:coopzone_application/pinjaman/pinjaman_tunai.dart';
import 'package:coopzone_application/simpanan/simpanan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:toast/toast.dart';
import 'helpers/util.dart';
import 'page_finance.dart';
import 'page_home.dart';
import 'page_inbox.dart';
import 'helpers/session.dart' as session;

final _storage = FlutterSecureStorage();

class HomeScreen extends StatefulWidget {
  @override
  createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  bool isLoadIuran = true;
  List dataIuran;
  int backPressCounter = 0, backPressTotal = 2, isTabFocus = 1, _selectedIndex = 0, pageIndex = 0, tabActive = 1;

  final pages = [
    PageHome(),
    const Page2(),
    const PageInbox(),
    const Page4(),
  ];

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    // check session login
    _storage.readAll().then((result) {
      if (result['token'] != null) {
        setState(() {
          session.token = result['token'];
        });

        getData('/user/check-token').then((res) {
          if (res.data['message'].toString() == 'success') {
            setProfile(res.data);
          } else
            _storage.deleteAll();
        });
      }
    });
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Finance',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_scanner,
                color: Color.fromARGB(255, 44, 188, 25),
                size: 40,
              ),
              label: 'Pay',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey[600],
        onTap: (int index) {
          if (index == 4) {}
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Container(
        color: getColorFromHex("e3ece7"),
        width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.only(top: 20),
        child: Stack(children: <Widget>[
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                        padding: const EdgeInsets.only(left: 15, top: 40, right: 15, bottom: 15),
                        height: 255,
                        decoration: BoxDecoration(
                          color: getColorFromHex('08CFB6'),
                          image: DecorationImage(
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
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
                                                          "Koperasi Karyawan Incoe | " +
                                                          session.noAnggota,
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 15,
                                                          color: Colors.white))),
                                            ],
                                          )),
                                      Container(
                                          margin: EdgeInsets.only(top: 10, left: 34),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Column(children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 8,
                                                        child: Container(
                                                            child: const Align(
                                                                alignment: Alignment.topLeft,
                                                                child: Text("Saldo Simpanan",
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: 13)))),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          child: Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text(" Rp. " + session.saldoSimpanan.toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w700)))),
                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) => SimpananScreen()));
                                                          },
                                                          child: Container(
                                                              decoration: const BoxDecoration(
                                                                border: Border(
                                                                  top: BorderSide(width: 1.5, color: Colors.white),
                                                                  bottom: BorderSide(width: 1.5, color: Colors.white),
                                                                  left: BorderSide(width: 1.5, color: Colors.white),
                                                                  right: BorderSide(width: 1.5, color: Colors.white),
                                                                ),
                                                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                                              ),
                                                              margin: EdgeInsets.only(left: 10),
                                                              padding:
                                                                  EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
                                                              child: const Text("Detail",
                                                                  style:
                                                                      TextStyle(color: Colors.white, fontSize: 12)))),
                                                    ],
                                                  )
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
                                      child: Column(
                                    children: [
                                      Image.asset('icon_transfer.png'),
                                      Text("Transfer",
                                          style:
                                              TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12))
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.arrow_down,
                                        color: Colors.white,
                                        size: 34.0,
                                      ),
                                      Text("Tarik",
                                          style:
                                              TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12))
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.plus_circle,
                                        color: Colors.white,
                                        size: 34.0,
                                      ),
                                      Text("Topup",
                                          style:
                                              TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12))
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.qrcode_viewfinder,
                                        color: Colors.white,
                                        size: 34.0,
                                      ),
                                      Text("Bayar/Beli",
                                          style:
                                              TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12))
                                    ],
                                  ))
                                ],
                              ))
                        ]))),
              ],
            ),
          ),

          /**
         * Section Plafond 
         * 
         */
          Positioned(
            top: 180,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 15),
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
                                  "Sisa Plafond",
                                  textAlign: TextAlign.left,
                                ))),
                        Container(
                            child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text("Rp. " + session.sisaPlafond + ",-",
                                    style: TextStyle(
                                        fontSize: 18, color: getColorFromHex('32C8B1'), fontWeight: FontWeight.w700))),
                            Expanded(
                                flex: 4,
                                child: Text("Plafond : Rp. " + session.plafond + ",-",
                                    style: const TextStyle(fontSize: 12))),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Image.asset('icon_riwayat.png')),
                                    const Text("Riwayat", style: TextStyle(fontSize: 10))
                                  ],
                                ))
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
                                                  top: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
                                                  bottom: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
                                                  left: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
                                                  right: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
                                                ),
                                              )
                                            : const BoxDecoration(color: Colors.white)),
                                        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                        child: Text("Pinjaman",
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
                                                  top: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
                                                  bottom: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
                                                  left: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
                                                  right: BorderSide(width: 1.5, color: getColorFromHex('32C8B1')),
                                                ),
                                              )
                                            : const BoxDecoration(color: Colors.white)),
                                        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
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
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder: (context) => PinjamanTunaiScreen()));
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(bottom: 8),
                                                        child: Icon(Icons.wallet, color: getColorFromHex('32c8b1'))),
                                                    const Text('Uang')
                                                  ],
                                                ))),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(bottom: 8),
                                                child: Icon(Icons.motorcycle, color: getColorFromHex('32c8b1'))),
                                            const Text('Astra')
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(bottom: 8),
                                                child: Icon(Icons.shopping_bag, color: getColorFromHex('32c8b1'))),
                                            Text('Toko')
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(bottom: 8),
                                                child: Icon(Icons.pedal_bike, color: getColorFromHex('32c8b1'))),
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
                                            child: Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(bottom: 8),
                                                child: Icon(Icons.phone_android, color: getColorFromHex('32c8b1'))),
                                            const Text('Pulsa')
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(bottom: 8),
                                                // child: Icon(Icons.public, color: getColorFromHex('32c8b1'))
                                                child: Image.asset('icon_paket_data.png', height: 28)),
                                            const Text('Paket Data')
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(bottom: 8),
                                                child: Icon(Icons.electric_bolt, color: getColorFromHex('32c8b1'))),
                                            Text('Listrik')
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Container(
                                                margin: const EdgeInsets.only(bottom: 8),
                                                child: Icon(Icons.list_alt_rounded, color: getColorFromHex('32c8b1'))),
                                            Text('Telepon')
                                          ],
                                        ))
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child:
                                                        Icon(Icons.pedal_bike_sharp, color: getColorFromHex('32c8b1'))),
                                                Text('Internet')
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: Icon(Icons.note, color: getColorFromHex('32c8b1'))),
                                                Text('Pascabayar')
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: Icon(Icons.motorcycle, color: getColorFromHex('32c8b1'))),
                                                Text('TV Kabel')
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: Icon(Icons.tv_outlined, color: getColorFromHex('32c8b1'))),
                                                const Text(
                                                  'Air PDAM',
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ))
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child:
                                                        Icon(Icons.pedal_bike_sharp, color: getColorFromHex('32c8b1'))),
                                                Text('Motor')
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: Icon(Icons.note, color: getColorFromHex('32c8b1'))),
                                                Text('Mobil')
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: Icon(Icons.motorcycle, color: getColorFromHex('32c8b1'))),
                                                Text('PBB')
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: Icon(Icons.tv_outlined, color: getColorFromHex('32c8b1'))),
                                                const Text(
                                                  'SIM',
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ))
                                          ],
                                        )),
                                  ],
                                ))
                            : Text(""))
                      ],
                    ))),
          ),
        ]),
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

class Page3 extends StatelessWidget {
  const Page3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
