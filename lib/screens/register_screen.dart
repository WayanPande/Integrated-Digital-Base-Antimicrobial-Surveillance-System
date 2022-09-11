import 'package:flutter/material.dart';
import 'package:project_pak_gusan/screens/login_screen.dart';
import 'package:project_pak_gusan/service/http_service.dart';

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


  String _selectedJenisSpesialis = "Spesialis Akupunktur Medik", _selectedKlinik = "Klinik Asih Usadha", _selectedRumahSakit = "RS Bali Royal", _selectedPuskesmas = "Puskesmas I Denpasar Utara", _selectedPoliklinik = "Klinik Utama Dharma Sidhi";

  final HttpService httpService = HttpService();

  @override
  void initState() {
    super.initState();
    httpService.getKlinik();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
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
                          onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
