import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../util/data_class.dart';

class AddPatienAntibiotik extends StatefulWidget {
  const AddPatienAntibiotik({Key? key}) : super(key: key);

  @override
  State<AddPatienAntibiotik> createState() => _AddPatienAntibiotikState();
}

class _AddPatienAntibiotikState extends State<AddPatienAntibiotik> {
  bool _diberikanAntibiotik = false, _kombinasiAntibiotik = false;

  final List<String> jalurPemberian = [
    "Oral",
    "IV",
    "IM",
    "Parental",
    "Topikal"
  ];
  String _selectedJalurPemberian = "Oral";

  static List<Data> namaAntibiotik = [
    Data(id: 1, name: "Ingus"),
    Data(id: 2, name: "Air Kencing"),
    Data(id: 3, name: "Darah"),
  ];

  final _itemsNamaAntibiotik = namaAntibiotik
      .map((data) => MultiSelectItem<Data>(data, data.name))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tambah Pasien Baru",
          style: TextStyle(
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
                "Nama Antibiotik",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MultiSelectDialogField(
                items: _itemsNamaAntibiotik,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                title: const Text(
                  "Nama Antibiotik",
                ),
                buttonIcon: const Icon(
                  Icons.arrow_drop_down,
                ),
                selectedColor: const Color(0xFF20BDB7),
                onConfirm: (index) {},
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
                        .map((code) =>
                            DropdownMenuItem(value: code, child: Text(code)))
                        .toList(),
                    onChanged: (index) {
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
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Efek Samping',
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
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const AddPatienAntibiotik();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                      ),
                      child: const Text(
                        "Tambah Pasien",
                        style: TextStyle(
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
