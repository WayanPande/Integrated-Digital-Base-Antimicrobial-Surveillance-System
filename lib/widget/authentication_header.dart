import 'package:flutter/material.dart';

class AuthenticationHeader extends StatelessWidget {
    const AuthenticationHeader({Key? key, required this.title, required this.description}) : super(key: key);

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Color(0xFF20BDB7),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
             Icon(
              Icons.heart_broken,
              size: 600,
              color: Colors.white.withOpacity(0.1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 60,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.heart_broken,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                  description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
