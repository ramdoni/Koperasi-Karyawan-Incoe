import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'helpers/util.dart';
import 'helpers/validation.dart';
import 'helpers/session.dart' as session;

final _storage = FlutterSecureStorage();

final GlobalKey<State> _keyLoader = new GlobalKey<State>();

class LauncherScreen extends StatefulWidget {
  @override
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
  bool isLogin = false;
  Widget build(context) {
    return Scaffold(
        backgroundColor: getColorFromHex("4ec9b2"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    (isLogin
                        ? Container(
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
                                    ))))
                        : Container(height: 0)),
                  ],
                ))),
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

          displayDialog(context, notification.title.toString(), notification.body.toString());
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        log('Message clicked!');
        setState(() {
          type_ = message.data['type'].toString();
        });
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
    _storage.readAll().then((result) {
      if (result['token'] != null) {
        setState(() {
          session.token = result['token'];
          log(session.token);
        });

        sendData('/refresh', {'token': session.token}).then((res) {
          log(res.data.toString());
          if (res.data['message'] == 'success') {
            setProfile(res.data);
            Navigator.of(context).pushNamed('/home');
          } else {
            setState(() {
              isLogin = true;
            });
            _storage.deleteAll();
          }
        });
      } else {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  void displayDialog(context, title, message) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              actions: [
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 50.0,
                  child: SizedBox(
                      height: 30.0,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getColorFromHex("4ec9b2"),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Oke"))),
                )
              ],
              title: Row(children: [
                Container(
                    margin: const EdgeInsets.only(right: 10.0), child: Icon(Icons.info, color: Colors.amber[800])),
                Text(title, style: TextStyle(fontSize: 16))
              ]),
              content: Text(message, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14))));

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
