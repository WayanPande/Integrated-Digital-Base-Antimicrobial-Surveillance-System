class Data {
  final int id;
  final String name;

  Data({
    required this.id,
    required this.name,
  });
}

class Antibiotik {
  final int id, dosis, lamaPemberian;
  final String nama, jalurPemberian;

  Antibiotik({
    required this.id,
    required this.dosis,
    required this.lamaPemberian,
    required this.nama,
    required this.jalurPemberian,
  });
}

class Pasien {
  String? name;
  String? tanggal_lahir;
  String? no_hp;
  String? gender;
  String? alamat;
  String? komorbid;
  Visitasi? visitasi;
  Spesimen? spesimen;
  List<AntibiotikSensitif>? antibiotik_sensitif;
  RiwayatAntibiotik? riwayat_antibiotik;
  List<PemberianAntibiotik>? pemberianAntibiotik;

  Pasien(
      {this.name,
      this.tanggal_lahir,
      this.no_hp,
      this.gender,
      this.alamat,
      this.komorbid,
      this.visitasi,
      this.spesimen,
      this.antibiotik_sensitif,
      this.riwayat_antibiotik,
      this.pemberianAntibiotik});

  Pasien.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tanggal_lahir = json['tanggal_lahir'];
    no_hp = json['no_hp'];
    gender = json['gender'];
    alamat = json['alamat'];
    komorbid = json['komorbid'];
    visitasi = json['visitasi'] != null
        ? Visitasi.fromJson(json['visitasi'])
        : null;
    spesimen = json['spesimen'] != null
        ? Spesimen.fromJson(json['spesimen'])
        : null;
    if (json['antibiotik_sensitif'] != null) {
      antibiotik_sensitif = <AntibiotikSensitif>[];
      json['antibiotik_sensitif'].forEach((v) {
        antibiotik_sensitif!.add(AntibiotikSensitif.fromJson(v));
      });
    }
    riwayat_antibiotik = json['riwayat_antibiotik'] != null
        ?  RiwayatAntibiotik.fromJson(json['riwayat_antibiotik'])
        : null;
    if (json['pemberian_antibiotik'] != null) {
      pemberianAntibiotik = <PemberianAntibiotik>[];
      json['pemberian_antibiotik'].forEach((v) {
        pemberianAntibiotik!.add( PemberianAntibiotik.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = this.name;
    data['tanggal_lahir'] = this.tanggal_lahir;
    data['no_hp'] = this.no_hp;
    data['gender'] = this.gender;
    data['alamat'] = this.alamat;
    data['komorbid'] = this.komorbid;
    if (this.visitasi != null) {
      data['visitasi'] = this.visitasi!.toJson();
    }
    if (this.spesimen != null) {
      data['spesimen'] = this.spesimen!.toJson();
    }
    if (this.antibiotik_sensitif != null) {
      data['antibiotik_sensitif'] =
          this.antibiotik_sensitif!.map((v) => v.toJson()).toList();
    }
    if (this.riwayat_antibiotik != null) {
      data['riwayat_antibiotik'] = this.riwayat_antibiotik!.toJson();
    }
    if (this.pemberianAntibiotik != null) {
      data['pemberian_antibiotik'] =
          this.pemberianAntibiotik!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Visitasi {
  String? dx_sementara;
  String? dx_definitif;
  String? jenis_perawatan;
  int? lama_dirawat;
  String? tempat_praktek;
  String? ruang_rawat;
  String? hasil_bakteri;

  Visitasi(
      {this.dx_sementara,
      this.dx_definitif,
      this.jenis_perawatan,
      this.lama_dirawat,
      this.tempat_praktek,
      this.ruang_rawat,
      this.hasil_bakteri});

  Visitasi.fromJson(Map<String, dynamic> json) {
    dx_sementara = json['dx_sementara'];
    dx_definitif = json['dx_definitif'];
    jenis_perawatan = json['jenis_perawatan'];
    lama_dirawat = json['lama_dirawat'];
    tempat_praktek = json['tempat_praktek'];
    ruang_rawat = json['ruang_rawat'];
    hasil_bakteri = json['hasil_bakteri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['dx_sementara'] = this.dx_sementara;
    data['dx_definitif'] = this.dx_definitif;
    data['jenis_perawatan'] = this.jenis_perawatan;
    data['lama_dirawat'] = this.lama_dirawat;
    data['tempat_praktek'] = this.tempat_praktek;
    data['ruang_rawat'] = this.ruang_rawat;
    data['hasil_bakteri'] = this.hasil_bakteri;
    return data;
  }
}

class Spesimen {
  String? name;

  Spesimen({this.name});

  Spesimen.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = this.name;
    return data;
  }
}

class AntibiotikSensitif {
  int? id_antibiotik;

  AntibiotikSensitif({this.id_antibiotik});

  AntibiotikSensitif.fromJson(Map<String, dynamic> json) {
    id_antibiotik = json['id_antibiotik'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id_antibiotik'] = this.id_antibiotik;
    return data;
  }
}

class RiwayatAntibiotik {
  bool? kombinasi_antibiotik;
  String? reaksi_obat;
  String? efek_samping;

  RiwayatAntibiotik(
      {this.kombinasi_antibiotik, this.reaksi_obat, this.efek_samping});

  RiwayatAntibiotik.fromJson(Map<String, dynamic> json) {
    kombinasi_antibiotik = json['kombinasi_antibiotik'];
    reaksi_obat = json['reaksi_obat'];
    efek_samping = json['efek_samping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['kombinasi_antibiotik'] = this.kombinasi_antibiotik;
    data['reaksi_obat'] = this.reaksi_obat;
    data['efek_samping'] = this.efek_samping;
    return data;
  }
}

class PemberianAntibiotik {
  int? id_antibiotik;
  String? jalurPemberian;
  int? dosis;
  int? lamaPemberian;

  PemberianAntibiotik(
      {this.id_antibiotik, this.jalurPemberian, this.dosis, this.lamaPemberian});

  PemberianAntibiotik.fromJson(Map<String, dynamic> json) {
    id_antibiotik = json['id_antibiotik'];
    jalurPemberian = json['jalur_pemberian'];
    dosis = json['dosis'];
    lamaPemberian = json['lama_pemberian'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id_antibiotik'] = this.id_antibiotik;
    data['jalur_pemberian'] = this.jalurPemberian;
    data['dosis'] = this.dosis;
    data['lama_pemberian'] = this.lamaPemberian;
    return data;
  }
}
