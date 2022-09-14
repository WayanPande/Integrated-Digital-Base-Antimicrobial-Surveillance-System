import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project_pak_gusan/providers/doctors.dart';
import 'package:project_pak_gusan/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../util/data_drop_down.dart';
import '../widget/authentication_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPassShown = false;
  double heightSpacing = 25;
  int _jenisDokter = 1;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController lokasiPraktek = TextEditingController();

  String _selectedJenisSpesialis = "Spesialis Akupunktur Medik",
      _selectedKlinik = "Klinik Asih Usadha",
      _selectedRumahSakit = "RS Bali Royal",
      _selectedPuskesmas = "Puskesmas I Denpasar Utara",
      _selectedPoliklinik = "Klinik Utama Dharma Sidhi";


  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Wrap(
        children: [
          Center(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              child: const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    var doctor = Provider.of<Doctors>(context);

    doctor.newDoktor.jenisSpesialisId = dataSpesialis.indexOf(_selectedJenisSpesialis) + 1;
    doctor.newDoktor.klinikId = dataKlinik.indexOf(_selectedPoliklinik) + 1;
    doctor.newDoktor.rumahSakitId = dataRumahSakit.indexOf(_selectedRumahSakit) + 1;
    doctor.newDoktor.puskesmasId = dataPuskesmas.indexOf(_selectedPuskesmas) + 1;
    doctor.newDoktor.poliklinikId = dataKlinik.indexOf(_selectedPoliklinik) + 1;
    doctor.newDoktor.jenisDokter = _jenisDokter == 1 ? "Spesialis" : "Umum";

    nama.addListener(() {
      doctor.newDoktor.nama = nama.text;
    });

    email.addListener(() {
      doctor.newDoktor.email = email.text;
    });

    password.addListener(() {
      doctor.newDoktor.password = password.text;
    });

    lokasiPraktek.addListener(() {
      doctor.newDoktor.lokasiPraktek = lokasiPraktek.text;
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthenticationHeader(
              title: "Sign up.",
              description: "Sign up your new account",
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nama,
                      validator: (value){
                        if(value != null) {
                          if(value.isEmpty) {
                            return "Nama Tidak Boleh Kosong";
                          }
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    TextFormField(
                      controller: email,
                      validator: (value){
                        if(value != null) {
                          if(value.isEmpty) {
                            return "Email Tidak Boleh Kosong";
                          }

                          if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                            return "Format email salah";
                          }
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    TextFormField(
                      controller: password,
                      validator: (value){
                        if(value != null) {
                          if(value.isEmpty) {
                            return "Password Tidak Boleh Kosong";
                          }
                        }
                        return null;
                      },
                      obscureText: !isPassShown,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassShown = !isPassShown;
                            });
                          },
                          icon: Icon(
                            isPassShown ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    const Text(
                      "Jenis Dokter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: _jenisDokter,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _jenisDokter = 1;
                                });
                              },
                            ),
                            const Text(
                              "Spesialis",
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: _jenisDokter,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _jenisDokter = 2;
                                });
                              },
                            ),
                            const Text(
                              "Umum",
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    const Text(
                      "Jenis Spesialis",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: DropdownButton(
                          value: _selectedJenisSpesialis,
                          items: dataSpesialis
                              .map((code) => DropdownMenuItem(
                              value: code, child: Text(code)))
                              .toList(),
                          onChanged: (index) {
                            setState(() {
                              _selectedJenisSpesialis = index.toString();
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    TextFormField(
                      controller: lokasiPraktek,
                      validator: (value){
                        if(value != null) {
                          if(value.isEmpty) {
                            return "Lokasi Praktek Tidak Boleh Kosong";
                          }
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Lokasi Praktek Pribadi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    const Text(
                      "Klinik",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: DropdownButton(
                          value: _selectedKlinik,
                          items: dataKlinik
                              .map((code) => DropdownMenuItem(
                              value: code, child: Text(code)))
                              .toList(),
                          onChanged: (index) {
                            setState(() {
                              _selectedKlinik = index.toString();
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    const Text(
                      "Rumah Sakit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: DropdownButton(
                          value: _selectedRumahSakit,
                          items: dataRumahSakit
                              .map((code) => DropdownMenuItem(
                              value: code, child: Text(code)))
                              .toList(),
                          onChanged: (index) {
                            setState(() {
                              _selectedRumahSakit = index.toString();
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    const Text(
                      "Poliklinik",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: DropdownButton(
                          value: _selectedPoliklinik,
                          items: dataKlinik
                              .map((code) => DropdownMenuItem(
                              value: code, child: Text(code)))
                              .toList(),
                          onChanged: (index) {
                            setState(() {
                              _selectedPoliklinik = index.toString();
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    const Text(
                      "Puskesmas",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        child: DropdownButton(
                          value: _selectedPuskesmas,
                          items: dataPuskesmas
                              .map((code) => DropdownMenuItem(
                              value: code, child: Text(code)))
                              .toList(),
                          onChanged: (index) {
                            setState(() {
                              _selectedPuskesmas = index.toString();
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){

                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  dismissOnTouchOutside: false,
                                  animType: AnimType.bottomSlide,
                                  title: 'Apakah anda yakin ?',
                                  desc: 'Tekan tombol ya untuk melanjutkan',
                                  btnOkText: "Ya, lanjutkan",
                                  btnCancel: TextButton(
                                    child: const Text("cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  btnOkColor: const Color(0xFF20BDB7),
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    showLoaderDialog(context);
                                    doctor.addDokter().then(
                                          (_) {
                                        Navigator.of(context).pop();
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          dismissOnTouchOutside: false,
                                          animType: AnimType.bottomSlide,
                                          title: 'Akun berhasil dibuat !',
                                          autoHide: const Duration(seconds: 3),
                                          btnOkColor: const Color(0xFF20BDB7),
                                          onDismissCallback: (e) {
                                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                            const LoginScreen()), (Route<dynamic> route) => false);
                                          },
                                          btnOkOnPress: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const LoginScreen();
                                                },
                                              ),
                                            );
                                          },
                                        ).show();
                                      },
                                    );
                                  },
                                ).show();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightSpacing,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sudah memiliki akun ?",
                          style: TextStyle(
                            color: Color(0xFFAFA1A1),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Color(0xFF20BDB7),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
