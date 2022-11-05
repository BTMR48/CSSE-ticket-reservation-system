import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ticketingsystem/styles/constants.dart';
import '../model/bookingModel.dart';
import '../model/user_model.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  String? userId;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  bool loading = false;
  @override
  initState() {
    super.initState();
    loading = true;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.formMap(value.data());
      setState(() {});
    });
  }

  Future<List<Bookings>> fetchRecords() async {
    var records = await FirebaseFirestore.instance
        .collection('users')
        .doc("${loggedInUser.uid}")
        .collection("booking")
        .get();
    return mapRecords(records);
  }

  List<Bookings> mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (booking) => Bookings(
            id: booking.id,
            From: booking['From'],
            To: booking['To'],
            Date: booking['Date'],
            Time: booking['Time'],
            Amount: booking['Amount'],
          ),
        )
        .toList();

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor('#00FFFF').withOpacity(0.4),
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: height * 0.10, bottom: height * 0.025),
            child: Text(
              'My Bookings',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: kWhite,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              //chip words
              children: <Widget>[
                const SizedBox(height: 10),
                SizedBox(
                    width: width,
                    height: height * 0.70,
                    child: FutureBuilder<List<Bookings>>(
                        future: fetchRecords(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Bookings> data = snapshot.data ?? [];

                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return (SizedBox(
                                    height: 50,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Text(
                                                  data[index].From,
                                                  style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: HexColor('#abf7b1')
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Text(
                                                    data[index].To,
                                                    style: GoogleFonts.dmSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: HexColor('#abf7b1')
                                                          .withOpacity(0.4),
                                                    ),
                                                  )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Text(
                                                  data[index].Date +
                                                      ' ' +
                                                      data[index].Time,
                                                  style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: HexColor('#abf7b1')
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Text(
                                                  data[index].Amount,
                                                  style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: HexColor('#abf7b1')
                                                        .withOpacity(0.4),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // ListTile(
                                        //   leading: Text(data[index].From,style: TextStyle(color: Colors.white)),
                                        //   title: Text(data[index].To),
                                        //   trailing: Text(data[index].Amount),
                                        // )
                                       
                                      ],
                                    ),
                                  ));
                                });
                          }
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
