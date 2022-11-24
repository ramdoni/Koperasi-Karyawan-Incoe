import 'dart:developer';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'session.dart' as session;

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

Future initPlatformState() async {
  Map<String, dynamic> deviceData = <String, dynamic>{};

  try {
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
  } on PlatformException {
    deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
  }
  return deviceData;
}

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
  };
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}

Future<Response> getDataWithoutlogin(String url, Map<String, dynamic> data) async {
  var formData = FormData.fromMap(data);
  Dio dio = new Dio();

  return await dio.post(server_ip + url, data: formData);
}

final storage = FlutterSecureStorage();
// ignore: constant_identifier_names, non_constant_identifier_names
String server_ip = 'http://kki.stalavista.com/api';

/// Convert a color hex-string to a Color object.
Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}

void bottomInfo(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating, content: Text(msg)));
}

Future<Response> sendImage(String url, Map<String, dynamic> data, Map<String, dynamic> files) async {
  try {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      if (fileEntry.value != null) {
        String fileName = basename(file.path);
        fileMap[fileEntry.key] = MultipartFile(file.openRead(), await file.length(), filename: fileName);
      }
    }
    data.addAll(fileMap);

    var formData = FormData.fromMap(data);
    Dio dio = new Dio();
    if (session.token != null) dio.options.headers["Authorization"] = "Bearer " + session.token;

    return await dio.post(server_ip + url, data: formData);
  } on DioError catch (e) {
    if (e.type == DioErrorType.response) {
      log('catched');
      return null;
    }
    if (e.type == DioErrorType.connectTimeout) {
      log('check your connection');
      return null;
    }

    if (e.type == DioErrorType.receiveTimeout) {
      log('unable to connect to the server');
      return null;
    }

    if (e.type == DioErrorType.other) {
      log('Something went wrong');
      return null;
    }
    log('Others 1 : ' + e.toString());
  } catch (e) {
    log("Others 2 : " + e.toString());
  }
}

Future<Response> submitPendaftaran(String url, Map<String, dynamic> data, Map<String, File> files) async {
  try {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      if (fileEntry.value != null) {
        String fileName = basename(file.path);
        fileMap[fileEntry.key] = MultipartFile(file.openRead(), await file.length(), filename: fileName);
      }
    }
    data.addAll(fileMap);

    var formData = FormData.fromMap(data);
    Dio dio = new Dio();
    // dio.options.headers["Authorization"] = "Bearer " + session.token;
    log('url : ' + server_ip + url);

    return await dio.post(server_ip + url, data: formData);
  } on DioError catch (e) {
    if (e.type == DioErrorType.response) {
      log('catched');
      return null;
    }
    if (e.type == DioErrorType.connectTimeout) {
      log('check your connection');
      return null;
    }

    if (e.type == DioErrorType.receiveTimeout) {
      log('unable to connect to the server');
      return null;
    }

    if (e.type == DioErrorType.other) {
      log('Something went wrong');
      return null;
    }
    log('Others 1 : ' + e.toString());
  } catch (e) {
    log("Others 2 : " + e.toString());
  }
}

Future<Response> sendData(String url, Map<String, dynamic> data) async {
  var formData = FormData.fromMap(data);
  Dio dio = new Dio();
  dio.options.headers["Authorization"] = "Bearer " + session.token;

  return await dio.post(server_ip + url, data: formData);
}

Future<Response> submitLogin(String url, Map<String, dynamic> data) async {
  var formData = FormData.fromMap(data);
  Dio dio = new Dio();

  return await dio.post(server_ip + url, data: formData);
}

Future<Response> getDataNoLogin(String url) async {
  try {
    Dio dio = new Dio();
    // dio.options.headers["Authorization"] = "Bearer " + session.token;
    return await dio.get(server_ip + url);
  } on DioError catch (e) {
    if (e.type == DioErrorType.response) {
      throw Exception("Connection Timeout");
    }
    if (e.type == DioErrorType.connectTimeout) {
      throw Exception("check your connection");
    }

    if (e.type == DioErrorType.receiveTimeout) {
      throw Exception("Unable to connect to the server");
    }

    if (e.type == DioErrorType.other) {
      throw Exception("Something went wrong, please try again");
    }
  }
}

Future<Response> getData(String url) async {
  try {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer " + session.token;

    return await dio.get(server_ip + url);
  } on DioError catch (e) {
    if (e.type == DioErrorType.response) {
      throw Exception("Connection Timeout");
    }
    if (e.type == DioErrorType.connectTimeout) {
      throw Exception("check your connection");
    }

    if (e.type == DioErrorType.receiveTimeout) {
      throw Exception("Unable to connect to the server");
    }

    if (e.type == DioErrorType.other) {
      print(e);
      throw Exception(e);
    }
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(key: key, children: <Widget>[
                Center(
                  child: Column(children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please Wait....",
                      style: TextStyle(color: Colors.black),
                    )
                  ]),
                )
              ]));
        });
  }
}
