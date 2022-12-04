// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import '../helpers/util.dart';
import 'helpers/LeftMenu.dart';
import 'iuran_add.dart';

class IuranScreen extends StatefulWidget {
  createState() {
    return IuranState();
  }
}

class IuranState extends State<IuranScreen> {
  List data;
  bool isLoading = true;
  String keyword, filterStatus, typeRisk, errorTypeRisk;
  bool isSubmit = false;
  final formKeyPickup = GlobalKey<FormState>();
  final formKeySolve = GlobalKey<FormState>();
  final formKeyFilter = GlobalKey<FormState>();

  Future _loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      getData('/iuran?keyword=' +
              (keyword != null ? keyword : '') +
              "&status=" +
              (filterStatus != null ? filterStatus : ""))
          .then((res) {
        setState(() {
          if (res.data['message'] == 'success') {
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

  void initState() {
    super.initState();
    _loadData();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 15, bottom: 8),
      child: new Center(
        child: new Opacity(
          opacity: 1.0,
          child: Column(children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(top: 10.0), child: const Text("Please wait ..."))
          ]),
        ),
      ),
    );
  }

  Widget _detailEmployee(item) {
    if (item['is_pic'] == 1) {
      return Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(item['employee'] + " / " + item['nik'], style: TextStyle(fontSize: 13.0)))),
          Container(
              margin: EdgeInsets.only(),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Department : " + item['department'].toString(), style: TextStyle(fontSize: 13.0)))),
        ],
      );
    }

    return SizedBox();
  }

  Widget paymentStatus(status) {
    if (status == 1) {
      return Align(
          alignment: Alignment.topCenter,
          child: Row(children: const [
            Icon(
              Icons.lock_clock,
              size: 14,
            ),
            Text("Admin ", textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontSize: 12))
          ]));
    }
    if (status == 2) {
      return Align(
          alignment: Alignment.topCenter,
          child: Row(children: const [
            Icon(Icons.check_box, size: 14, color: Colors.green),
            Text("Lunas ", textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 12))
          ]));
    }
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          // Container(
          //     margin: EdgeInsets.only(right: 20.0),
          //     child: IconButton(
          //       onPressed: () {
          //         // _popupFilter(context);
          //       },
          //       icon: Icon(Icons.search_rounded),
          //     ))
        ],
        title: Text(
          "Iuran",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      drawer: AppDrawer(),
      body: (isLoading
          ? _buildProgressIndicator()
          : RefreshIndicator(
              onRefresh: _loadData,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: Container(
                          decoration:
                              BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFEBE6E6FF)))),
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(data[index]['periode'], style: TextStyle(fontSize: 15.0)))),
                                  ),
                                  Expanded(flex: 3, child: paymentStatus(data[index]['payment_status']))
                                ],
                              ),
                              Container(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Payment Date : " + data[index]['payment_date'],
                                          style: TextStyle(fontSize: 13)))),
                              Container(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Payment Type : " + data[index]['payment_type'],
                                          style: TextStyle(fontSize: 12.0, color: Colors.grey)))),
                            ],
                          )),
                      onTap: () {
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => ItSupportDetailScreen(argument: data[index])));
                      },
                    );
                  }))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => IuranAddScreen()));
        },
        label: Text("IURAN"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.amber[900],
      ),
    );
  }
}
