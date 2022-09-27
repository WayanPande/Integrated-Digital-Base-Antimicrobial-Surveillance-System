import 'package:flutter/material.dart';
import 'package:project_pak_gusan/screens/profile_patien_screen.dart';

class PatienCard extends StatelessWidget {
  final String name, umur;
  final int id;

  const PatienCard(
      {Key? key, required this.name, required this.umur, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProfilePatienScreen(
                  id: id,
                );
              },
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF20BDB7),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${umur} th",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
