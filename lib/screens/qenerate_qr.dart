import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

import '../model/journey.dart';
import '../styles/constants.dart';
import 'homescreen.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({Key? key}) : super(key: key);

  @override
  _GenerateQrState createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  late double widthScale, heightScale;
  List<Journey> journey = [];

  //fetch Details from the API CAll
  String url =
      'https://blackcode-bus-ticketing-system.herokuapp.com/api/v1/journey/getalljourney';
  Future getPastJourney() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
      });
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        PastJourney journeyDetails = PastJourney.fromJson(responseBody);
        print("======================Works=============================");
        for (int i = 0; i < journeyDetails.journey.length; i++) {
          journey.add(journeyDetails.journey[i]);
        }
      }
    } catch (e) {
      print("=================throwing Exception error==================");
      print("Error: $e");
      throw Exception("Error on server");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPastJourney();
  }

  @override
  Widget build(BuildContext context) {
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: kDarkBlue,
          ),
        ),
        title: Text(
          'Generate QR',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kDarkBlue,
          )),
        ),
        iconTheme: IconThemeData(color: kDarkBlue),
      ),
      body: generateqrDetails(),
    );
  }

  Widget generateqrDetails() {
    // final details = Provider.of<UserProvider>(context,listen:false);

    return Column(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: heightScale * 40, bottom: heightScale * 50),
          child: Center(
            child: Text(
              'Automatically QR code will generated',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kDarkBlue,
                ),
              ),
            ),
          ),
        ),
        QrImage(
          data: 'Black Code QR Generator Happy Journey \n\n '
              'UserName :  \n\n '
              'Phone Number : \n\n '
              'AccountBalance :\n\n '
              'Journey Details : ${journey} \n\n ',
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
      ],
    );
  }
}
