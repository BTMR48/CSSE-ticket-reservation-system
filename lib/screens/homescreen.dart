import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ticketingsystem/screens/qenerate_qr.dart';
import 'package:ticketingsystem/screens/scan_qr.dart';

import '../styles/constants.dart';
import 'account.dart';
import 'book_ticket.dart';
import 'my_booking.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double widthScale, heightScale, width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#50C878').withOpacity(0.4),
        iconTheme: const IconThemeData(color: Colors.green),
        //leading:  Icon(Icons.menu,color: kDarkBlue,),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: widthScale * 10),
            child: const Icon(
              Icons.person,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: HomePageDetails(),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Text.rich(
                TextSpan(
                  text: 'Book',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: kGreen),
                  ),
                  children: [
                    TextSpan(
                      text: 'Now',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: kWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: kDarkBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              leading: Icon(
                Icons.home,
                color: kDarkBlue,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                'My Booking',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: kDarkBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              leading: Icon(
                Icons.bookmark,
                color: kDarkBlue,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyBooking()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Book a Ticket',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: kDarkBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              leading: Icon(
                Icons.library_books,
                color: kDarkBlue,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookTicket()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Scan QR Code',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: kDarkBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              leading: Icon(
                Icons.qr_code,
                color: kDarkBlue,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanQR()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Generate QR Code',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: kDarkBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              leading: Icon(
                Icons.qr_code_scanner_rounded,
                color: kDarkBlue,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GenerateQr()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Account',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: kDarkBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              leading: Icon(
                Icons.account_circle,
                color: kDarkBlue,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserAccount()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget HomePageDetails() {
    var loading = Padding(
      padding: EdgeInsets.only(
        bottom: widthScale * 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text("Loading.... Please wait"),
        ],
      ),
    );

    return Container(
      color: HexColor('#50C878').withOpacity(0.4),
      child: Padding(
        padding: EdgeInsets.only(
          left: widthScale * 10,
          right: widthScale * 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookTicket()),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        shadowColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/t4.png',
                              width: widthScale * 50,
                              height: heightScale * 50,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text("Long Term Pass",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w800)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Hey\nTravelers",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScanQR()),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        shadowColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/t2.png',
                              width: widthScale * 50,
                              height: heightScale * 50,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text("Rider Smart Card",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w800)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 38.0),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserAccount()),
                          );
                        },
                        child: Card(
                          color: Colors.white,
                          shadowColor: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/t3.png',
                                width: widthScale * 50,
                                height: heightScale * 50,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Text("Recharge Account",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: 350,
                    child: Card(
                      color: HexColor('#50C878').withOpacity(0.1),
                      shadowColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            "Quick travel for\n foreigners",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: SizedBox(
                              height: 170,
                              width: 180,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.asset(
                                        'assets/images/t1.png',
                                        width: widthScale * 80,
                                        height: heightScale * 70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/images/bus.png',
                width: widthScale * 80,
                height: heightScale * 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
