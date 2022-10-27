import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ticketingsystem/screens/qenerate_qr.dart';
import 'package:ticketingsystem/screens/recharge.dart';
import 'package:ticketingsystem/screens/scan_qr.dart';

import '../model/journey.dart';
import '../styles/constants.dart';
import 'account.dart';
import 'book_ticket.dart';
import 'my_booking.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double widthScale, heightScale, width, height;

  late DateTime date;
  late String formattedDate, formattedTime;
  List<Journey> journey = [];
  late bool isLoading = false;

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
          setState(() {
            isLoading = true;
          });
        }
        setState(() {
          isLoading = false;
        });
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
    // final details = <UserProvider>(context, listen: false);
    // isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;

    date = DateTime.now();
    formattedDate = DateFormat('yyyy/MMM/d').format(date);
    formattedTime = DateFormat('kk:mm').format(date);

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhite,
        iconTheme: IconThemeData(color: kDarkBlue),
        //leading:  Icon(Icons.menu,color: kDarkBlue,),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: widthScale * 10),
            child: Icon(
              Icons.notifications_none,
              color: kDarkBlue,
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
              decoration: BoxDecoration(
                color: kDarkBlue,
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
                  MaterialPageRoute(builder: (context) => const HomePage()),
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
    // final details = Provider.of<UserProvider>(context, listen: false);
    // AuthProvider auth = Provider.of<AuthProvider>(context);

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

    return Padding(
      padding: EdgeInsets.only(
        left: widthScale * 10,
        right: widthScale * 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Welcome, ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: kDarkBlue,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: widthScale * 10,
            ),
            child: Container(
              width: width,
              height: heightScale * 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kDarkBlue,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: widthScale * 10,
                  top: heightScale * 15,
                  right: widthScale * 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today is',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                      )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formattedDate,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: kWhite,
                            ),
                          ),
                        ),
                        Text(
                          formattedTime,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: kWhite,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: heightScale * 15,
            ),
            child: Text.rich(
              TextSpan(
                text: 'Account Balance : ',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: kGrey,
                      wordSpacing: 5),
                ),
                children: [
                  TextSpan(
                    text: 'LKR ' +
                        //details.user.accountBalance.toString()
                        '.00',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: kDarkBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: heightScale * 10,
              bottom: heightScale * 15,
            ),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Recharge()),
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
                child: Text(
                  'Recharge',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
                ),
              ),
            ),
          ),
          Text(
            'Special Routes',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kDarkBlue,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                ListView.separated(
                  itemCount: null == journey ? 0 : journey.length,
                  itemBuilder: (BuildContext context, int index) {
                    return isLoading
                        ? loading
                        : Padding(
                            padding: EdgeInsets.only(
                              top: heightScale * 10,
                              bottom: heightScale * 6,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      journey[index].startLocation! +
                                          ' - ' +
                                          journey[index].endLocation!,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: kDarkBlue,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Starting Time ' +
                                          journey[index]
                                              .startTime!
                                              .toString()
                                              .substring(0, 10) +
                                          '  ' +
                                          journey[index]
                                              .startTime!
                                              .toString()
                                              .substring(11, 16),
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: kGrey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'From ' + journey[index].startLocation!,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: kGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: widthScale * 25,
                                  height: heightScale * 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: kGrey,
                                  ),
                                  child: Center(
                                    child: Text(
                                      journey[index].route!,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: kWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 2,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
