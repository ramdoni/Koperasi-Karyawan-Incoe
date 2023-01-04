import 'dart:developer';

import 'package:flutter/material.dart';
import '../helpers/util.dart';

class PinjamanTunaiTagihanScreen extends StatefulWidget {
  @override
  createState() {
    return PinjamanTunaiTagihanScreenState();
  }
}

class PinjamanTunaiTagihanScreenState extends State<PinjamanTunaiTagihanScreen> with TickerProviderStateMixin {
  int totalTagihan = 0, filterTahun;
  TabController controller;
  List dataLunas, dataBelumlunas;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  Future _loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      getData('/pembiayaan/tunai').then((res) {
        setState(() {
          log(res.data.toString());
          if (res.data['status'] == 'success') {
            dataLunas = res.data['data_lunas'];
            dataBelumlunas = res.data['data_belum_lunas'];
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
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: getColorFromHex('41c8b1'), //change your color here
        ),
        title: Text('Tagihan Saya', style: TextStyle(color: getColorFromHex('41c8b1'), fontSize: 17)),
        backgroundColor: getColorFromHex('FFFFFF'),
        elevation: 0,
        bottom: TabBar(
          labelColor: getColorFromHex('41c8b1'),
          indicatorColor: getColorFromHex('41c8b1'),
          controller: controller,
          tabs: const <Widget>[
            Tab(
              text: "Belum Lunas",
            ),
            Tab(
              text: "Lunas",
            )
          ],
        ),
      ),
      body: TabBarView(controller: controller, children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 10),
            color: getColorFromHex('efefef'),
            child: (isLoading
                ? _buildProgressIndicator()
                : RefreshIndicator(
                    onRefresh: _loadData,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: dataLunas == null ? 0 : dataLunas.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Container(
                                margin: const EdgeInsets.only(bottom: 10, left: 10),
                                child: const Text("Tagihan Berikutnya",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)));
                          } else {
                            return InkWell(
                              child: Container(
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.white),
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 6,
                                          child: Column(children: [
                                            Container(
                                                child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(dataLunas[index]['bulan_name'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            color: getColorFromHex('434343'))))),
                                            Container(
                                                child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text("Tanggal jatuh tempo  " + dataLunas[index]['bulan'],
                                                        style: TextStyle(
                                                            fontSize: 12.0, color: getColorFromHex('434343')))))
                                          ])),
                                      Expanded(
                                          flex: 4,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Rp. " + dataLunas[index]['tagihan'] + ",-",
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                              )))
                                    ],
                                  )),
                              onTap: () {
                                // Navigator.of(context).push(
                                //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                              },
                            );
                          }
                        })))),
        Container(
            padding: EdgeInsets.only(top: 10),
            color: getColorFromHex('efefef'),
            child: (isLoading
                ? _buildProgressIndicator()
                : RefreshIndicator(
                    onRefresh: _loadData,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: dataBelumlunas == null ? 0 : dataBelumlunas.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Container(
                                margin: const EdgeInsets.only(bottom: 10, left: 10),
                                child: Text(dataBelumlunas[index]['tahun'],
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)));
                          } else {
                            return InkWell(
                              child: Container(
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.white),
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 6,
                                          child: Column(children: [
                                            Container(
                                                child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(dataBelumlunas[index]['bulan_name'],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            color: getColorFromHex('434343'))))),
                                            Container(
                                                child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                        "Tanggal jatuh tempo  " + dataBelumlunas[index]['bulan'],
                                                        style: TextStyle(
                                                            fontSize: 12.0, color: getColorFromHex('434343')))))
                                          ])),
                                      Expanded(
                                          flex: 4,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Rp. " + dataBelumlunas[index]['tagihan'] + ",-",
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                              )))
                                    ],
                                  )),
                              onTap: () {
                                // Navigator.of(context).push(
                                //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                              },
                            );
                          }
                        }))))
      ]),
    );
  }
}
