import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/amount_model.dart';
import '../model/user_model.dart';
import '../styles/constants.dart';
import 'homescreen.dart';

class BookTicket extends StatefulWidget {
  const BookTicket({Key? key}) : super(key: key);

  @override
  _BookTicketState createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  late double widthScale, heightScale;
  final formKey = GlobalKey<FormState>();
  late String from, to, date, time;
  // get text field
  TextEditingController sampledata1 = new TextEditingController();
  TextEditingController sampledata2 = new TextEditingController();
  TextEditingController sampledata3 = new TextEditingController();
  TextEditingController sampledata4 = new TextEditingController();
  TextEditingController sampledata5 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;

    return Scaffold(
      backgroundColor: HexColor('#00FFFF').withOpacity(0.4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#00FFFF').withOpacity(0.4),
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
          MaterialPageRoute(builder: (context) => HomeScreen()),
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
          "${oneAmount?.amount}",
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
                      controller: sampledata1,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start location';
                        }
                        return null;
                      },
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
                      controller: sampledata2,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter end location';
                        }
                        return null;
                      },
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
                      controller: sampledata3,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter date';
                        }
                        return null;
                      },
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
                      controller: sampledata4,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter time';
                        }
                        return null;
                      },
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
                      controller: sampledata5,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                      onSaved: (value) => time = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Amount',
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
          padding: EdgeInsets.only(
            top: heightScale * 20,
          ),
          child: ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (formKey.currentState!.validate()) {
                displayMessage();
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(kOrange),
            ),
            child: Text(
              'Book',
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

  String? userId;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  Amounts? oneAmount;
  bool loading = false;
  @override
  initState() {
    super.initState();
    loading = true;
    getAmount();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.formMap(value.data());
      setState(() {});
    });
  }

  Future<void> getAmount() async {
    final id = user!.uid;

    final reference = FirebaseFirestore.instance.doc('users/$id/recharge/$id');
    final snapshot = reference.get();

    final result = await snapshot.then(
        (snap) => snap.data() == null ? null : Amounts.fromJson(snap.data()!));
    print('result is ====> $result');
    setState(() {
      oneAmount = result;
      loading = false;
    });
  }

  void displayMessage() {
    int amount = (int.tryParse(oneAmount!.amount) ?? 0) -
        (int.tryParse(sampledata5.text) ?? 0);
    if (amount >= 0) {
      FirebaseFirestore.instance
          .collection("users")
          .doc("${loggedInUser.uid}")
          .collection("booking")
          .doc()
          .set({
        "From": sampledata1.text,
        "To": sampledata2.text,
        "Date": sampledata3.text,
        "Time": sampledata4.text,
        "Amount": sampledata5.text,
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc("${loggedInUser.uid}")
          .collection("recharge")
          .doc("${loggedInUser.uid}")
          .set({
        "amount": amount.toString(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('successfully booked')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Insufficient balance"),
      ));
    }
  }
}
