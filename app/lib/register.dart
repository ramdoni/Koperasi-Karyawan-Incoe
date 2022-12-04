import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'helpers/util.dart';
import 'helpers/validation.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> with Validation {
  final formKey = GlobalKey<FormState>();
  final formKeyAhliwaris1 = GlobalKey<FormState>();
  final formKeyAhliwaris2 = GlobalKey<FormState>();
  final TextEditingController _controllerTanggalLahir = TextEditingController();
  final TextEditingController _controllerTanggalLahirWaris1 = TextEditingController();
  final TextEditingController _controllerTanggalLahirWaris2 = TextEditingController();
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  XFile fotoKtp, fotoKk, pasphoto, waris1FotoKtp, waris2FotoKtp;
  final ImagePicker _picker = ImagePicker();
  // Data Pribadi
  int checkNoKtp = 0, umur = 0, uangPendaftaran = 0, sumbangan;
  String noKtp,
      email,
      alamat,
      noAnggotaGold,
      nama,
      referalCode,
      tempatLahir,
      tanggalLahir,
      golonganDarah,
      jenisKelamin,
      telepon,
      kotaKabupaten,
      iuranTetap;

  // Ahli waris1 variable
  String waris1Nama,
      waris1Ktp,
      waris1TempatLahir,
      waris1Alamat,
      waris1TanggalLahir,
      waris1NoTelp,
      waris1JenisKelamin,
      waris1GolonganDarah,
      waris1Hubungan;

  // Ahli waris2 variable
  String waris2Nama,
      waris2Ktp,
      waris2TempatLahir,
      waris2Alamat,
      waris2TanggalLahir,
      waris2NoTelp,
      waris2JenisKelamin,
      waris2GolonganDarah,
      waris2Hubungan;

  bool isSubmited = false;
  int _selectedIndex = 0; //New
  Widget field_(str, Widget input) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Align(alignment: Alignment.topLeft, child: Text(str, textAlign: TextAlign.left)),
          Container(margin: EdgeInsets.only(top: 10), child: input)
        ]));
  }

  void callDatePicker() async {
    var tempDate = await getDate();
    setState(() {
      tanggalLahir = tempDate.year.toString() + "-" + tempDate.month.toString() + "-" + tempDate.day.toString();
      _controllerTanggalLahir.text = tanggalLahir;
      ageCalculate((tempDate.day.toString().length == 1 ? "0" + tempDate.day.toString() : tempDate.day.toString()) +
          "-" +
          (tempDate.month.toString().length == 1 ? "0" + tempDate.month.toString() : tempDate.month.toString()) +
          "-" +
          tempDate.year.toString());
    });
  }

  void tanggalLahirWaris1Picker() async {
    var tempDate = await getDate();
    setState(() {
      waris1TanggalLahir = tempDate.year.toString() + "-" + tempDate.month.toString() + "-" + tempDate.day.toString();
      _controllerTanggalLahirWaris1.text = waris1TanggalLahir;
      waris1TanggalLahir = tempDate.toString();
    });
  }

  void tanggalLahirWaris2Picker() async {
    var tempDate = await getDate();
    setState(() {
      waris2TanggalLahir = tempDate.year.toString() + "-" + tempDate.month.toString() + "-" + tempDate.day.toString();
      _controllerTanggalLahirWaris2.text = waris2TanggalLahir;
      waris2TanggalLahir = tempDate.toString();
    });
  }

  Future<DateTime> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1945, 1, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  void _chooseWaris1Ktp() async {
    try {
      var file =
          await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
      setState(() {
        waris1FotoKtp = file;
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  void _chooseWaris2Ktp() async {
    try {
      var file =
          await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
      setState(() {
        waris2FotoKtp = file;
      });
    } catch (error) {}
  }

  void _choosePasphoto() async {
    try {
      var file =
          await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
      setState(() {
        pasphoto = file;
      });
    } catch (error) {}
  }

  void _chooseFotoKtp() async {
    try {
      var file =
          await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
      setState(() {
        fotoKtp = file;
      });
    } catch (error) {}
  }

  void _chooseFotoKk() async {
    try {
      var file =
          await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
      setState(() {
        fotoKk = file;
      });
    } catch (error) {}
  }

  //New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  RegExp regExp = RegExp(
    r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$",
    caseSensitive: true,
    multiLine: false,
  );

  int ageCalculate(input) {
    log('tanggal lahir : ' + input);
    if (regExp.hasMatch(input)) {
      DateTime _dateTime = DateTime(
        int.parse(input.substring(6)),
        int.parse(input.substring(3, 5)),
        int.parse(input.substring(0, 2)),
      );
      setState(() {
        umur = DateTime.fromMillisecondsSinceEpoch(DateTime.now().difference(_dateTime).inMilliseconds).year - 1970;
      });
    } else {
      return -1;
    }
  }

  void findNoKtp() async {
    if (noKtp == null) return;
    getDataWithoutlogin('/find-no-ktp', {'no_ktp': noKtp}).then((res) {
      setState(() {
        checkNoKtp = res.data['message'];
      });
    }, onError: (exception) {
      if (exception.message != null) {
        bottomInfo(context, exception.message.toString());
      }
    });
  }

  Widget dataPribadi() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(5),
            child: Form(
                key: formKey,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: const Text("Data Pribadi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Column(children: [
                        Align(alignment: Alignment.topLeft, child: Text("No KTP", textAlign: TextAlign.left)),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "No KTP harus diisi";
                              }
                              return null;
                            },
                            style: TextStyle(fontWeight: FontWeight.normal),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                hintText: ""),
                            onChanged: (value) {
                              setState(() {
                                noKtp = value;
                                checkNoKtp = 0;
                              });
                            },
                          ),
                        ),
                        (checkNoKtp == 0
                            ? Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    child: InkWell(
                                  child: Row(children: const [
                                    Icon(Icons.check, color: Colors.blue, size: 20),
                                    Text("Check No KTP", style: TextStyle(color: Colors.blue))
                                  ]),
                                  onTap: findNoKtp,
                                )))
                            : (Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    child: Text(
                                        (checkNoKtp == 1
                                            ? "No KTP sudah digunakan silahkan menghubungi kantor Santa Maria"
                                            : "NO KTP bisa digunakan"),
                                        style: TextStyle(color: checkNoKtp == 1 ? Colors.red : Colors.green))))))
                      ])),
                  field_(
                      "Nama (sesuai KTP) *",
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Nama harus diisi";
                          }
                          return null;
                        },
                        style: TextStyle(fontWeight: FontWeight.normal),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                            hintText: ""),
                        onChanged: (value) {
                          setState(() {
                            nama = value;
                          });
                        },
                      )),
                  field_(
                      "Referal Code",
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (val) {
                          return null;
                        },
                        style: TextStyle(fontWeight: FontWeight.normal),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                            hintText: ""),
                        onChanged: (value) {
                          setState(() {
                            referalCode = value;
                          });
                        },
                      )),
                  field_(
                      "Email *",
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        maxLines: null,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Email harus diisi";
                          }
                          return null;
                        },
                        style: TextStyle(fontWeight: FontWeight.normal),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                            hintText: ""),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      )),
                  Container(
                      child: Row(
                    children: [
                      Expanded(
                        child: field_(
                            "Tempat Lahir *",
                            TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Email harus diisi";
                                }
                                return null;
                              },
                              style: TextStyle(fontWeight: FontWeight.normal),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                  contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                  hintText: ""),
                              onChanged: (value) {
                                setState(() {
                                  tempatLahir = value;
                                });
                              },
                            )),
                      ),
                      Expanded(
                        child: field_(
                            "Tanggal Lahir *" + (umur != 0 ? umur.toString() + "Tahun" : ''),
                            TextFormField(
                              keyboardType: TextInputType.none,
                              maxLines: null,
                              controller: _controllerTanggalLahir,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Tanggal lahir harus diisi";
                                }
                                return null;
                              },
                              style: TextStyle(fontWeight: FontWeight.normal),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                                  contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                                  hintText: ""),
                              onTap: callDatePicker,
                            )),
                      ),
                    ],
                  )),
                  (umur >= 65
                      ? Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                              "Batas usia anda melebihi ketentuan kami, silahkan mendaftar langsung ke kantor Santa Maria",
                              style: TextStyle(color: Colors.red)))
                      : Text("")),
                  field_(
                      "Alamat *",
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        maxLines: null,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Alamat harus diisi";
                          }
                          return null;
                        },
                        style: TextStyle(fontWeight: FontWeight.normal),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                            hintText: ""),
                        onChanged: (value) {
                          setState(() {
                            alamat = value;
                          });
                        },
                      )),
                  field_(
                      "Kota / Kabupaten *",
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 8),
                          padding: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            hint:
                                Text(" --- Pilih --- ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                            value: kotaKabupaten,
                            underline: Container(),
                            items: [
                              'Kota Semarang',
                              'Kabupaten Semarang',
                              'Kota Salatiga',
                              'Kabupaten Kendal',
                              'Kabupaten Purwodadi',
                              'Lainnya'
                            ].map((item) {
                              return DropdownMenuItem(
                                child: Text(item, style: TextStyle(fontWeight: FontWeight.normal)),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (value) {
                              log(value.toString());
                              setState(() {
                                kotaKabupaten = value;
                              });
                            },
                          ))),
                  field_(
                    "Jenis Kelamin *",
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 8),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(" --- Pilih --- ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                          value: jenisKelamin,
                          underline: Container(),
                          items: ['Laki-laki', 'Perempuan'].map((item) {
                            return DropdownMenuItem(
                              child: Text(item, style: TextStyle(fontWeight: FontWeight.normal)),
                              value: item,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              jenisKelamin = value;
                            });
                          },
                        )),
                  ),
                  field_(
                      "No Telp/HP *",
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLines: null,
                        validator: (val) {
                          return null;
                        },
                        style: const TextStyle(fontWeight: FontWeight.normal),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                            hintText: ""),
                        onChanged: (value) {
                          setState(() {
                            telepon = value;
                          });
                        },
                      )),
                  field_(
                    "Golongan Darah",
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 8),
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text(" --- Pilih --- ",
                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                          value: golonganDarah,
                          underline: Container(),
                          items: ['O', 'A', 'B', 'AB'].map((item) {
                            return DropdownMenuItem(
                              child: Text(item, style: TextStyle(fontWeight: FontWeight.normal)),
                              value: item,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              golonganDarah = value;
                            });
                          },
                        )),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              child: Column(children: [
                        const Text("Foto KTP *"),
                        (fotoKtp == null
                            ? Container(
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.only(top: 10.0),
                                decoration: BoxDecoration(border: Border.all(width: 1.0, color: Color(0xFFEBE6E6FF))),
                                child: IconButton(
                                  icon: Icon(Icons.camera_alt_sharp),
                                  tooltip: 'Take Photo',
                                  onPressed: _chooseFotoKtp,
                                ))
                            : InkWell(
                                child: Container(
                                    child: Image.file(
                                  File(fotoKtp.path),
                                  width: 80,
                                  fit: BoxFit.fitWidth,
                                )),
                                onTap: _chooseFotoKtp,
                              ))
                      ]))),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Column(children: [
                                Text("Foto KK *"),
                                (fotoKk == null
                                    ? Container(
                                        padding: EdgeInsets.all(10.0),
                                        margin: EdgeInsets.only(top: 10.0),
                                        decoration:
                                            BoxDecoration(border: Border.all(width: 1.0, color: Color(0xFFEBE6E6FF))),
                                        child: IconButton(
                                          icon: Icon(Icons.camera_alt_sharp),
                                          tooltip: 'Take Photo',
                                          onPressed: _chooseFotoKk,
                                        ))
                                    : InkWell(
                                        child: Container(
                                            child: Image.file(
                                          File(fotoKk.path),
                                          width: 80,
                                          fit: BoxFit.fitWidth,
                                        )),
                                        onTap: _chooseFotoKk))
                              ]))),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Column(children: [
                                Text("Pasphoto 4x6 *"),
                                (pasphoto == null
                                    ? Container(
                                        padding: EdgeInsets.all(10.0),
                                        margin: EdgeInsets.only(top: 10.0),
                                        decoration:
                                            BoxDecoration(border: Border.all(width: 1.0, color: Color(0xFFEBE6E6FF))),
                                        child: IconButton(
                                          icon: Icon(Icons.camera_alt_sharp),
                                          tooltip: 'Take Photo',
                                          onPressed: _choosePasphoto,
                                        ))
                                    : InkWell(
                                        child: Container(
                                            child: Image.file(
                                          File(pasphoto.path),
                                          width: 80,
                                          fit: BoxFit.fitWidth,
                                        )),
                                        onTap: _choosePasphoto))
                              ])))
                    ],
                  ),
                  field_(
                      "Uang pendaftaran Min (Rp. 50.000) *",
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Uang pendaftaran harus diisi";
                          }
                          return null;
                        },
                        style: TextStyle(fontWeight: FontWeight.normal),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                            hintText: ""),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) uangPendaftaran = int.parse(value.toString());
                          });
                        },
                      )),
                  field_(
                      "Sumbangan",
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        validator: (val) {},
                        style: TextStyle(fontWeight: FontWeight.normal),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                            contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                            hintText: ""),
                        onChanged: (value) {
                          setState(() {
                            if (value != null) sumbangan = value as int;
                          });
                        },
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(children: [
                        Text("Dana Form : "),
                        Text("Rp. 5.000", style: TextStyle(fontWeight: FontWeight.bold))
                      ])),
                  profileButton(),
                ])))
      ],
    );
  }

  Widget ahliWaris1() {
    return Container(
        padding: const EdgeInsets.all(5),
        child: Form(
            key: formKeyAhliwaris1,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 10),
                child: const Text("Ahli Waris 1", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              ),
              field_(
                  "Nama (sesuai KTP) *",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Nama harus diisi";
                      }
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris1Nama = value;
                      });
                    },
                  )),
              field_(
                  "No KTP *",
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "No Ktp harus diisi";
                      }
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris1Ktp = value;
                      });
                    },
                  )),
              field_(
                  "Tempat Lahir",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris1TempatLahir = value;
                      });
                    },
                  )),
              field_(
                  "Alamat",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris1Alamat = value;
                      });
                    },
                  )),
              field_(
                  "Tanggal Lahir",
                  TextFormField(
                    keyboardType: TextInputType.none,
                    maxLines: null,
                    controller: _controllerTanggalLahirWaris1,
                    validator: (val) {
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onTap: tanggalLahirWaris1Picker,
                  )),
              field_(
                  "No Telp / HP *",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris1NoTelp = value;
                      });
                    },
                  )),
              Container(
                  child: Row(children: [
                Expanded(
                  child: field_(
                    "Jenis Kelamin",
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 8),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(" --- Pilih --- ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                          value: waris1JenisKelamin,
                          underline: Container(),
                          items: <String>['Laki-laki', 'Perempuan'].map((item) {
                            return DropdownMenuItem(
                              child: Text(item, style: TextStyle(fontWeight: FontWeight.normal)),
                              value: item,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              waris1JenisKelamin = value;
                            });
                          },
                        )),
                  ),
                ),
                Expanded(
                    child: field_(
                        "Golongan Darah",
                        Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 8),
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: const Text(" --- Pilih --- ",
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                              value: waris1GolonganDarah,
                              underline: Container(),
                              items: <String>['O', 'A', 'B', 'AB'].map((item) {
                                return DropdownMenuItem(
                                  child: Text(item, style: const TextStyle(fontWeight: FontWeight.normal)),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  waris1GolonganDarah = value;
                                });
                              },
                            ))))
              ])),
              field_(
                  "Hubungan dengan Anggota",
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 8),
                      padding: const EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: const Text(" --- Pilih --- ",
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                        value: waris1Hubungan,
                        underline: Container(),
                        items: <String>['Suami', 'Istri', 'Anak', 'Orang Tua', 'Lainnya'].map((item) {
                          return DropdownMenuItem(
                            child: Text(item, style: const TextStyle(fontWeight: FontWeight.normal)),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            waris1Hubungan = value;
                          });
                        },
                      ))),
              const Text("Foto KTP"),
              (waris1FotoKtp == null
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(border: Border.all(width: 1.0, color: const Color(0xFFEBE6E6FF))),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt_sharp),
                        tooltip: 'Take Photo',
                        onPressed: _chooseWaris1Ktp,
                      ))
                  : InkWell(
                      child: Container(
                          child: Image.file(
                        File(waris1FotoKtp.path),
                        width: 80,
                        fit: BoxFit.fitWidth,
                      )),
                      onTap: _chooseWaris1Ktp)),
              ahliwaris1Button()
            ])));
  }

  Widget ahliWaris2() {
    return Container(
        padding: EdgeInsets.all(5),
        child: Form(
            key: formKeyAhliwaris2,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 10),
                child: const Text("Ahli Waris2 ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              ),
              field_(
                  "Nama (sesuai KTP)",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Nama harus diisi";
                      }
                      return null;
                    },
                    style: const TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris2Nama = value;
                      });
                    },
                  )),
              field_(
                  "No KTP",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "No KTP harus diisi";
                      }
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris2Ktp = value;
                      });
                    },
                  )),
              field_(
                  "Tempat Lahir",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris2TempatLahir = value;
                      });
                    },
                  )),
              field_(
                  "Alamat",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris2Alamat = value;
                      });
                    },
                  )),
              field_(
                  "Tanggal Lahir",
                  TextFormField(
                    keyboardType: TextInputType.none,
                    maxLines: null,
                    controller: _controllerTanggalLahirWaris2,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Tanggal lahir harus diisi";
                      }
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onTap: tanggalLahirWaris2Picker,
                  )),
              field_(
                  "No Telp / HP",
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "No Telp / HP harus diisi";
                      }
                      return null;
                    },
                    style: TextStyle(fontWeight: FontWeight.normal),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 13.0),
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 5, left: 10),
                        hintText: ""),
                    onChanged: (value) {
                      setState(() {
                        waris2NoTelp = value;
                      });
                    },
                  )),
              Container(
                  child: Row(
                children: [
                  Expanded(
                    child: field_(
                        "Jenis Kelamin",
                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 8),
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: const Text(" --- Pilih --- ",
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                              value: waris2JenisKelamin,
                              underline: Container(),
                              items: <String>['Laki-laki', 'Perempuan'].map((item) {
                                return DropdownMenuItem(
                                  child: Text(item, style: TextStyle(fontWeight: FontWeight.normal)),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  waris2JenisKelamin = value;
                                });
                              },
                            ))),
                  ),
                  Expanded(
                    child: field_(
                        "Golongan Darah",
                        Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 8),
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              hint: const Text(" --- Pilih --- ",
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                              value: waris2GolonganDarah,
                              underline: Container(),
                              items: <String>['O', 'A', 'B', 'AB'].map((item) {
                                return DropdownMenuItem(
                                  child: Text(item, style: const TextStyle(fontWeight: FontWeight.normal)),
                                  value: item,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  waris2GolonganDarah = value;
                                });
                              },
                            ))),
                  )
                ],
              )),
              field_(
                  "Hubungan dengan Anggota",
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 8),
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: const Text(" --- Pilih --- ",
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13)),
                        value: waris2Hubungan,
                        underline: Container(),
                        items: <String>['Suami', 'Istri', 'Anak', 'Orang Tua', 'Lainnya'].map((item) {
                          return DropdownMenuItem(
                            child: Text(item, style: TextStyle(fontWeight: FontWeight.normal)),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            waris2Hubungan = value;
                          });
                        },
                      ))),
              const Text("Foto KTP"),
              (waris2FotoKtp == null
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(border: Border.all(width: 1.0, color: const Color(0xFFEBE6E6FF))),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt_sharp),
                        tooltip: 'Take Photo',
                        onPressed: _chooseWaris2Ktp,
                      ))
                  : InkWell(
                      child: Container(
                          child: Image.file(
                        File(waris2FotoKtp.path),
                        width: 80,
                        fit: BoxFit.fitWidth,
                      )),
                      onTap: _chooseWaris2Ktp)),
              ahliwaris2Button()
            ])));
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10),
          child: Column(children: [
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey[400]),
                ),
              ),
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Column(
                    children: [
                      Image.asset("logo.png", width: 153.0, height: 52.0),
                      const Text("Yayasan Sosial Santa Maria", style: TextStyle(fontSize: 20)),
                      const Text("Jl. Citarum Tengah Ruko E-1\nTelp: 024-354 4085 Semarang 50126")
                    ],
                  )),
            ),
            IndexedStack(index: _selectedIndex, children: <Widget>[dataPribadi(), ahliWaris1(), ahliWaris2()])
            // pageAcive()
          ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Data Pribadi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Ahli Waris1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Ahli Waris 2',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void displayDialogSuccess(context, title, message) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Row(children: [
                Container(
                    margin: const EdgeInsets.only(right: 10.0), child: Icon(Icons.warning, color: Colors.amber[800])),
                Text(title)
              ]),
              content: Text(message, style: const TextStyle(fontWeight: FontWeight.normal)))).then((val) {
        Navigator.of(context).pushNamed('/');
      });

  void displayDialog(context, title, message) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Row(children: [
            Container(margin: const EdgeInsets.only(right: 10.0), child: Icon(Icons.warning, color: Colors.amber[800])),
            Text(title)
          ]),
          content: Text(message, style: const TextStyle(fontWeight: FontWeight.normal))));

  // Widget Button
  Widget daftarButton() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: ButtonTheme(
            minWidth: double.infinity,
            height: 40.0,
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      setState(() {
                        isSubmited = true;
                      });
                    }
                  },
                  child: (isSubmited
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : const Text('Daftar', style: TextStyle(color: Colors.white))),
                ))));
  }

  Widget profileButton() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: ButtonTheme(
            minWidth: double.infinity,
            height: 40.0,
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    isSubmited = true;

                    if (formKey.currentState.validate()) {
                      if (uangPendaftaran < 50000) {
                        bottomInfo(context, "Uang pendaftaran minimal Rp. 50.000,");
                        setState(() {
                          isSubmited = false;
                        });
                        return;
                      }
                      if (fotoKtp == null) {
                        bottomInfo(context, "Foto KTP harus diisi");
                        setState(() {
                          isSubmited = false;
                        });
                        return;
                      }
                      if (fotoKk == null) {
                        bottomInfo(context, "Foto Kk harus diisi");
                        setState(() {
                          isSubmited = false;
                        });
                        return;
                      }
                      if (pasphoto == null) {
                        bottomInfo(context, "Pasphoto harus diisi");
                        setState(() {
                          isSubmited = false;
                        });
                        return;
                      }
                      if (umur >= 65) {
                        bottomInfo(context,
                            "Batas usia anda melebihi ketentuan kami, silahkan mendaftar langsung ke kantor Santa Maria");
                        setState(() {
                          isSubmited = false;
                        });
                        return;
                      }
                      findNoKtp();
                      if (checkNoKtp >= 65) {
                        bottomInfo(context, "No KTP sudah digunakan silahkan menghubungi kantor Santa Maria");
                        setState(() {
                          isSubmited = false;
                        });

                        return;
                      }
                      setState(() {
                        isSubmited = false;
                        _selectedIndex = 1;
                      });
                    } else {
                      setState(() {
                        isSubmited = false;
                      });
                    }
                  },
                  child: (isSubmited
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : const Text('Berikutnya Ahli Waris 1', style: TextStyle(color: Colors.white))),
                ))));
  }

  Widget ahliwaris1Button() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: ButtonTheme(
            minWidth: double.infinity,
            height: 40.0,
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKeyAhliwaris1.currentState.validate()) {
                      setState(() {
                        isSubmited = false;
                        _selectedIndex = 2;
                      });
                    }
                  },
                  child: (isSubmited
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : const Text('Berikutnya Ahli Waris 2', style: TextStyle(color: Colors.white))),
                ))));
  }

  Widget ahliwaris2Button() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        child: ButtonTheme(
            minWidth: double.infinity,
            height: 40.0,
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSubmited = true;
                    });
                    log('submit pendaftaran');

                    // if (formKeyAhliwaris2.currentState.validate()) {
                    submitPendaftaran('/submit-pendaftaran', {
                      'Id_Ktp': noKtp,
                      'no_anggota_gold': noAnggotaGold,
                      'name': nama,
                      'referal_code': referalCode,
                      'email': email,
                      'tempat_lahir': tempatLahir,
                      'tanggal_lahir': tanggalLahir,
                      'address': alamat,
                      'city': kotaKabupaten,
                      'city_lainnya': '',
                      'jenis_kelamin': jenisKelamin,
                      'phone_number': telepon,
                      'blood_type': golonganDarah,
                      'iuran_tetap': iuranTetap,
                      'sumbangan': sumbangan,
                      'uang_pendaftaran': uangPendaftaran,
                      'name_waris1': waris1Nama,
                      'tempat_lahirwaris1': waris1TempatLahir,
                      'Id_Ktpwaris1': waris1Ktp,
                      'address_waris1': waris1Alamat,
                      'tanggal_lahirwaris1': waris1TanggalLahir,
                      'phone_numberwaris1': waris1NoTelp,
                      'jenis_kelaminwaris1': waris1JenisKelamin,
                      'blood_typewaris1': waris1GolonganDarah,
                      'hubungananggota1': waris1Hubungan,
                      'hubungananggota1_lainnya': '',
                      'name_waris2': waris2Nama,
                      'tempat_lahirwaris2': waris2TempatLahir,
                      'Id_Ktpwaris2': waris2Ktp,
                      'address_waris2': waris2Alamat,
                      'tanggal_lahirwaris2': waris2TanggalLahir,
                      'phone_numberwaris2': waris2NoTelp,
                      'jenis_kelaminwaris2': waris2JenisKelamin,
                      'blood_typewaris2': waris2GolonganDarah,
                      'hubungananggota2': waris2Hubungan,
                      'hubungananggota2_lainnya': ''
                    }, {
                      'foto_ktp': (fotoKtp != null ? File(fotoKtp.path) : null),
                      'foto_kk': (fotoKk != null ? File(fotoKk.path) : null),
                      'pas_foto': (pasphoto != null ? File(pasphoto.path) : null),
                      'foto_ktpwaris1': (waris1FotoKtp != null ? File(waris1FotoKtp.path) : null),
                      'foto_ktpwaris2': (waris2FotoKtp != null ? File(waris2FotoKtp.path) : null)
                    }).then((value) {
                      log(value.data.toString());
                      if (value.data['status'] == 'success') {
                        displayDialogSuccess(context, "Berhasil",
                            "Terima kasih telah mendaftarkan diri anda sebagai Anggota Yayasan Sosial Santa Maria. Data diri anda akan segera kami proses setelah pembayaran kami terima. Silahkan cek email anda untuk mendapatkan informasi pembayaran.");
                      } else {
                        bottomInfo(context, value.data['message']);
                      }
                      setState(() {
                        isSubmited = false;
                      });
                    }, onError: (exception) {
                      if (exception.message != null) {
                        bottomInfo(context, exception.message.toString());
                      }
                      setState(() {
                        isSubmited = false;
                      });
                    });
                  },
                  child: (isSubmited
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : const Text('Submit Pendaftaran', style: TextStyle(color: Colors.white))),
                ))));
  }
}
