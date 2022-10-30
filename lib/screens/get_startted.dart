import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/constants.dart';
import 'loginscreen.dart';

class GetStarted extends StatelessWidget {
  late double widthScale, heightScale, width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text.rich(
            TextSpan(
              text: 'Book',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 50, color: kGreen),
              ),
              children: [
                TextSpan(
                  text: 'Now',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: kDarkBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: heightScale * 15,
            ),
            child: Image.asset('assets/images/getstarted.png'),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: widthScale * 10,
              right: widthScale * 10,
              top: heightScale * 10,
            ),
            child: Text(
              'Quick @ Easy to Travel anywhere & anytime',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: kDarkBlue,
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: heightScale * 15,
            ),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(kDarkBlue),
                ),
                child: const Text('Get Started')),
          ),
        ],
      ),
    );
  }
}
