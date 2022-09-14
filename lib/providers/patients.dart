import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../service/http_service.dart';
import '../util/data_class.dart';

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

  List<AntibiotikSensitif> antibiotikSensitif = [];

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

  Future<void> getPasienList() async {
    try {
      final data = await HttpService().getPasien();
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

  Future<void> updatePasien() async {
    var data = Pasien(
        name: name ?? pasienDetail['name'],
        tanggal_lahir: tanggalLahir ?? pasienDetail['tanggal_lahir'],
        no_hp: noHp ?? pasienDetail['no_hp'].toString(),
        gender: gender ?? pasienDetail['gender'],
        alamat: alamat ?? pasienDetail['alamat'],
        komorbid: komorbid ?? pasienDetail['komorbid']);

    Logger().d(data.komorbid);

    try {
      await HttpService().updatePasien(data, pasienDetail['id']);
      await getPasienById(pasienDetail['id']);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
