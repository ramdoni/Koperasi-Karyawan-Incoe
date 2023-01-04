import 'dart:developer';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import '../helpers/session.dart' as session;

class SimpananWajibScreen extends StatefulWidget {
  @override
  createState() {
    return SimpananWajibScreenState();
  }
}

class SimpananWajibScreenState extends State<SimpananWajibScreen> {
  int filterTahun, tabActive = 1;
  bool isSubmited = false;

  List dataTransaksi, dataStatus;

  bool isLoading = false;
  DateTime date = new DateTime.now();
  @override
  void initState() {
    super.initState();
    _loadTransaksi();
  }

  Future _loadTransaksi() async {
    try {
      setState(() {
        isLoading = true;
      });
      getData('/simpanan/wajib').then((res) {
        setState(() {
          log(res.data.toString());
          if (res.data['status'] == 'success') {
            dataTransaksi = res.data['data'];
          } else {
            bottomInfo(context, res.data['message']);
          }
          isLoading = false;
          _loadStatus();
        });
      });
    } catch (error) {
      bottomInfo(context, error.toString());
    }
  }

  Future _loadStatus() async {
    try {
      setState(() {
        isLoading = true;
      });
      getData('/simpanan/wajib-status').then((res) {
        setState(() {
          log(res.data.toString());

          if (res.data['status'] == 'success') {
            dataStatus = res.data['data'];
          } else {
            bottomInfo(context, res.data['message']);
          }
          isLoading = false;
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
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Kembali', style: TextStyle(color: Colors.white, fontSize: 16)),
        titleSpacing: 0,
        backgroundColor: getColorFromHex('32c8b1'),
        elevation: 0,
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Column(
                children: [
                  Stack(children: <Widget>[
                    Positioned(
                        child: Container(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            color: getColorFromHex('32c8b1'),
                            child: Column(
                              children: [
                                const Center(
                                    child: Text("Simpanan Wajib",
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700))),
                                Center(
                                    child: Text("Rp. " + session.simpananWajib + ",-",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700))),
                              ],
                            ))),
                    Positioned(
                        top: 90,
                        child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              height: 0,
                              width: 100,
                            )))
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.only(top: 0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                      SizedBox(height: 0.0),
                      DefaultTabController(
                          length: 2, // length of tabs
                          initialIndex: 0,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: getColorFromHex('32c8b1'),
                                unselectedLabelColor: Colors.black,
                                indicatorColor: getColorFromHex('32c8b1'),
                                tabs: [Tab(text: 'Riwayat Transaksi'), Tab(text: 'Status Simpanan')],
                              ),
                            ),
                            Container(
                                height:
                                    isLoading ? 300 : (MediaQuery.of(context).size.height - 250), //height of TabBarView

                                child: TabBarView(children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Filter"),
                                              Container(
                                                  width: 130,
                                                  height: 30,
                                                  margin: EdgeInsets.only(left: 10, top: 6, bottom: 8),
                                                  padding: EdgeInsets.only(left: 10.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3.0),
                                                    border: Border.all(
                                                        color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                                  ),
                                                  child: DropdownButton(
                                                    isExpanded: true,
                                                    hint: const Text(" --- Tahun --- ",
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                                    value: filterTahun,
                                                    underline: Container(),
                                                    items: [2019, 2020, 2021, 2022].map((item) {
                                                      return DropdownMenuItem(
                                                        child: Text(item.toString(),
                                                            style: TextStyle(fontWeight: FontWeight.normal)),
                                                        value: item,
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        filterTahun = value;
                                                      });
                                                    },
                                                  )),
                                              Container(
                                                  width: 140,
                                                  height: 30,
                                                  margin: EdgeInsets.only(left: 10, top: 5, bottom: 8),
                                                  padding: EdgeInsets.only(left: 10.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3.0),
                                                    border: Border.all(
                                                        color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                                  ),
                                                  child: DropdownButton(
                                                    isExpanded: true,
                                                    hint: const Text(" Semua Transaksi ",
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                                    value: filterTahun,
                                                    underline: Container(),
                                                    items: [2019, 2020, 2021, 2022].map((item) {
                                                      return DropdownMenuItem(
                                                        child: Text(item.toString(),
                                                            style: TextStyle(fontWeight: FontWeight.normal)),
                                                        value: item,
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        filterTahun = value;
                                                      });
                                                    },
                                                  ))
                                            ],
                                          ),
                                          Container(
                                              height: MediaQuery.of(context).size.height - 320,
                                              padding: EdgeInsets.only(top: 10),
                                              child: (isLoading
                                                  ? _buildProgressIndicator()
                                                  : RefreshIndicator(
                                                      onRefresh: _loadTransaksi,
                                                      child: ListView.builder(
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          padding: const EdgeInsets.all(8),
                                                          itemCount: dataTransaksi == null ? 0 : dataTransaksi.length,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return InkWell(
                                                              child: Container(
                                                                  height: 60,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    border: Border(
                                                                      bottom: BorderSide(
                                                                          width: 1.5, color: Colors.grey[300]),
                                                                    ),
                                                                  ),
                                                                  padding: const EdgeInsets.only(
                                                                      left: 10.0, right: 10.0, top: 15.0, bottom: 0.0),
                                                                  margin: const EdgeInsets.only(bottom: 0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: Container(
                                                                            child: Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: (dataTransaksi[index]
                                                                                            ['status'] ==
                                                                                        1
                                                                                    ? Icon(Icons.checklist,
                                                                                        color: Colors.green)
                                                                                    : Icon(Icons.timelapse_sharp,
                                                                                        color: Colors.yellow[900])))),
                                                                      ),
                                                                      Expanded(
                                                                          flex: 9,
                                                                          child: Column(children: [
                                                                            Container(
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "Rp. " +
                                                                                      dataTransaksi[index]['amount'] +
                                                                                      ",-",
                                                                                  style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.w400),
                                                                                )),
                                                                            Container(
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                child: Align(
                                                                                    alignment: Alignment.topLeft,
                                                                                    child: Text(
                                                                                        dataTransaksi[index]['date'],
                                                                                        style: TextStyle(
                                                                                            fontSize: 12.0,
                                                                                            color: getColorFromHex(
                                                                                                '999999')))))
                                                                          ]))
                                                                    ],
                                                                  )),
                                                              onTap: () {
                                                                // Navigator.of(context).push(
                                                                //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                                                              },
                                                            );
                                                          }))))
                                        ],
                                      )),

                                  /**
                                   * Tab status simpanan
                                   */
                                  Container(
                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text("Filter",
                                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                                              Container(
                                                  width: 100,
                                                  height: 30,
                                                  margin: EdgeInsets.only(left: 10, top: 0, bottom: 8),
                                                  padding: EdgeInsets.only(left: 10.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(3.0),
                                                    border: Border.all(
                                                        color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                                                  ),
                                                  child: DropdownButton(
                                                    isExpanded: true,
                                                    hint: Text(date.year.toString(),
                                                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                                                    value: filterTahun,
                                                    underline: Container(),
                                                    items: [2019, 2020, 2021, 2022].map((item) {
                                                      return DropdownMenuItem(
                                                        child: Text(item.toString(),
                                                            style: TextStyle(fontWeight: FontWeight.normal)),
                                                        value: item,
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        filterTahun = value;
                                                      });
                                                    },
                                                  ))
                                            ],
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(top: 10),
                                              child: (isLoading
                                                  ? _buildProgressIndicator()
                                                  : RefreshIndicator(
                                                      onRefresh: _loadStatus,
                                                      child: ListView.builder(
                                                          scrollDirection: Axis.vertical,
                                                          shrinkWrap: true,
                                                          padding: const EdgeInsets.all(8),
                                                          itemCount: dataStatus == null ? 0 : dataStatus.length,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            return InkWell(
                                                              child: Container(
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    border: Border(
                                                                      bottom: BorderSide(
                                                                          width: 1.5, color: Colors.grey[300]),
                                                                      top: BorderSide(
                                                                          width: 1.5, color: Colors.grey[300]),
                                                                    ),
                                                                  ),
                                                                  padding: const EdgeInsets.only(
                                                                      left: 10.0, right: 10.0, bottom: 5.0, top: 5),
                                                                  margin: const EdgeInsets.only(bottom: 5),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 3,
                                                                        child: Container(
                                                                            padding: EdgeInsets.only(right: 20),
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              border: Border(
                                                                                right: BorderSide(
                                                                                    width: 1.5,
                                                                                    color: Colors.grey[300]),
                                                                              ),
                                                                            ),
                                                                            alignment: Alignment.centerRight,
                                                                            child: Text(dataStatus[index]['bulan'])),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(left: 10),
                                                                            alignment: Alignment.center,
                                                                            child: Text(
                                                                              dataStatus[index]['status'] == 1
                                                                                  ? "Lunas"
                                                                                  : "Belum Lunas",
                                                                              style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  color:
                                                                                      (dataStatus[index]['status'] == 1
                                                                                          ? getColorFromHex('32C8B1')
                                                                                          : getColorFromHex('FD9727')),
                                                                                  fontWeight: FontWeight.w500),
                                                                            )),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 3,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(left: 10),
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Text(
                                                                                dataStatus[index]['payment_date'],
                                                                                style: TextStyle(
                                                                                    fontSize: 10.0,
                                                                                    color: getColorFromHex('999999')))),
                                                                      )
                                                                    ],
                                                                  )),
                                                              onTap: () {
                                                                // Navigator.of(context).push(
                                                                //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                                                              },
                                                            );
                                                          }))))
                                        ],
                                      )),
                                ]))
                          ])),
                    ]),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
