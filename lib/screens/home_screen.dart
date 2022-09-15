import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:project_pak_gusan/providers/doctors.dart';
import 'package:project_pak_gusan/providers/patients.dart';
import 'package:project_pak_gusan/screens/add_patien_identitas_screen.dart';
import 'package:project_pak_gusan/screens/profile_doctor_screen.dart';
import 'package:project_pak_gusan/util/sharedPreferences.dart';
import 'package:project_pak_gusan/widget/patient_card.dart';
import 'package:provider/provider.dart';

import '../util/data_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  bool _isLoading = false;

  List<PasienList> _pasienList = [];

  int id = 0;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Patiens>(context, listen: false).getPasienList();
      Provider.of<Doctors>(context, listen: false).getDokter();
    }).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> _refreshPasien(BuildContext context) async {
    await Provider.of<Patiens>(context, listen: false).getPasienList();
  }

  Future<void> _saveDoctorId(BuildContext context) async {
    var temp = await getDoktorId();
    setState((){
      id =  temp ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pasien = Provider.of<Patiens>(context);
    var doctor = Provider.of<Doctors>(context);
    _pasienList = pasien.pasienList;

    _saveDoctorId(context);


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pasien.isEditing = false;
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
          Icons.add,
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          // Navigator.of(context).pop();
          return true as Future<bool>;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFF20BDB7),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Integrated Digital - Base Antimicrobial Surveillance System (IDAAS)",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ProfileDoctorScreen();
                              },
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                const Text(
                                  "Selamat datang",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    doctor.dokterDetail.nama ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://avatars.dicebear.com/api/adventurer-neutral/${doctor.dokterDetail.nama ?? ""}.jpg",
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black12, width: 0.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black12, width: 0.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintText: "Cari pasien",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                onPrimary: Colors.black,
                                primary: Colors.white,
                              ),
                              child: const Icon(
                                Icons.sort,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshPasien(context),
                      child: _pasienList.isEmpty
                          ? Stack(
                              children: [
                                ListView(),
                                const Center(
                                  child: Text("Tidak ada data!"),
                                )
                              ],
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: ListView.separated(
                                itemCount: _pasienList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PatienCard(
                                    name: _pasienList[index].name,
                                    umur: (DateTime.now().year -
                                            DateTime.parse(_pasienList[index]
                                                    .tanggal_lahir)
                                                .year)
                                        .toString(),
                                    id: _pasienList[index].id,
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
