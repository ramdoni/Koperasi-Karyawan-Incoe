import 'package:coopzone_application/belanja/riwayat_token.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;
import 'riwayat_pulsa.dart';

class BelanjaRiwayatScreen extends StatefulWidget {
  @override
  createState() {
    return BelanjaRiwayatScreenState();
  }
}

class BelanjaRiwayatScreenState extends State<BelanjaRiwayatScreen> {
  final TextEditingController _controllerPaymentDate = TextEditingController();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  int filterTahun;
  String filterType;
  bool isSubmited = false;
  List data;
  bool isLoading = false;

  Future _loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      sendData('/transaction', {'filter_tahun': filterTahun}).then((res) {
        setState(() {
          data = res.data['data'];
          isLoading = false;
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Widget status_(status) {
    if (status == 0) {
      return Icon(Icons.info, color: Colors.amber);
    }
    if (status == 1) {
      return Icon(Icons.check_circle, color: Colors.green);
    }
  }

  Widget _listItem(context, label, data) {
    return Column(children: [
      Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
          decoration: BoxDecoration(color: getColorFromHex('afeae1')),
          child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
      for (int i = 0; i < data.length; i++)
        InkWell(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
                ),
              ),
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              margin: const EdgeInsets.only(bottom: 0),
              child: Column(
                children: [
                  Container(
                      child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Column(children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(data[i]['items'],
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(data[i]['date'],
                                    style:
                                        TextStyle(fontSize: 11, color: Colors.grey[500], fontWeight: FontWeight.w400)))
                          ])),
                      Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(width: 1, color: getColorFromHex('41c8b1')),
                                    top: BorderSide(width: 1, color: getColorFromHex('41c8b1')),
                                    left: BorderSide(width: 1, color: getColorFromHex('41c8b1')),
                                    right: BorderSide(width: 1, color: getColorFromHex('41c8b1'))),
                              ),
                              child: Text(data[i]['status'], style: TextStyle(fontSize: 9)))),
                      Expanded(
                          flex: 2,
                          child: Container(
                              child:
                                  Text(data[i]['price'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)))),
                    ],
                  )),
                ],
              )),
          onTap: () {
            if (data[i]['type_produk'] == 'Pulsa') {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => BelanjaRiwayatPulsaScreen(argument: data[i])));
            }
            if (data[i]['type_produk'] == 'PLN') {
              data[i]['data_json']['no_transaksi'] = data[i]['no_transaksi'];
              data[i]['data_json']['date'] = data[i]['date'];
              data[i]['data_json']['metode_pembayaran'] = data[i]['metode_pembayaran'];
              data[i]['data_json']['price'] = data[i]['price'];
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BelanjaRiwayatTokenScreen(argument: data[i]['data_json'])));
            }
          },
        )
    ]);
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
        // extendBodyBehindAppBar: true,
        backgroundColor: getColorFromHex('efefef'),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          titleSpacing: 0,
          title: const Text('Kembali', style: TextStyle(color: Colors.white, fontSize: 16)),
          backgroundColor: getColorFromHex('32c8b1'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: (isLoading
                ? _buildProgressIndicator()
                : RefreshIndicator(
                    onRefresh: _loadData,
                    child: Column(children: [
                      Container(
                          height: 160,
                          color: Colors.white,
                          child: Stack(children: <Widget>[
                            Positioned(
                                top: 0,
                                child: Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width,
                                    color: getColorFromHex('32c8b1'),
                                    child: Column(
                                      children: [
                                        const Center(
                                            child: Text("Limit Tersedia",
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700))),
                                        Container(
                                            margin: EdgeInsets.only(bottom: 10, top: 10),
                                            child: Text("Rp. " + session.sisaPlafond + ",-",
                                                style: const TextStyle(
                                                    color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700))),
                                        Container(
                                            child: Text("Jumlah Limit Rp. ", style: TextStyle(color: Colors.white))),
                                        Container(
                                            margin: EdgeInsets.only(top: 15),
                                            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3.0),
                                              border: Border.all(
                                                  color: Colors.white, style: BorderStyle.solid, width: 0.80),
                                            ),
                                            child: Text("Rincian", style: TextStyle(color: Colors.white)))
                                      ],
                                    ))),
                            Positioned(
                                top: 140,
                                child: Container(
                                    height: 100,
                                    padding: EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Container()))
                          ])),
                      Container(
                          alignment: Alignment.topLeft,
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Text("Jumlah yang harus dibayar",
                              style: TextStyle(color: getColorFromHex('666666'), fontSize: 12))),
                      Container(
                          padding: EdgeInsets.only(left: 20, bottom: 20),
                          color: Colors.white,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(session.tagihanPaylater,
                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)))),
                      Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                          alignment: Alignment.topLeft,
                          child:
                              Text("Riwayat Transaksi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text("Filter"),
                              Container(
                                  width: 130,
                                  height: 30,
                                  margin: EdgeInsets.only(left: 10, top: 6),
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: const Text(" --- Tahun --- ",
                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                    value: filterTahun,
                                    underline: Container(),
                                    items: [2019, 2020, 2021, 2022].map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        filterTahun = value;

                                        _loadData();
                                      });
                                    },
                                  )),
                              Container(
                                  width: 140,
                                  height: 30,
                                  margin: EdgeInsets.only(left: 10, top: 5),
                                  padding: EdgeInsets.only(left: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: const Text(" Semua Transaksi ",
                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                    value: filterType,
                                    underline: Container(),
                                    items: ['Transaksi In', 'Transaksi Out'].map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        filterType = value;
                                      });
                                    },
                                  ))
                            ],
                          )),
                      Container(
                          // height: MediaQuery.of(context).size.height - 420,
                          color: Colors.white,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: data == null ? 0 : data.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (data[index]['data'].length > 0) {
                                  return _listItem(context, data[index]['label'], data[index]['data']);
                                } else {
                                  return Container(
                                    height: 0,
                                    width: 0,
                                  );
                                }
                              }))
                    ]),
                  ))));
  }
}
