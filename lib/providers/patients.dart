import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../service/http_service.dart';
import '../util/data_class.dart';
import 'package:collection/collection.dart';

class Patiens with ChangeNotifier {
  Map<String, Pasien> _items = {};

  Map<String, Pasien> get items {
    return {..._items};
  }

  List<PasienList> _pasienList = [];

  List<PasienList> get pasienList {
    return [..._pasienList];
  }

  Map<String, dynamic> _pasienDetail = {};

  Map<String, dynamic> get pasienDetail {
    return {..._pasienDetail};
  }

  bool isEditing = false;

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

  List<AntibiotikSensitif> antibiotikSensitif = [], antibiotikSensitifDetail = [];

  List<PemberianAntibiotik> pemberianAntibiotik = [],
      pemberianAntibiotikDetail = [];

  List<Data> riwayatAntibiotik = [];

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
          spesimen: spesimenName != null
              ? Spesimen(
                  name: spesimenName,
                )
              : null,
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

    try {
      await HttpService().addNewPasien(items[name]);
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getPasienList(String? name) async {
    try {
      final data = await HttpService().getPasien(name);
      var finalData = data.map((e) => PasienList.fromJson(e)).toList();
      _pasienList = finalData;
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> getPasienById(int id) async {
    _pasienDetail = {};
    pemberianAntibiotikDetail = [];
    riwayatAntibiotik = [];
    pemberianAntibiotik = [];
    antibiotikSensitif = [];
    antibiotikSensitifDetail = [];
    try {
      final data = await HttpService().getPasienById(id);
      _pasienDetail = data;
      pemberianAntibiotikDetail = ((data['visitasi']['riwayat_antibiotik']
                  ?['pemberian_antibiotik'] ??
              []) as List<dynamic>)
          .map((e) => PemberianAntibiotik.fromJson(e))
          .toList();

      riwayatAntibiotik = ((data['visitasi']['riwayat_antibiotik']
                  ?['pemberian_antibiotik'] ??
              []) as List<dynamic>)
          .map((e) =>
              Data(id: e['antibiotik']?['id'], name: e['antibiotik']?['name']))
          .toList();

      antibiotikSensitifDetail = ((data['visitasi']['antibiotik_sensitif'] ??
          []) as List<dynamic>)
          .map((e) => AntibiotikSensitif(id_antibiotik: e['nama_antibiotik_sensitif']['id']))
          .toList();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> deletePasien(int id) async {
    try {
      await HttpService().deletePasien(id);
    } catch (e) {
      rethrow;
    }
  }

  List<AntibiotikSensitif> _setAntibiotikSensitif(List data) {
    return data
        .map((e) => AntibiotikSensitif(
            id_antibiotik: (e['nama_antibiotik_sensitif']['id'] + 1)))
        .toList();
  }

  List<PemberianAntibiotik> _setPemberianAntibiotik(List data) {
    return data
        .map((e) => PemberianAntibiotik(
            id_antibiotik: (e['antibiotik']['id'] + 1),
            dosis: e['dosis'],
            jalurPemberian: e['jalur_pemberian'],
            lamaPemberian: e['lama_pemberian']))
        .toList();
  }

  List<PemberianAntibiotik> _cekPemberianAntbiotik() {

    List<PemberianAntibiotik> antibiotikList = _setPemberianAntibiotik(pasienDetail['visitasi']['riwayat_antibiotik']['pemberian_antibiotik']);

    if(pemberianAntibiotik.isEmpty){
      if(const ListEquality().equals(pemberianAntibiotikDetail, antibiotikList)){
        return antibiotikList;
      }
    }

    return pemberianAntibiotik;
  }

  List<AntibiotikSensitif> _cekAntbiotikSensitif() {

    List<AntibiotikSensitif> antibiotikList = _setAntibiotikSensitif(pasienDetail['visitasi']['antibiotik_sensitif']);

    if(antibiotikSensitif.isEmpty){
      if(const ListEquality().equals(antibiotikSensitifDetail, antibiotikList)){
        return antibiotikList;
      }
    }

    return antibiotikSensitif;
  }

  Future<void> updatePasien() async {
    var data = Pasien(
      name: name ?? pasienDetail['name'],
      tanggal_lahir: tanggalLahir ?? pasienDetail['tanggal_lahir'],
      no_hp: noHp ?? pasienDetail['no_hp'].toString(),
      gender: gender ?? pasienDetail['gender'],
      alamat: alamat ?? pasienDetail['alamat'],
      komorbid: komorbid ?? pasienDetail['komorbid'],
      visitasi: Visitasi(
        dx_sementara: dxSementara ?? pasienDetail['visitasi']['dx_sementara'],
        dx_definitif: dxDefinitif ?? pasienDetail['visitasi']['dx_definitif'],
        jenis_perawatan:
            jenisPerawatan ?? pasienDetail['visitasi']['jenis_perawatan'],
        lama_dirawat: lamaDirawat ?? pasienDetail['visitasi']['lama_dirawat'],
        tempat_praktek:
            tempatPraktek ?? pasienDetail['visitasi']['tempat_praktek'],
        ruang_rawat: ruangRawat ?? pasienDetail['visitasi']['ruang_rawat'],
        hasil_bakteri:
            hasilBakteri ?? pasienDetail['visitasi']['hasil_bakteri'],
      ),
      spesimen: spesimenName != null
          ? Spesimen(
              name: spesimenName,
            )
          : pasienDetail['visitasi']['spesimen']['name'],
      antibiotik_sensitif: _cekAntbiotikSensitif(),
      riwayat_antibiotik: RiwayatAntibiotik(
        kombinasi_antibiotik: kombinasiAntibiotik ??
            pasienDetail['visitasi']['riwayat_antibiotik']
                ['kombinasi_antibiotik'],
        reaksi_obat: reaksiObat ??
            pasienDetail['visitasi']['riwayat_antibiotik']['reaksi_obat'],
        efek_samping: efekSamping ??
            pasienDetail['visitasi']['riwayat_antibiotik']['efek_samping'],
      ),
      pemberianAntibiotik: _cekPemberianAntbiotik(),
    );

    name = null;
    tanggalLahir = null;
    noHp = null;
    gender = null;
    alamat = null;
    komorbid = null;
    dxSementara = null;
    dxDefinitif = null;
    jenisPerawatan = null;
    tempatPraktek = null;
    ruangRawat = null;
    hasilBakteri = null;
    spesimenName = null;
    reaksiObat = null;
    efekSamping = null;
    lamaDirawat = null;

    try {
      await HttpService().updatePasien(data, pasienDetail['id']);
      await getPasienById(pasienDetail['id']);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
