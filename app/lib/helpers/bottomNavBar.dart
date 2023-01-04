// ignore: file_names
import 'package:flutter/material.dart';
import '../copstore.dart';
import '../home.dart';
import '../inbox.dart';
import '../profile/index.dart';
import '../simpanan/simpanan.dart';

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
  final int tabActive;

  const bottomNavBar({Key key, this.tabActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
              size: tabActive == 0 ? 30 : 28,
            )),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.business,
            size: tabActive == 1 ? 30 : 28,
          ),
          label: 'Koperasi',
        ),
        const BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
              color: Color.fromARGB(255, 44, 188, 25),
              size: 40,
            ),
            label: 'CoopStore',
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notifications_none,
            size: tabActive == 3 ? 30 : 28,
          ),
          label: 'Pesan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, size: tabActive == 4 ? 30 : 28),
          label: 'Profile',
        ),
      ],
      currentIndex: tabActive,
      selectedItemColor: Color.fromARGB(255, 44, 188, 25),
      selectedFontSize: 13,
      unselectedItemColor: Colors.grey[600],
      onTap: (int index) {
        if (index == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        if (index == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SimpananScreen()));
        }
        if (index == 2) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CoopstoreScreen()));
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
