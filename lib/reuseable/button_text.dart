import 'package:flutter/material.dart';

import '../styles/constants.dart';

class ButtonWithText extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const ButtonWithText({
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    double widthScale = MediaQuery.of(context).size.width / 207;
    double heightScale = MediaQuery.of(context).size.height / 448;

    return ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Login()),
          // );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(kDarkBlue),
        ),
        child: const Text('text'));
  }
}
