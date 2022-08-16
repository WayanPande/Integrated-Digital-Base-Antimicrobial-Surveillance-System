import 'package:flutter/material.dart';

class PatienData extends StatelessWidget {
  const PatienData({Key? key, required String this.title, required String this.content}) : super(key: key);

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${title} :",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          content,
        ),
      ],
    );
  }
}
