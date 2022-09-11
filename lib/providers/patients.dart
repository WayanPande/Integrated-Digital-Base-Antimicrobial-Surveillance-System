import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../util/data_class.dart';

class Patiens with ChangeNotifier {
  Map<String, Pasien> _items = {};

  Map<String, Pasien> get items {
    return {..._items};
  }

  String? name = null,
      tanggalLahir = null,
      noHp = null,
      gender = null,
      alamat = null,
      komorbid = null,
      dxSementara = null,
      dxDefinitif = null,
      jenisPerawatan = null,
      tempatPraktek = null,
      ruangRawat = null,
      hasilBakteri = null,
      spesimenName = null,
      reaksiObat = null,
      efekSamping = null;

  bool? kombinasiAntibiotik;

  int? lamaDirawat = null;

  List<AntibiotikSensitif> antibiotikSensitif = [];

  List<PemberianAntibiotik> pemberianAntibiotik = [];

  Future<void> addPatien() async {
    if (_items.containsKey(name)) {
      _items.update(
          name!,
          (existingPatien) => Pasien(
              name: name ?? existingPatien.name,
              tanggal_lahir: tanggalLahir ?? existingPatien.tanggal_lahir,
              no_hp: noHp ?? existingPatien.no_hp,
              gender: gender ?? existingPatien.gender,
              alamat: alamat ?? existingPatien.alamat,
              komorbid: komorbid ?? existingPatien.komorbid,
              visitasi: Visitasi(
                dx_sementara:
                    dxSementara ?? existingPatien.visitasi?.dx_sementara,
                dx_definitif:
                    dxDefinitif ?? existingPatien.visitasi?.dx_definitif,
                jenis_perawatan:
                    jenisPerawatan ?? existingPatien.visitasi?.jenis_perawatan,
                lama_dirawat:
                    lamaDirawat ?? existingPatien.visitasi?.lama_dirawat,
                tempat_praktek:
                    tempatPraktek ?? existingPatien.visitasi?.tempat_praktek,
                ruang_rawat: ruangRawat ?? existingPatien.visitasi?.ruang_rawat,
                hasil_bakteri:
                    hasilBakteri ?? existingPatien.visitasi?.hasil_bakteri,
              ),
              spesimen: Spesimen(
                name: spesimenName ?? existingPatien.spesimen?.name,
              ),
              antibiotik_sensitif: antibiotikSensitif,
              riwayat_antibiotik: RiwayatAntibiotik(
                kombinasi_antibiotik: kombinasiAntibiotik ??
                    existingPatien.riwayat_antibiotik?.kombinasi_antibiotik,
                reaksi_obat: reaksiObat ??
                    existingPatien.riwayat_antibiotik?.reaksi_obat,
                efek_samping: efekSamping ??
                    existingPatien.riwayat_antibiotik?.efek_samping,
              ),
              pemberianAntibiotik: pemberianAntibiotik));
    } else {
      _items.putIfAbsent(
        name!,
        () => Pasien(
          name: name,
          tanggal_lahir: tanggalLahir,
          no_hp: noHp,
          gender: gender,
          alamat: alamat,
          komorbid: komorbid,
          visitasi: Visitasi(
            dx_sementara: dxSementara,
            dx_definitif: dxDefinitif,
            jenis_perawatan: jenisPerawatan,
            lama_dirawat: lamaDirawat,
            tempat_praktek: tempatPraktek,
            ruang_rawat: ruangRawat,
            hasil_bakteri: hasilBakteri,
          ),
          spesimen: Spesimen(
            name: spesimenName,
          ),
          antibiotik_sensitif: antibiotikSensitif,
          riwayat_antibiotik: RiwayatAntibiotik(
            kombinasi_antibiotik: kombinasiAntibiotik,
            reaksi_obat: reaksiObat,
            efek_samping: efekSamping,
          ),
          pemberianAntibiotik: pemberianAntibiotik,
        ),
      );
    }

    const String pasienkURL = "http://10.0.2.2:3000/pasien";

    var logger = Logger();

    logger.d(jsonEncode(items[name]?.visitasi?.jenis_perawatan));

    http.Response res = await http.post(
      Uri.parse(pasienkURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(items[name]),
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      _items = {};
      print(body);
    } else {
      throw "Unable to retrieve posts.";
    }

    print(items[name]?.visitasi?.hasil_bakteri);
    print(name);
    notifyListeners();
  }
}
