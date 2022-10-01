import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_pak_gusan/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../providers/doctors.dart';
import '../util/sharedPreferences.dart';
import '../widget/profile_option_button.dart';

class ProfileDoctorScreen extends StatefulWidget {
  const ProfileDoctorScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDoctorScreen> createState() => _ProfileDoctorScreenState();
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Wrap(
      children: [
        Center(
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(15),
            child: const CircularProgressIndicator(),
          ),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _ProfileDoctorScreenState extends State<ProfileDoctorScreen> {
  File? _image;

  Future<void> onClick(String title, BuildContext context) async {
    final doctor = Provider.of<Doctors>(context, listen: false);

    if (title == "Logout") {
      removeDoktorId();
      doctor.loggedIn = false;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false);
    }

    if (title == "Ubah Foto Profil") {

      showBarModalBottomSheet(
        context: context,
        expand: false,
        builder: (context) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Ubah foto profil",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Ambil dari gallery",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: const Icon(
                Icons.add_photo_alternate,
                color: Colors.black,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 50,
                  preferredCameraDevice: CameraDevice.front,
                );
                if (image != null) {
                  setState(() {
                    _image = File(image.path);
                  });
                  doctor.uploadProfileImage(File(image.path));
                }
                if(!mounted) return;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                "Ambil dari kamera",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: const Icon(
                Icons.add_a_photo,
                color: Colors.black,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 50,
                  preferredCameraDevice: CameraDevice.front,
                );
                 if (image != null) {
                   setState(() {
                     _image = File(image.path);
                   });
                   doctor.uploadProfileImage(File(image.path));
                 }
                if(!mounted) return;
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var doctor = Provider.of<Doctors>(context);

    String getImageUrl() {
      if (doctor.dokterDetail.image != null) {
        if (dotenv.env['API_URL'] != null) {
          return "${dotenv.env['API_URL']}image_uploads/${doctor.dokterDetail.image}";
        }
      } else {
        return "https://avatars.dicebear.com/api/initials/${doctor.dokterDetail.nama}.jpg";
      }
      return "";
    }

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
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            getImageUrl(),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                              title: "Ulas Kami",
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
                              icon: Icons.edit_rounded,
                              title: "Ubah Foto Profil",
                              onClick: onClick),
                          const SizedBox(
                            height: 15,
                          ),
                          ProfileOptionButton(
                              icon: Icons.language,
                              title: "Bahasa",
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
