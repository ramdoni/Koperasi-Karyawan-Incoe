import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'helpers/util.dart';
import 'helpers/validation.dart';
import 'helpers/session.dart' as session;
import 'package:upgrader/upgrader.dart';

final _storage = FlutterSecureStorage();

final GlobalKey<State> _keyLoader = new GlobalKey<State>();

class LauncherScreen extends StatefulWidget {
  createState() {
    return LauncherScreenState();
  }
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
}

class LauncherScreenState extends State<LauncherScreen> with Validation {
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  String deviceToken = "";
  String type_ = "";
  Widget build(context) {
    Upgrader().clearSavedSettings();

    return Scaffold(
        backgroundColor: getColorFromHex("4ec9b2"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(40),
                child: Center(
                    child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Container(
                              height: 239,
                              child: Image.asset(
                                "logo_white.png",
                              ),
                            ),
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: 148,
                        child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 50.0,
                            child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: getColorFromHex("157874")),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/login');
                                  },
                                  child: const Text('Masuk', style: TextStyle(color: Colors.white, fontSize: 20)),
                                )))),
                  ],
                ))),
            UpgradeAlert(
              debugLogging: true,
              child: Center(child: Text('')),
            ),
          ],
        ));
  }

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();

      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String token = await messaging.getToken();

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted permission');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        log('User granted provisional permission');
      } else {
        log('User declined or has not accepted permission');
      }
      setState(() {
        deviceToken = token.toString();
      });

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log("message recieved : " + message.notification.toString());

        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification.android;
        if (notification != null && android != null) {
          log("hascode : " + notification.hashCode.toString());
          log("title : " + notification.title.toString());
          log("body : " + notification.body.toString());
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        log('Message clicked!');
        setState(() {
          type_ = message.data['type'].toString();
        });
        checkLogin();
      });
    } catch (e) {
      log("initializeFlutterFire : " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
    checkLogin();
  }

  void checkLogin() async {
    // check session login
    _storage.readAll().then((result) {
      if (result['token'] != null) {
        setState(() {
          session.token = result['token'];
        });

        getData('/user/check-token').then((res) {
          if (res.data['message'] == 'success') {
            setProfile(res.data);
            checkRedirect();
          } else
            _storage.deleteAll();
        });
      }
    });
  }

  void checkRedirect() {
    // if (type_ == "1") {
    //   Navigator.of(context).pushNamed('/daily-commitment-add');
    // } else if (type_ == "2") {
    //   Navigator.of(context).pushNamed('/ppe-check');
    // } else if (type_ == "3") {
    //   Navigator.of(context).pushNamed('/vehicle-check');
    // } else if (type_ == "4") {
    //   Navigator.of(context).pushNamed('/health-check');
    // } else if (type_ == "5") {
    //   Navigator.of(context).pushNamed('/training-material-and-exam');
    // } else if (type_ == "6") {
    //   Navigator.of(context).pushNamed('/it-support');
    // } else
    Navigator.of(context).pushNamed('/home');
  }

  void displayDialog(context, title, message) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Row(children: [
            Container(margin: const EdgeInsets.only(right: 10.0), child: Icon(Icons.warning, color: Colors.amber[800])),
            Text(title)
          ]),
          content: Text(message, style: const TextStyle(fontWeight: FontWeight.normal))));

  void setProfile(data) {
    setState(() {
      session.name_ = data['data']['name'];
      session.telepon = data['data']['telepon'].toString();
      session.noAnggota = data['data']['no_anggota'].toString();
      session.umur = data['data']['umur'].toString();
      session.tanggalAktif = data['data']['tanggal_aktif'].toString();
      session.kota = data['data']['kota'].toString();
    });
  }
}
