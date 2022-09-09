import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:project_pak_gusan/screens/add_patien_antibiotik_screen.dart';
import 'package:project_pak_gusan/util/data_drop_down.dart';

import '../util/data_class.dart';

class AddPatienRiwayat extends StatefulWidget {
  const AddPatienRiwayat({Key? key}) : super(key: key);

  @override
  State<AddPatienRiwayat> createState() => _AddPatienRiwayatState();
}

class _AddPatienRiwayatState extends State<AddPatienRiwayat> {
  TextEditingController tanggalLahir = TextEditingController();

  final List<String> tempatPraktek = [
    "Praktek Pribadi",
    "Klinik",
    "Puskesmas",
    "Poliklinik",
    "Rumah Sakit"
  ];
  String _selectedtempatPraktek = "Praktek Pribadi";

  final List<String> ruangRawat = [
    "Ruang Inap",
    "Poliklinik",
    "UGD",
    "Triage",
    "Praktek Pribadi/klinik"
  ];
  String _selectedruangRawat = "Ruang Inap",
      _selectedBakteri = "Borrelia afzelii";

  bool _hasilKulturBakteri = false, _namaAntibiotik = false;

  static List<Data> jenisPerawatan = [
    Data(id: 1, name: "Rawat Jalan"),
    Data(id: 2, name: "Rawat Inap/Opname"),
    Data(id: 3, name: "Meninggal"),
  ];

  static List<Data> jenisSpesimen = [
    Data(id: 1, name: "Ingus"),
    Data(id: 2, name: "Air Kencing"),
    Data(id: 3, name: "Darah"),
  ];

  static List<Data> namaAntibiotik = [];

  convertData() {
    if (namaAntibiotik.isEmpty) {
      for (var i = 0; i < dataAntibiotik.length; i++) {
        namaAntibiotik.add(Data(id: i, name: dataAntibiotik[i]));
      }
    }
  }

  final _itemsJenisPerawatan = jenisPerawatan
      .map((data) => MultiSelectItem<Data>(data, data.name))
      .toList();

  final _itemsJenisSpesimen = jenisSpesimen
      .map((data) => MultiSelectItem<Data>(data, data.name))
      .toList();

  List<MultiSelectItem> _itemsNamaAntibiotik = [];

  @override
  void initState() {
    super.initState();
    convertData();
    setState((){
      _itemsNamaAntibiotik = namaAntibiotik
          .map((data) => MultiSelectItem<Data>(data, data.name))
          .toList();
    });
  }

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
                "Riwayat Pasien",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Dx Sementara',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Dx Definitif',
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
                "Jenis Perawatan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MultiSelectDialogField(
                items: _itemsJenisPerawatan,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                chipDisplay: MultiSelectChipDisplay(
                  items: _itemsJenisSpesimen,
                  chipColor: const Color(0xFF20BDB7).withOpacity(0.6),
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  onTap: (values) {

                  },
                ),
                title: const Text(
                  "Jenis Perawatan",
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
              TextFormField(
                decoration: const InputDecoration(
                  suffixText: "Hari",
                  labelText: 'Lama Dirawat',
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
                "Tempat Praktek",
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
                    value: _selectedtempatPraktek,
                    items: tempatPraktek
                        .map((code) =>
                            DropdownMenuItem(value: code, child: Text(code)))
                        .toList(),
                    onChanged: (index) {
                      setState(() {
                        _selectedtempatPraktek = index.toString();
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
                "Ruang Rawat",
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
                    value: _selectedruangRawat,
                    items: ruangRawat
                        .map((code) =>
                            DropdownMenuItem(value: code, child: Text(code)))
                        .toList(),
                    onChanged: (index) {
                      setState(() {
                        _selectedruangRawat = index.toString();
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
                "Apakah ada hasil kultur bakteri ?",
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
                        groupValue: _hasilKulturBakteri,
                        activeColor: const Color(0xFF20BDB7),
                        onChanged: (index) {
                          setState(() {
                            _hasilKulturBakteri = true;
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
                        groupValue: _hasilKulturBakteri,
                        activeColor: const Color(0xFF20BDB7),
                        onChanged: (index) {
                          setState(() {
                            _hasilKulturBakteri = false;
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
                visible: _hasilKulturBakteri,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Spesimen apa ?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MultiSelectDialogField(
                      items: _itemsJenisSpesimen,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: const Text(
                        "Jenis Spesimen",
                      ),
                      chipDisplay: MultiSelectChipDisplay(
                        items: _itemsJenisSpesimen,
                        chipColor: const Color(0xFF20BDB7).withOpacity(0.6),
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        onTap: (values) {

                        },
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
                      "Apa hasil bakterinya ?",
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
                          value: _selectedBakteri,
                          items: dataBakteri
                              .map((code) => DropdownMenuItem(
                                  value: code, child: Text(code)))
                              .toList(),
                          onChanged: (index) {
                            setState(() {
                              _selectedBakteri = index.toString();
                            });
                          },
                          isExpanded: true,
                          underline: Container(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Apakah ada hasil uji kepekaan antibiotik ?",
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
                        groupValue: _namaAntibiotik,
                        activeColor: const Color(0xFF20BDB7),
                        onChanged: (index) {
                          setState(() {
                            _namaAntibiotik = true;
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
                        activeColor: const Color(0xFF20BDB7),
                        groupValue: _namaAntibiotik,
                        onChanged: (index) {
                          setState(() {
                            _namaAntibiotik = false;
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
                visible: _namaAntibiotik,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Apa nama antibiotika yang sensitif ?",
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
                      chipDisplay: MultiSelectChipDisplay(
                        items: _itemsJenisSpesimen,
                        chipColor: const Color(0xFF20BDB7).withOpacity(0.6),
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        onTap: (values) {

                        },
                      ),
                      selectedColor: const Color(0xFF20BDB7),
                      onConfirm: (index) {},
                      searchable: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
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
                      "Selanjutnya",
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
      ),
    );
  }
}
