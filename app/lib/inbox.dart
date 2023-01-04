import 'dart:developer';
import 'package:coopzone_application/helpers/bottomNavBar.dart';
import 'package:flutter/material.dart';
import '../helpers/util.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _storage = FlutterSecureStorage();

class InboxScreen extends StatefulWidget {
  @override
  createState() {
    return InboxScreenState();
  }
}

class InboxScreenState extends State<InboxScreen> with TickerProviderStateMixin {
  TabController controller;

  int totalTagihan = 0, filterTahun;
  List data;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    _loadData();
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
    try {
      setState(() {
        isLoading = true;
      });
      getData('/notification/data').then((res) {
        log(res.data.toString());
        setState(() {
          if (res.data['status'] == 'success') {
            data = res.data['data'];
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

  Widget build(context) {
    return Scaffold(
        bottomNavigationBar: bottomNavBar(tabActive: 3),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: getColorFromHex('FFFFFF'), //change your color here
          ),
          titleSpacing: 0,
          title: Text(
            "Notification",
            style: TextStyle(color: getColorFromHex('08CFB6')),
          ),
          backgroundColor: getColorFromHex('FFFFFF'),
          elevation: 0,
          bottom: TabBar(
            labelColor: getColorFromHex('41c8b1'),
            indicatorColor: getColorFromHex('41c8b1'),
            controller: controller,
            tabs: const <Widget>[
              Tab(
                text: "Notifikasi",
              ),
              Tab(
                text: "Pesan",
              )
            ],
          ),
        ),
        backgroundColor: getColorFromHex('EFEFEF'),
        body: TabBarView(controller: controller, children: <Widget>[
          SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(
                    top: 0,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height - 420,
                          padding: EdgeInsets.only(top: 10),
                          child: (isLoading
                              ? _buildProgressIndicator()
                              : RefreshIndicator(
                                  onRefresh: _loadData,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(8),
                                      itemCount: data == null ? 0 : data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          child: Container(
                                              // height: 70,
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0, top: 15.0, bottom: 0.0),
                                              decoration: BoxDecoration(color: Colors.white),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                      child: Text(data[index]['message'],
                                                          style: TextStyle(color: getColorFromHex('798289')))),
                                                  Container(
                                                    alignment: Alignment.bottomRight,
                                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                                    child: Text(data[index]['date'],
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700,
                                                            color: getColorFromHex('6d757d'))),
                                                  ),
                                                ],
                                              )),
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                                          },
                                        );
                                      }))))
                    ],
                  ))),
          SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.only(
            top: 0,
            bottom: 20,
          )))
        ]));
  }
}
