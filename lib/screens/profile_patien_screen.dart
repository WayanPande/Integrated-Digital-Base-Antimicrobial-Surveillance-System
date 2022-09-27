import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project_pak_gusan/screens/add_patien_identitas_screen.dart';
import 'package:project_pak_gusan/util/data_drop_down.dart';
import 'package:project_pak_gusan/widget/patient_data.dart';
import 'package:project_pak_gusan/widget/riwayat_pasien_list.dart';
import 'package:provider/provider.dart';

import '../providers/patients.dart';
import '../widget/antibiotik_card.dart';

class ProfilePatienScreen extends StatefulWidget {
  const ProfilePatienScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<ProfilePatienScreen> createState() => _ProfilePatienScreenState();
}

class _ProfilePatienScreenState extends State<ProfilePatienScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Patiens>(context, listen: false).getPasienById(widget.id);
    }).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var pasien = Provider.of<Patiens>(context);

    final spesimen = (pasien.pasienDetail['visitasi']?['spesimen'] ??
        [
          {"name": "-"}
        ]) as List<dynamic>;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pasien.isEditing = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddPatienIdentitas();
                },
              ),
            );
          },
          backgroundColor: const Color(0xFF20BDB7),
          child: const Icon(
            Icons.edit,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Profile Pasien",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  dismissOnTouchOutside: false,
                  animType: AnimType.bottomSlide,
                  title: 'Hapus Pasien',
                  desc: 'Yakin ingin menghapus pasien ini ?',
                  btnOkColor: const Color(0xFF20BDB7),
                  btnCancel: TextButton(
                    child: const Text("cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  btnOkOnPress: () {
                    pasien.deletePasien(widget.id);
                    Navigator.pop(context);
                  },
                ).show();
              },
              icon: const Icon(
                Icons.delete_rounded,
              ),
              color: Colors.red,
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(
                  25,
                ),
                child: Column(
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
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF20BDB7),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            pasien.pasienDetail['name'] ?? "-",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PatienData(
                              title: "Umur",
                              content:
                                  "${(DateTime.now().year - DateTime.parse(pasien.pasienDetail['tanggal_lahir'] ?? DateTime.now().toString()).year).toString()} tahun",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PatienData(
                              title: "Jenis kelamin",
                              content: pasien.pasienDetail['gender'] ?? "-",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PatienData(
                              title: "Alamat",
                              content: pasien.pasienDetail['alamat'] ?? "-",
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PatienData(
                              title: "No handphone",
                              content: (pasien.pasienDetail['no_hp'] ?? 0)
                                  .toString(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PatienData(
                              title: "Komorbid",
                              content: pasien.pasienDetail['komorbid'] ?? "-",
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFE2E2E2),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelColor: const Color(0xFF20BDB7),
                        unselectedLabelColor: const Color(0xFF20BDB7),
                        tabs: const [
                          Tab(
                            text: 'Riwayat Pasien',
                          ),
                          Tab(
                            text: 'Riwayat Antibiotik',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.only(
                              top: 30,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              children: [
                                RiwayatPasienList(
                                  title: "Dx Sementara",
                                  value: pasien.pasienDetail['visitasi']
                                          ?['dx_sementara'] ??
                                      "-",
                                ),
                                RiwayatPasienList(
                                  title: "Dx Definitif",
                                  value: pasien.pasienDetail['visitasi']
                                          ?['dx_definitif'] ??
                                      "-",
                                ),
                                RiwayatPasienList(
                                  title: "Jenis Perawatan",
                                  value: pasien.pasienDetail['visitasi']
                                          ?['jenis_perawatan'] ??
                                      "-",
                                ),
                                RiwayatPasienList(
                                  title: "Lama Dirawat",
                                  value: (pasien.pasienDetail['visitasi']
                                              ?['lama_dirawat'] ??
                                          0)
                                      .toString(),
                                ),
                                RiwayatPasienList(
                                  title: "Tempat Praktek",
                                  value: pasien.pasienDetail['visitasi']
                                          ?['tempat_praktek'] ??
                                      "-",
                                ),
                                RiwayatPasienList(
                                  title: "Ruang Rawat",
                                  value: pasien.pasienDetail['visitasi']
                                          ?['ruang_rawat'] ??
                                      "-",
                                ),
                                RiwayatPasienList(
                                  title: "Jenis Spesimen Bakteri",
                                  value: spesimen.isNotEmpty
                                      ? (spesimen[0]?['name'] ?? "-")
                                      : "-",
                                ),
                                RiwayatPasienList(
                                  title: "Hasil Bakteri",
                                  value: pasien.pasienDetail['visitasi']
                                          ?['hasil_bakteri'] ??
                                      "-",
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: pasien.riwayatAntibiotik.isEmpty
                                ? const Center(
                                    child: Text("Tidak ada data"),
                                  )
                                : ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount:
                                        pasien.riwayatAntibiotik.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AntibiotikCard(
                                        namaAntibiotik: pasien.riwayatAntibiotik[index].name,
                                        dosis: '${pasien.pasienDetail['visitasi']['riwayat_antibiotik']
                                        ?['pemberian_antibiotik'][index]['dosis']} mg',
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
