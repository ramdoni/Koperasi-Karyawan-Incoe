import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'helpers/util.dart';
import 'helpers/validation.dart';
import 'package:koperasi_incoe_application/helpers/session.dart' as session;
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
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          child: Image.asset(
                            "logo.png",
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 2),
                            child: const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Menjadi koperasi karyawan yang terpercaya dan unggul, dapat memberikan manfaat serta kesejahteraan anggota.",
                                  textAlign: TextAlign.center,
                                )))
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ButtonTheme(
                        minWidth: double.infinity,
                        height: 35.0,
                        child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/login');
                              },
                              child: const Text('Login Anggota', style: TextStyle(color: Colors.white)),
                            )))),
                // Container(
                //     width: double.infinity,
                //     margin: const EdgeInsets.only(bottom: 10),
                //     child: OutlinedButton(
                //       onPressed: () {
                //         Navigator.of(context).pushNamed('/register');
                //       },
                //       child: const Text('Daftar', style: TextStyle(color: Colors.green)),
                //     )),
                // InkWell(
                //   child: Text("Konfirmasi Pendaftaran",
                //       style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                //   onTap: () => Navigator.of(context).pushNamed('/confirm-transfer'),
                // )
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
      log(data['data']['umur'].toString());
      session.name_ = data['data']['name'];
      session.telepon = data['data']['telepon'].toString();
      session.noAnggota = data['data']['no_anggota'].toString();
      session.umur = data['data']['umur'].toString();
      session.tanggalAktif = data['data']['tanggal_aktif'].toString();
      session.kota = data['data']['kota'].toString();
    });
  }
}
