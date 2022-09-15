import 'package:flutter/material.dart';

class ProfileOptionButton extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function onClick;
  final Color color;

  const ProfileOptionButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onClick,
    this.color = Colors.black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
              onPressed: () {
                onClick(title, context);
              },
              style: ElevatedButton.styleFrom(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                primary: Colors.white,
                onPrimary: color,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon),
                        const SizedBox(width: 10,),
                        Text(
                            title
                        )
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    )
                  ],
                ),
              ),
            )
        )
      ],
    );
  }
}
