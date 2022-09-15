import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:project_pak_gusan/providers/doctors.dart';
import 'package:project_pak_gusan/screens/register_screen.dart';
import 'package:project_pak_gusan/util/data_class.dart';
import 'package:provider/provider.dart';

import '../widget/authentication_header.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
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

class _LoginScreenState extends State<LoginScreen> {
  bool isPassShown = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<Doctors>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (doctor.loggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ),
        );
      }

      if (doctor.items.isNotEmpty && doctor.items['msg'] == "fail") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          dismissOnTouchOutside: false,
          animType: AnimType.bottomSlide,
          title: 'Login gagal !',
          desc: 'Silahkan cek apakah email dan password yang anda masukan benar.',
          autoHide: const Duration(seconds: 3),
          btnOkColor: const Color(0xFF20BDB7),
        ).show();
        doctor.items = {};
      }
    });



    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthenticationHeader(
              title: "Login.",
              description: "Log in to continue",
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: !isPassShown,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPassShown = !isPassShown;
                          });
                        },
                        icon: Icon(
                          isPassShown ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showLoaderDialog(context);
                            doctor
                                .login(
                                  LoginData(
                                      email: email.text,
                                      password: password.text),
                                )
                                .then((value) => Navigator.pop(context));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum memiliki akun ?",
                        style: TextStyle(
                          color: Color(0xFFAFA1A1),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterScreen();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Color(0xFF20BDB7),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
