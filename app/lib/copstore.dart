import 'package:coopzone_application/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import 'belanja_digital/listrikToken.dart';
import 'belanja_digital/pbb.dart';
import 'belanja_digital/pulsa.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CoopstoreScreen extends StatefulWidget {
  @override
  createState() {
    return CoopstoreScreenState();
  }
}

class CoopstoreScreenState extends State<CoopstoreScreen> {
  TabController controller;
  int totalTagihan = 0, filterTahun;
  List data;
  bool isLoading = false;

  final List<Widget> imgList = [
    Container(child: Image.asset('banner_1.png')),
    Container(child: Image.asset('banner_2.png'))
  ];
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

  Future _loadData() async {
    try {} catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  Widget build(context) {
    return Scaffold(
        bottomNavigationBar: const bottomNavBar(tabActive: 2),
        appBar: AppBar(
          leading: Container(
              // height: 20,
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'logo_green.png',
                fit: BoxFit.cover,
              )),
          iconTheme: IconThemeData(
            color: getColorFromHex('FFFFFF'), //change your color here
          ),
          titleSpacing: 0,
          title: Container(
              height: 40,
              margin: EdgeInsets.only(left: 20),
              width: 230,
              alignment: Alignment.center,
              child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    maxLines: 1,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15.0),
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        contentPadding: EdgeInsets.only(left: 20, top: 18.0),
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: const BorderSide(color: Colors.teal)),
                        hintText: 'Pencarian...'),
                    onChanged: (val) {
                      setState(() {
                        // _searchText = val;
                      });
                    },
                  ))),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
          actions: [
            Container(
                margin: EdgeInsets.only(right: 15),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                )),
          ],
        ),
        backgroundColor: getColorFromHex('EFEFEF'),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(viewportFraction: .96, height: 170),
                      items: imgList
                          .map((item) => Container(
                                // padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                child: item,
                              ))
                          .toList(),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 30, bottom: 10),
                        alignment: Alignment.topLeft,
                        child: const Text("Kategori", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
                    Container(
                        // margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            // color: Colors.white,
                            ),
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(builder: (context) => PulsaScreen()));
                                              },
                                              child: Container(
                                                  child: Column(
                                                children: [
                                                  Container(
                                                      width: 45,
                                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                                      decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                                      ),
                                                      margin: EdgeInsets.only(bottom: 8),
                                                      child:
                                                          Icon(Icons.phone_android, color: getColorFromHex('ff3000'))),
                                                  const Text('Pulsa',
                                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                                ],
                                              )))),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => PulsaScreen()));
                                        },
                                        child: Column(children: [
                                          Container(
                                              width: 50,
                                              padding: EdgeInsets.only(top: 10, bottom: 10),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                              ),
                                              margin: EdgeInsets.only(bottom: 8),
                                              child: Image.asset('icon_paket_data.png', height: 28)),
                                          const Text('Paket Data',
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                        ]),
                                      )),
                                      Expanded(
                                          child: InkWell(
                                        child: Column(
                                          children: [
                                            Container(
                                                width: 45,
                                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                                ),
                                                margin: const EdgeInsets.only(bottom: 8),
                                                child: Icon(Icons.electric_bolt, color: getColorFromHex('006699'))),
                                            Text('Listrik', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => ListrikTokenScreen()));
                                        },
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Container(
                                              width: 45,
                                              padding: EdgeInsets.only(top: 10, bottom: 10),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                              ),
                                              margin: const EdgeInsets.only(bottom: 8),
                                              child: Icon(Icons.list_alt_rounded, color: getColorFromHex('0066cc'))),
                                          Text('Telepon', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
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
                                                  width: 45,
                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                  child: Icon(Icons.cell_tower_rounded, color: Colors.pink[700])),
                                              const Text('Internet',
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(bottom: 8),
                                                  width: 45,
                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                  child: Icon(Icons.phone_enabled_rounded, color: Colors.yellow[700])),
                                              Text('Pascabayar',
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(bottom: 8),
                                                  width: 45,
                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                  child: Icon(Icons.tv_sharp, color: getColorFromHex('135531'))),
                                              Text('TV Kabel',
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(bottom: 8),
                                                  width: 45,
                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                  child: Icon(Icons.water_drop_outlined,
                                                      color: getColorFromHex('009966'))),
                                              const Text('Air PDAM',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
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
                                                  width: 45,
                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                  child: Icon(Icons.pedal_bike_sharp, color: Colors.red)),
                                              Text('Motor', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                            ],
                                          )),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(bottom: 8),
                                                  width: 45,
                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                  child: Icon(Icons.car_repair, color: Colors.blue)),
                                              Text('Mobil', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                            ],
                                          )),
                                          Expanded(
                                              child: InkWell(
                                            child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    width: 45,
                                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                                    ),
                                                    child: Icon(Icons.home, color: Colors.green[800])),
                                                Text('PBB', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(builder: (context) => PbbScreen()));
                                            },
                                          )),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(bottom: 8),
                                                  width: 45,
                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  ),
                                                  child: Icon(Icons.privacy_tip_rounded, color: Colors.red[800])),
                                              const Text('SIM',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                            ],
                                          ))
                                        ],
                                      )),
                                ],
                              ))
                        ])),
                    Container(
                        padding: EdgeInsets.only(left: 30, bottom: 10, top: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: Alignment.topLeft,
                        child: Row(children: [
                          Expanded(
                              flex: 5,
                              child:
                                  const Text("Best Sale", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
                          Expanded(
                              flex: 5,
                              child: Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 20),
                                  child: const Text("VIEW ALL",
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 10))))
                        ])),
                    Container(
                        padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                    height: 320,
                                    padding: EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.5,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(child: Image.asset('product_1.jpeg', fit: BoxFit.fill)),
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text("Bango Kecap Manis Soy Sauce",
                                                style: TextStyle(
                                                    fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black))),
                                        Container(
                                            margin: EdgeInsets.only(top: 5, left: 5),
                                            alignment: Alignment.topLeft,
                                            child: Text("Rp. 40.000", style: TextStyle(fontWeight: FontWeight.w600))),
                                        Container(
                                            child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    margin: EdgeInsets.only(left: 5, top: 10),
                                                    color: Colors.red[50],
                                                    padding: EdgeInsets.all(5),
                                                    alignment: Alignment.center,
                                                    child: Text("20%",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight.w400)))),
                                            Expanded(
                                                flex: 7,
                                                child: Container(
                                                    margin: EdgeInsets.only(top: 6, left: 10),
                                                    child: Text("Rp. 45.000",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.lineThrough))))
                                          ],
                                        )),
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: const [
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(Icons.location_on, color: Colors.green, size: 15)),
                                                Expanded(
                                                    flex: 9,
                                                    child: Text("Koperasi Incoe", style: TextStyle(fontSize: 12)))
                                              ],
                                            ))
                                      ],
                                    ))),
                            Expanded(
                                flex: 5,
                                child: Container(
                                    height: 320,
                                    margin: EdgeInsets.only(left: 10),
                                    padding: EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.5,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(child: Image.asset('product_2.jpeg', fit: BoxFit.fill)),
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text("Bango Kecap Manis Soy Sauce",
                                                style: TextStyle(
                                                    fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black))),
                                        Container(
                                            margin: EdgeInsets.only(top: 5, left: 5),
                                            alignment: Alignment.topLeft,
                                            child: Text("Rp. 40.000", style: TextStyle(fontWeight: FontWeight.w600))),
                                        Container(
                                            child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    margin: EdgeInsets.only(left: 5, top: 10),
                                                    color: Colors.red[50],
                                                    padding: EdgeInsets.all(5),
                                                    alignment: Alignment.center,
                                                    child: Text("20%",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.red,
                                                            fontWeight: FontWeight.w400)))),
                                            Expanded(
                                                flex: 7,
                                                child: Container(
                                                    margin: EdgeInsets.only(top: 6, left: 10),
                                                    child: Text("Rp. 45.000",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.lineThrough))))
                                          ],
                                        )),
                                        Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Icon(Icons.location_on, color: Colors.green, size: 15)),
                                                Expanded(
                                                    flex: 9,
                                                    child: Text("Koperasi Incoe", style: TextStyle(fontSize: 12)))
                                              ],
                                            ))
                                      ],
                                    ))),
                          ],
                        ))
                  ],
                ))));
  }
}
