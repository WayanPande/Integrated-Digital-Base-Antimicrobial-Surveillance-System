import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_pak_gusan/providers/patients.dart';
import 'package:project_pak_gusan/screens/add_patien_riwayat_screen.dart';
import 'package:project_pak_gusan/screens/profile_patien_screen.dart';
import 'package:provider/provider.dart';

class AddPatienIdentitas extends StatefulWidget {
  const AddPatienIdentitas({Key? key}) : super(key: key);

  @override
  State<AddPatienIdentitas> createState() => _AddPatienIdentitasState();
}

class _AddPatienIdentitasState extends State<AddPatienIdentitas> {
  TextEditingController tanggalLahir = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController komorbid = TextEditingController();

  final List<String> jenisKelamin = ["Laki - Laki", "Wanita"];

  String _selectedJenisKelamin = "Laki - Laki", tanggalLahirSend = "";

  bool helper = true;

  final _formKey = GlobalKey<FormState>();


  void setInitialDataForUpdatingPasien(Map<String, dynamic> data) {
    nama.text = data["name"];
    noHp.text = data["no_hp"].toString();
    tanggalLahir.text = DateFormat('dd, MMMM yyyy')
        .format(DateTime.parse(data['tanggal_lahir']));
    alamat.text = data['alamat'];
    komorbid.text = data['komorbid'];
  }

  @override
  void initState() {
    setState(() {
      helper = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pasien = Provider.of<Patiens>(context, listen: false);

    if (pasien.isEditing && helper) {
      setInitialDataForUpdatingPasien(pasien.pasienDetail);
      setState(() {
        helper = false;
      });
    }

    nama.addListener(() {
      pasien.name = nama.text;
    });

    tanggalLahir.addListener(() {
      pasien.tanggalLahir = tanggalLahir.text;
    });

    noHp.addListener(() {
      pasien.noHp = noHp.text;
    });

    alamat.addListener(() {
      pasien.alamat = alamat.text;
    });

    komorbid.addListener(() {
      pasien.komorbid = komorbid.text;
    });

    pasien.gender = _selectedJenisKelamin;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          pasien.isEditing ? "Ubah Data Pasien" : "Tambah Pasien Baru",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Integrated Digital - Base Antimicrobial Surveillance System (IDAAS)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Identitas Pasien",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: nama,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value){
                    if(value != null) {
                      if(value.isEmpty) {
                        return "Nama Tidak Boleh Kosong";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value){
                    if(value != null) {
                      if(value.isEmpty) {
                        return "Tanggal Lahir Tidak Boleh Kosong";
                      }
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                      DateFormat('dd, MMMM yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        tanggalLahir.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                  readOnly: true,
                  controller: tanggalLahir,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Lahir',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value){
                    if(value != null) {
                      if(value.isEmpty) {
                        return "No Hp Tidak Boleh Kosong";
                      }

                      if(int.tryParse(value) == null){
                        return "No Hp Harus Angka";
                      }
                    }
                    return null;
                  },
                  controller: noHp,
                  decoration: const InputDecoration(
                    labelText: 'No Handphone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Jenis Kelamin",
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
                      value: _selectedJenisKelamin,
                      items: jenisKelamin
                          .map((code) =>
                          DropdownMenuItem(value: code, child: Text(code)))
                          .toList(),
                      onChanged: (index) {
                        setState(() {
                          _selectedJenisKelamin = index.toString();
                        });
                        pasien.gender = index.toString();
                      },
                      isExpanded: true,
                      underline: Container(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value){
                    if(value != null) {
                      if(value.isEmpty) {
                        return "Alamat Tidak Boleh Kosong";
                      }
                    }
                    return null;
                  },
                  controller: alamat,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value){
                    if(value != null) {
                      if(value.isEmpty) {
                        return "Komorbid Tidak Boleh Kosong";
                      }
                    }
                    return null;
                  },
                  controller: komorbid,
                  decoration: const InputDecoration(
                    labelText: 'Ada Komorbid ?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  maxLines: 4,
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {

                        if(_formKey.currentState!.validate()){
                          if (pasien.isEditing) {
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
                                pasien.updatePasien().then(
                                      (_) {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      dismissOnTouchOutside: false,
                                      animType: AnimType.bottomSlide,
                                      title: 'Pasien berhasil diupdate !',
                                      autoHide: const Duration(seconds: 3),
                                      btnOkColor: const Color(0xFF20BDB7),
                                      onDismissCallback: (e) {
                                        Navigator.of(context).pop();
                                      },
                                      btnOkOnPress: () {
                                        Navigator.pop(context);
                                      },
                                    ).show();
                                  },
                                );
                              },
                            ).show();
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const AddPatienRiwayat();
                                },
                              ),
                            );
                          }
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                      ),
                      child: Text(
                        pasien.isEditing ? "Update" : "Selanjutnya",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
