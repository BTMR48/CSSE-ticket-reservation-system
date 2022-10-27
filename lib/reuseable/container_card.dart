import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/constants.dart';

class ContainerWithText extends StatelessWidget {
  final Icon icon;
  final String text;

  const ContainerWithText({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double widthScale = MediaQuery.of(context).size.width / 207;
    double heightScale = MediaQuery.of(context).size.height / 448;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        left: widthScale * 10,
        right: widthScale * 10,
      ),
      child: Container(
        width: width,
        height: heightScale * 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kWhite,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: widthScale * 10,
          ),
          child: Row(
            children: <Widget>[
              icon,
              Padding(
                padding: EdgeInsets.only(
                  left: widthScale * 10,
                ),
                child: Text(
                  text,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: kDarkBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
