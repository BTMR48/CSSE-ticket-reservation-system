import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/constants.dart';
import 'home.dart';

class BookTicket extends StatefulWidget {
  const BookTicket({Key? key}) : super(key: key);

  @override
  _BookTicketState createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  late double widthScale, heightScale;
  final formKey = GlobalKey<FormState>();
  late String from, to, date, time;

  @override
  Widget build(BuildContext context) {
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;

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
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: kWhite,
          ),
        ),
        title: Text(
          'Book a Ticket',
          style: GoogleFonts.dmSans(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kWhite,
          )),
        ),
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: SingleChildScrollView(child: bookTicketDetails()),
    );
  }

  Widget bookTicketDetails() {
    var doRecharge = () {
      print(" on do Recharge...");

      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Flushbar(
          title: 'Invalid form',
          message: 'Please complet the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: heightScale * 15,
            left: widthScale * 10,
            right: widthScale * 10,
          ),
          child: Text(
            'Please fill out the form below to receive a quote for your next journey',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: kWhite,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: heightScale * 30,
          ),
          child: Text(
            'Your Account Balance : ',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: kGrey,
            ),
          ),
        ),
        Text(
          'LKR 1500.00',
          style: GoogleFonts.roboto(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: kOrange,
          ),
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: widthScale * 30,
                  left: widthScale * 20,
                  right: widthScale * 20,
                  bottom: heightScale * 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: kDarkBlue.withOpacity(0.4),
                    ),
                    color: kWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScale * 10),
                    child: TextFormField(
                      autofocus: false,
                      validator: (value) =>
                          value!.isEmpty ? "Please Enter start Location" : null,
                      onSaved: (value) => from = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'From',
                        hintStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kDarkBlue.withOpacity(0.4),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widthScale * 20,
                  right: widthScale * 20,
                  bottom: heightScale * 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: kDarkBlue.withOpacity(0.4),
                    ),
                    color: kWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScale * 10),
                    child: TextFormField(
                      autofocus: false,
                      validator: (value) =>
                          value!.isEmpty ? "Please Enter End Location" : null,
                      onSaved: (value) => to = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'To',
                        hintStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kDarkBlue.withOpacity(0.4),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widthScale * 20,
                  right: widthScale * 20,
                  bottom: heightScale * 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: kDarkBlue.withOpacity(0.4),
                    ),
                    color: kWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScale * 10),
                    child: TextFormField(
                      autofocus: false,
                      validator: (value) =>
                          value!.isEmpty ? "Please Enter Date" : null,
                      onSaved: (value) => date = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Date',
                        hintStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kDarkBlue.withOpacity(0.4),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widthScale * 20,
                  right: widthScale * 20,
                  bottom: heightScale * 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: kDarkBlue.withOpacity(0.4),
                    ),
                    color: kWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: widthScale * 10),
                    child: TextFormField(
                      autofocus: false,
                      validator: (value) =>
                          value!.isEmpty ? "Please Enter Time" : null,
                      onSaved: (value) => time = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Time',
                        hintStyle: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kDarkBlue.withOpacity(0.4),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: widthScale * 100, top: heightScale * 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total Amount',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kOrange,
                ),
              ),
              Text(
                'Ticket ID : 225402',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kGrey,
                ),
              ),
              Text(
                'LKR 300.00',
                style: GoogleFonts.roboto(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: kOrange,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: heightScale * 20,
          ),
          child: ElevatedButton(
            onPressed: doRecharge,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(kOrange),
            ),
            child: Text(
              'Pay Amount',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
