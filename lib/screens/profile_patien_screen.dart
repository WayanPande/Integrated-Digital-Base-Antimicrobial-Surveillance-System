import 'package:flutter/material.dart';
import 'package:project_pak_gusan/widget/patient_card.dart';
import 'package:project_pak_gusan/widget/patient_data.dart';

class ProfilePatienScreen extends StatefulWidget {
  const ProfilePatienScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePatienScreen> createState() => _ProfilePatienScreenState();
}

class _ProfilePatienScreenState extends State<ProfilePatienScreen> {
  final List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

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
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://avatars.dicebear.com/api/adventurer-neutral/joko.jpg",
                        ),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "John Johnsons",
                    style: TextStyle(
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
                    children: const [
                      PatienData(
                        title: "Umur",
                        content: "24 tahun",
                      ),
                      SizedBox(
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: numberList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PatienCard();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: numberList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PatienCard();
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
