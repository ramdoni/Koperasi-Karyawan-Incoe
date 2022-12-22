import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coopzone_application/helpers/util.dart';
import 'package:coopzone_application/simpanan/lainnya.dart';
import 'package:coopzone_application/simpanan/pokok.dart';
import 'package:coopzone_application/simpanan/sukarela.dart';
import '../helpers/session.dart' as session;

class PageHome extends StatelessWidget {
  PageHome({Key key, this.tabActive = 1}) : super(key: key);
  int tabActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorFromHex("e3ece7"),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 20),
      child: Stack(children: <Widget>[
        Positioned(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      padding: const EdgeInsets.only(left: 15, top: 30, right: 15, bottom: 15),
                      height: 235,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("background-apps.jpeg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    alignment: Alignment.topCenter,
                                    child: const Icon(
                                      CupertinoIcons.person_alt_circle,
                                      color: Colors.white,
                                      size: 30.0,
                                    ))),
                            Expanded(
                                flex: 7,
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Hi, " + session.name_,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white))),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Koperasi Karyawan Incoe | " + session.noAnggota,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white))),
                                    Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Column(children: [
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                        flex: 2, child: Icon(Icons.wallet, color: Colors.white)),
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
                                                Container(
                                                    child: Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(" Rp. " + session.saldoSimpanan.toString(),
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w700))))
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
                                  children: const [
                                    Icon(
                                      CupertinoIcons.arrow_up_right_circle_fill,
                                      color: Colors.white,
                                      size: 34.0,
                                    ),
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
          top: 170,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 15),
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 13, right: 13),
                  width: MediaQuery.of(context).size.width * 0.95,
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
                                    tabActive = 1;
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
                                      padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                                      child: Text("Simpanan",
                                          style: TextStyle(
                                              color: (tabActive == 1
                                                  ? getColorFromHex('32C8B1')
                                                  : getColorFromHex('434343')))))),
                              InkWell(
                                  onTap: () {
                                    tabActive = 2;
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(right: 10, left: 10),
                                      child: Text("Pinjaman", style: TextStyle(color: getColorFromHex('434343'))))),
                              Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Text("Belanja Digital", style: TextStyle(color: getColorFromHex('434343')))),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                    child: Text("Simpanan",
                                        style: TextStyle(
                                            color: getColorFromHex("1D94DD"),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)))),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (context) => SimpananPokokScreen()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(bottom: 3),
                                            child: Image.asset('icon_pokok.png'),
                                            width: 40),
                                        const Text('Pokok')
                                      ],
                                    ))),
                            Expanded(
                                child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 3),
                                    child: Image.asset('icon_wajib.png'),
                                    width: 30),
                                Text('Wajib')
                              ],
                            )),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => SimpananSukarelaScreen()));
                              },
                              child: Column(children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 3),
                                    child: Image.asset('icon_sukarela.png'),
                                    width: 30),
                                const Text('Sukarela')
                              ]),
                            )),
                            Expanded(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (context) => SimpananLainnyaScreen()));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(bottom: 3),
                                            child: Image.asset('icon_lainnya.png'),
                                            width: 30),
                                        const Text('Lainnya')
                                      ],
                                    )))
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      child: Text("Pinjaman",
                                          style: TextStyle(
                                              color: getColorFromHex("1D94DD"),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14)))),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      child: Image.asset('icon_uang.png'),
                                      width: 30),
                                  const Text('Uang')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      child: Image.asset('icon_astra.png'),
                                      width: 30),
                                  const Text('Astra')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      child: Image.asset('icon_toko.png'),
                                      width: 30),
                                  const Text('Toko')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      child: Image.asset('icon_motor.png'),
                                      width: 30),
                                  const Text('Motor')
                                ],
                              ))
                            ],
                          )),
                    ],
                  ))),
        ),
        /**
         * Section 3 
         * 
         */
        Positioned(
          top: 520,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 15),
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.95,
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
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Icon(Icons.phone_android, color: getColorFromHex('32c8b1'))),
                              Text('Pulsa')
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Icon(Icons.public, color: getColorFromHex('32c8b1'))),
                              Text('Paket Data')
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Icon(Icons.electric_bolt, color: getColorFromHex('32c8b1'))),
                              Text('PLN')
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Icon(Icons.list_alt_rounded, color: getColorFromHex('32c8b1'))),
                              Text('Pajak PBB')
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
                                      child: Icon(Icons.pedal_bike_sharp, color: getColorFromHex('32c8b1'))),
                                  Text('STNK')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Icon(Icons.note, color: getColorFromHex('32c8b1'))),
                                  Text('BPKB')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Icon(Icons.motorcycle, color: getColorFromHex('32c8b1'))),
                                  Text('SIM')
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Icon(Icons.tv_outlined, color: getColorFromHex('32c8b1'))),
                                  const Text(
                                    'Internet & TV Kabel',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ))
                            ],
                          )),
                    ],
                  ))),
        )
      ]),
    );
  }
}
