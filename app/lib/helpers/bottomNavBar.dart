import 'package:coopzone_application/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../inbox.dart';
import '../profile/index.dart';

final _storage = FlutterSecureStorage();

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alertComingSoon = AlertDialog(
    title: Row(children: [Container(margin: EdgeInsets.only(right: 10), child: Icon(Icons.info)), Text("Info")]),
    content: Text("Page Comming Soon."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertComingSoon;
    },
  );
}

class bottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          label: 'Pesan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      // currentIndex: _selectedIndex,
      selectedItemColor: Colors.green[800],
      unselectedItemColor: Colors.grey[600],
      onTap: (int index) {
        if (index == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        if (index == 1) {
          showAlertDialog(context);
        }
        if (index == 3) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => InboxScreen()));
        }
        if (index == 4) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileIndexScreen()));
        }
      },
    );
  }
}
