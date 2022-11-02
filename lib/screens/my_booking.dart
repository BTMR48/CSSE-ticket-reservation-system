import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../model/journey.dart';
import '../styles/constants.dart';
import 'homescreen.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({Key? key}) : super(key: key);

  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  late double widthScale, heightScale, width;
  List<Journey> journey = [];
  bool isLoading = false;

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
  }

  @override
  Widget build(BuildContext context) {
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kDarkBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkBlue,
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
            color: kWhite,
          ),
        ),
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: bookingDetails(),
    );
  }

  Widget bookingDetails() {
    // final details = Provider.of<UserProvider>(context,listen:false);
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
          Padding(
            padding: EdgeInsets.only(
              top: heightScale * 10,
              bottom: heightScale * 20,
            ),
            child: Text(
              'My Bookings',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: kWhite,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: null == journey ? 0 : journey.length,
              itemBuilder: (BuildContext context, int index) {
                return isLoading
                    ? loading
                    : Container(
                        height: heightScale * 100,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kWhite,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: widthScale * 10,
                            right: widthScale * 10,
                            top: widthScale * 10,
                            bottom: widthScale * 6,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Status',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: kGrey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Details',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: kGrey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Completed',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: kDarkBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${journey[index].startTime!.toString().substring(11, 16)} - ${journey[index].endTime.toString().substring(11, 16)} Am',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: kGrey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Trip ID : ' +
                                        journey[index]
                                            .id
                                            .toString()
                                            .substring(0, 10),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: kGrey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    //'20 JAN 2019',
                                    journey[index]
                                            .endTime
                                            .toString()
                                            .substring(8, 10) +
                                        '-' +
                                        journey[index]
                                            .endTime
                                            .toString()
                                            .substring(5, 7) +
                                        '-' +
                                        journey[index]
                                            .endTime
                                            .toString()
                                            .substring(0, 4),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: kGrey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              Text(
                                journey[index].startLocation! +
                                    '-' +
                                    journey[index].endLocation.toString(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: kDarkBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Price',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: kGrey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'LKR ' +
                                        journey[index].price.toString() +
                                        '.00',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: kDarkBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: heightScale * 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
