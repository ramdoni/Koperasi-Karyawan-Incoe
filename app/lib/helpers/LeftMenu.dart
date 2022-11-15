import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../helpers/session.dart' as session;

final _storage = FlutterSecureStorage();

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      Container(
        height: 45,
        child: ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
      ),
      Container(
        height: 45,
        child: ListTile(
          leading: Icon(Icons.table_view_rounded),
          title: Text('Iuran'),
          onTap: () {
            Navigator.of(context).pushNamed('/iuran');
          },
        ),
      ),
      Container(
          height: 45,
          child: ListTile(
              leading: new Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _storage.deleteAll();
                Navigator.of(context).pushNamed('/');
              })),
    ]));
  }
}
