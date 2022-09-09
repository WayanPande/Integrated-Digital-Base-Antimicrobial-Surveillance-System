import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_pak_gusan/util/data_drop_down.dart';
import 'package:project_pak_gusan/widget/patient_data.dart';
import 'package:project_pak_gusan/widget/riwayat_pasien_list.dart';

import '../widget/antibiotik_card.dart';

class ProfilePatienScreen extends StatefulWidget {
  const ProfilePatienScreen({Key? key, required this.name, required this.umur}) : super(key: key);

  final String name, umur;

  @override
  State<ProfilePatienScreen> createState() => _ProfilePatienScreenState();
}

class _ProfilePatienScreenState extends State<ProfilePatienScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
              onPressed: () {},
              icon: const Icon(
                Icons.delete_rounded,
              ),
              color: Colors.red,
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
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
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://avatars.dicebear.com/api/adventurer-neutral/${widget.name}.jpg",
                        ),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                        content: "${widget.umur} tahun",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PatienData(
                        title: "Jenis kelamin",
                        content: "laki - laki",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PatienData(
                        title: "Alamat",
                        content: "Jl. Imam Bonjol no.32",
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      PatienData(
                        title: "No handphone",
                        content: "08111222993",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PatienData(
                        title: "Komorbid",
                        content: "......",
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
                        children: const [
                          RiwayatPasienList(
                            title: "Dx Sementara",
                            value: "12",
                          ),
                          RiwayatPasienList(
                            title: "Dx Definitif",
                            value: "12",
                          ),
                          RiwayatPasienList(
                            title: "Jenis Perawatan",
                            value: "Rawat Jalan",
                          ),
                          RiwayatPasienList(
                            title: "Lama Dirawat",
                            value: "5 Hari",
                          ),
                          RiwayatPasienList(
                            title: "Tempat Praktek",
                            value: "Praktek Pribadi",
                          ),
                          RiwayatPasienList(
                            title: "Ruang Rawat",
                            value: "UGD",
                          ),
                          RiwayatPasienList(
                            title: "Jenis Spesimen Bakteri",
                            value: "Air Kencing",
                          ),
                          RiwayatPasienList(
                            title: "Hasil Bakteri",
                            value: "hidrokokus",
                          ),
                          RiwayatPasienList(
                            title: "Nama Antibiotik",
                            value: "Rolitetracycline",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return AntibiotikCard(
                            namaAntibiotik: dataAntibiotik[Random().nextInt(200)],
                            dosis: '10 mg',
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
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
