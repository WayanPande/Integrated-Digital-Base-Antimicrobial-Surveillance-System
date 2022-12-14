import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:project_pak_gusan/screens/home_screen.dart';
import 'package:project_pak_gusan/util/data_drop_down.dart';
import 'package:provider/provider.dart';

import '../providers/antibiotik.dart';
import '../providers/patients.dart';
import '../util/data_class.dart';

class AddPatienAntibiotik extends StatefulWidget {
  const AddPatienAntibiotik({Key? key}) : super(key: key);

  @override
  State<AddPatienAntibiotik> createState() => _AddPatienAntibiotikState();
}

class _AddPatienAntibiotikState extends State<AddPatienAntibiotik> {
  bool _diberikanAntibiotik = false,
      _kombinasiAntibiotik = false,
      _antibiotikLain = false,
      _reaksiAlergi = false,
      _efekSamping = false;

  TextEditingController deskripsiReaksi = TextEditingController();
  TextEditingController deskripsiEfekSamping = TextEditingController();

  final List<String> jalurPemberian = [
    "Oral",
    "IV",
    "IM",
    "Parental",
    "Topikal"
  ];
  String _selectedJalurPemberian = "Oral",
      _selectedNamaAntibiotik = "Aldesulfone sodium";

  static List<Data> _namaAntibiotik = [];

  void addAntibiotik() {
    var data = Antibiotik(
        id: 1,
        dosis: 10,
        lamaPemberian: 10,
        nama: _selectedNamaAntibiotik,
        jalurPemberian: _selectedJalurPemberian);
    var antibiotik = [..._namaAntibiotik];
    antibiotik.add(Data(id: data.id, name: data.nama));

    setState(() {
      _namaAntibiotik = [...antibiotik];
    });

    return;
  }

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

  Future<void> _showMyDialog() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final antibiotics = Provider.of<Antibiotics>(context, listen: false);

        var data = PemberianAntibiotik();
        data.jalurPemberian = _selectedJalurPemberian;
        data.id_antibiotik =
            dataAntibiotik.indexOf(_selectedNamaAntibiotik.toString()) + 1;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Tambah antibiotik'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Nama Antibiotik",
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
                          value: _selectedNamaAntibiotik,
                          items: dataAntibiotik
                              .map((code) => DropdownMenuItem(
                                  value: code, child: Text(code)))
                              .toList(),
                          onChanged: (index) {
                            data.id_antibiotik = dataAntibiotik
                                    .indexOf(index.toString().toString()) +
                                1;
                            setState(() {
                              _selectedNamaAntibiotik = index.toString();
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Jalur Pemberian",
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
                          value: _selectedJalurPemberian,
                          items: jalurPemberian
                              .map((code) => DropdownMenuItem(
                                  value: code, child: Text(code)))
                              .toList(),
                          onChanged: (index) {
                            data.jalurPemberian = index.toString();
                            setState(() {
                              _selectedJalurPemberian = index.toString();
                            });
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
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        suffixText: "mg",
                        labelText: 'Dosis',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        data.dosis = int.parse(value);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          suffixText: "Hari",
                          labelText: 'Lama Pemberian',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          data.lamaPemberian = int.parse(value);
                        }),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    addAntibiotik();
                    antibiotics.addAntibiotik(data);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                  ),
                  child: const Text(
                    "Tambah",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  bool helper = true;

  void setInitialDataForUpdatingPasien(Map<String, dynamic> data) {
    var dataRiwayat = data["visitasi"]["riwayat_antibiotik"];
    if (dataRiwayat["reaksi_obat"] != null) {
      deskripsiReaksi.text = dataRiwayat["reaksi_obat"];
      _reaksiAlergi = true;
    }

    if (dataRiwayat["efek_samping"] != null) {
      deskripsiEfekSamping.text = dataRiwayat["efek_samping"];
      _efekSamping = true;
    }

    _kombinasiAntibiotik = dataRiwayat["kombinasi_antibiotik"];

    if ((dataRiwayat["pemberian_antibiotik"] as List).isNotEmpty) {
      List<Data> namaAntibiotik = [];

      for (var i = 0; i < dataAntibiotik.length; i++) {
        namaAntibiotik.add(Data(id: i, name: dataAntibiotik[i]));
      }

      _namaAntibiotik = [];
      var dataUserAntibiotik = dataRiwayat["pemberian_antibiotik"] as List;
      for (var element in dataUserAntibiotik) {
        _namaAntibiotik.add(namaAntibiotik[element["antibiotik"]["id"] - 1]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      final pasien = Provider.of<Patiens>(context, listen: false);
      final antibiotics = Provider.of<Antibiotics>(context, listen: false);
      antibiotics.removeAllAntibiotik();
      var pemberianAntibiotik = pasien.pasienDetail["visitasi"]
          ["riwayat_antibiotik"]["pemberian_antibiotik"] as List;

      if(pemberianAntibiotik.isNotEmpty) {
        for (var item in pemberianAntibiotik) {
          Logger().d(item);
          antibiotics.addAntibiotik(PemberianAntibiotik(
              lamaPemberian: item["lama_pemberian"],
              jalurPemberian: item["jalur_pemberian"],
              dosis: item['dosis'],
              id_antibiotik: item['antibiotik']['id']));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pasien = Provider.of<Patiens>(context, listen: false);
    final antibiotics = Provider.of<Antibiotics>(context);

    if (pasien.isEditing && helper) {
      _namaAntibiotik = [];
      setInitialDataForUpdatingPasien(pasien.pasienDetail);
      _diberikanAntibiotik = true;
      _kombinasiAntibiotik = pasien.kombinasiAntibiotik!;
      setState(() {
        helper = false;
      });
    }

    pasien.kombinasiAntibiotik = _kombinasiAntibiotik;
    pasien.pemberianAntibiotik = antibiotics.items;

    deskripsiReaksi.addListener(() {
      pasien.reaksiObat = deskripsiReaksi.text;
    });

    deskripsiEfekSamping.addListener(() {
      pasien.efekSamping = deskripsiEfekSamping.text;
    });

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
                "Riwayat Antibiotik",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Pasien diberikan antibiotik ?",
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
                        value: true,
                        groupValue: _diberikanAntibiotik,
                        activeColor: const Color(0xFF20BDB7),
                        onChanged: (index) {
                          setState(() {
                            _diberikanAntibiotik = true;
                          });
                        },
                      ),
                      const Text(
                        "Ya",
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: _diberikanAntibiotik,
                        activeColor: const Color(0xFF20BDB7),
                        onChanged: (index) {
                          setState(() {
                            _diberikanAntibiotik = false;
                          });
                        },
                      ),
                      const Text(
                        "Tidak",
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Visibility(
                visible: _diberikanAntibiotik,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Apakah kombinasi/lebih dari 1 jenis antibiotik secara bersamaan?",
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
                              value: true,
                              groupValue: _kombinasiAntibiotik,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _kombinasiAntibiotik = true;
                                });
                              },
                            ),
                            const Text(
                              "Ya",
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: false,
                              groupValue: _kombinasiAntibiotik,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _kombinasiAntibiotik = false;
                                  _namaAntibiotik = [];
                                  antibiotics.items = [];
                                });
                              },
                            ),
                            const Text(
                              "Tidak",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _kombinasiAntibiotik,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: _namaAntibiotik.isNotEmpty,
                            child: Column(
                              children: const [
                                Center(
                                  child: Text(
                                    "List kombinasi antibiotik",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          MultiSelectChipDisplay(
                            items: _namaAntibiotik
                                .map((data) =>
                                    MultiSelectItem<Data>(data, data.name))
                                .toList(),
                            chipColor: const Color(0xFF20BDB7).withOpacity(0.6),
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            onTap: (Data values) {
                              setState(() {
                                antibiotics.removeAntibiotik(values.id);
                                _namaAntibiotik.remove(values);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _showMyDialog();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 15,
                                  ),
                                ),
                                child: const Text(
                                  "Tambah antibiotik",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Sebelum pemberian AB, apa sudah pernah konsumsi/mendapatkan AB lain ?",
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
                              value: true,
                              groupValue: _antibiotikLain,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _antibiotikLain = true;
                                });
                              },
                            ),
                            const Text(
                              "Ya",
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: false,
                              groupValue: _antibiotikLain,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _antibiotikLain = false;
                                });
                              },
                            ),
                            const Text(
                              "Tidak",
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Apakah ada reaksi alergi terhadap obat",
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
                              value: true,
                              groupValue: _reaksiAlergi,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _reaksiAlergi = true;
                                });
                              },
                            ),
                            const Text(
                              "Ya",
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: false,
                              groupValue: _reaksiAlergi,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _reaksiAlergi = false;
                                });
                              },
                            ),
                            const Text(
                              "Tidak",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _reaksiAlergi,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: deskripsiReaksi,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi reaksi yang muncul',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            maxLines: 4,
                            keyboardType: TextInputType.streetAddress,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Apakah ada efek samping",
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
                              value: true,
                              groupValue: _efekSamping,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _efekSamping = true;
                                });
                              },
                            ),
                            const Text(
                              "Ya",
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: false,
                              groupValue: _efekSamping,
                              activeColor: const Color(0xFF20BDB7),
                              onChanged: (index) {
                                setState(() {
                                  _efekSamping = false;
                                });
                              },
                            ),
                            const Text(
                              "Tidak",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _efekSamping,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: deskripsiEfekSamping,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi efek samping yang muncul',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            maxLines: 4,
                            keyboardType: TextInputType.streetAddress,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
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

                            if (pasien.isEditing) {
                              pasien.updatePasien().then(
                                (_) {
                                  Navigator.of(context).pop();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    dismissOnTouchOutside: false,
                                    animType: AnimType.bottomSlide,
                                    title: 'Pasien berhasil diupdate !',
                                    autoHide: const Duration(seconds: 3),
                                    btnOkColor: const Color(0xFF20BDB7),
                                    onDismissCallback: (e) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()),
                                          (Route<dynamic> route) => false);
                                    },
                                    btnOkOnPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const HomeScreen();
                                          },
                                        ),
                                      );
                                    },
                                  ).show();
                                },
                              );
                            } else {
                              pasien.addPatien().then(
                                (_) {
                                  Navigator.of(context).pop();
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    dismissOnTouchOutside: false,
                                    animType: AnimType.bottomSlide,
                                    title: 'Pasien berhasil ditambahkan !',
                                    autoHide: const Duration(seconds: 3),
                                    btnOkColor: const Color(0xFF20BDB7),
                                    onDismissCallback: (e) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()),
                                          (Route<dynamic> route) => false);
                                    },
                                    btnOkOnPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const HomeScreen();
                                          },
                                        ),
                                      );
                                    },
                                  ).show();
                                },
                              );
                            }
                          },
                        ).show();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                      ),
                      child: Text(
                        pasien.isEditing ? "Ubah Data Pasien" : "Tambah Pasien",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
