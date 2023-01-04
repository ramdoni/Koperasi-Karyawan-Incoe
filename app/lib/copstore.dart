import 'package:coopzone_application/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import 'belanja_digital/listrikToken.dart';
import 'belanja_digital/pbb.dart';
import 'belanja_digital/pulsa.dart';

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
                    Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 13, right: 13),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
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
                                              child: Column(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(bottom: 8),
                                                      child:
                                                          Icon(Icons.phone_android, color: getColorFromHex('32c8b1'))),
                                                  const Text('Pulsa')
                                                ],
                                              ))),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => PulsaScreen()));
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
                                                child: Icon(Icons.electric_bolt, color: getColorFromHex('32c8b1'))),
                                            Text('Listrik')
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
                                              const Text('Internet')
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
                                              child: InkWell(
                                            child: Column(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(bottom: 8),
                                                    child: Icon(Icons.motorcycle, color: getColorFromHex('32c8b1'))),
                                                Text('PBB')
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
                        ]))
                  ],
                ))));
  }
}
