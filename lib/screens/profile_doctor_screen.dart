import 'package:flutter/material.dart';
import 'package:project_pak_gusan/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../providers/doctors.dart';
import '../util/sharedPreferences.dart';
import '../widget/profile_option_button.dart';

class ProfileDoctorScreen extends StatelessWidget {
  const ProfileDoctorScreen({Key? key}) : super(key: key);

  void onClick(String title, BuildContext context) {
    final doctor = Provider.of<Doctors>(context, listen: false);

    if (title == "Logout") {
      removeDoktorId();
      doctor.loggedIn = false;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var doctor = Provider.of<Doctors>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Profile Dokter",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://avatars.dicebear.com/api/adventurer-neutral/${doctor.dokterDetail.nama!}.jpg")),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        doctor.dokterDetail.nama!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Information",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileOptionButton(
                              icon: Icons.book, title: "FAQ", onClick: onClick),
                          const SizedBox(
                            height: 15,
                          ),
                          ProfileOptionButton(
                              icon: Icons.star,
                              title: "Rate Us",
                              onClick: onClick),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Preference",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileOptionButton(
                              icon: Icons.language,
                              title: "Language",
                              onClick: onClick),
                          const SizedBox(
                            height: 15,
                          ),
                          ProfileOptionButton(
                              icon: Icons.logout,
                              title: "Logout",
                              color: Colors.red,
                              onClick: onClick),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
