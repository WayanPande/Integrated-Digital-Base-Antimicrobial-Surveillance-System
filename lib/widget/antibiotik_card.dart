import 'package:flutter/material.dart';
import 'package:project_pak_gusan/screens/profile_patien_screen.dart';

class AntibiotikCard extends StatelessWidget {
  const AntibiotikCard({Key? key, required this.namaAntibiotik, required this.dosis}) : super(key: key);

  final String namaAntibiotik, dosis;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaAntibiotik,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        dosis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
