import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ticketingsystem/model/amount_model.dart';

import '../model/user_model.dart';
import '../reuseable/text_field.dart';
import '../styles/constants.dart';
import 'homescreen.dart';

class Recharge extends StatefulWidget {
  const Recharge({Key? key}) : super(key: key);

  @override
  _RechargeState createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  late double widthScale, heightScale, width;

  late int amount;
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;
    width = MediaQuery.of(context).size.width;

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
          'Recharge',
          style: GoogleFonts.dmSans(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kWhite,
          )),
        ),
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: rechargeDetails(),
    );
  }

  Widget rechargeDetails() {
    // final details = Provider.of<UserProvider>(context,listen:false);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: widthScale * 15,
              bottom: widthScale * 15,
            ),
            child: Image.asset(
              'assets/images/recharge.png',
              width: widthScale * 50,
              height: heightScale * 50,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: widthScale * 50, right: widthScale * 15),
            child: Row(
              children: [
                const Text(
                  "Available Amount : RS.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "${oneAmount?.amount}",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFieldRounded(
                  color: kWhite,
                  placeHolder: 'Card type',
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
                        controller: amountController,
                        autofocus: true,
                        validator: (value) =>
                            value!.isEmpty ? "Please Enter Amount" : null,
                        onSaved: (value) => amount = value! as int,
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
                TextFieldRounded(
                  color: kWhite,
                  placeHolder: 'Card Number',
                ),
                TextFieldRounded(
                  color: kWhite,
                  placeHolder: 'CVC',
                ),
                TextFieldRounded(
                  color: kWhite,
                  placeHolder: 'Card Holder Name',
                ),
                TextFieldRounded(
                  color: kWhite,
                  placeHolder: 'Expiry date',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: heightScale * 15,
            ),
            child: ElevatedButton(
              onPressed: displayMessage,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(kOrange),
              ),
              child: Text(
                'Recharge',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          // Text(
          //   "${loggedInUser.uid}",
          //   style: GoogleFonts.roboto(
          //     textStyle: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //       color: kWhite,
          //     ),
          //   ),
          // ),
          // Text(
          //   "${oneAmount?.amount}",
          //   style: GoogleFonts.roboto(
          //     textStyle: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //       color: kWhite,
          //     ),
          //   ),
          // ),
        ],
      ),
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

    final reference = FirebaseFirestore.instance.doc('recharge/$id');
    final snapshot = reference.get();

    final result = await snapshot.then(
        (snap) => snap.data() == null ? null : Amounts.fromJson(snap.data()!));
    print('result is ====> $result');
    setState(() {
      oneAmount = result;
      loading = false;
    });
    print(oneAmount?.amount);
  }

  void displayMessage() {
    if (amountController.text != null) {
      int amount = (int.tryParse(oneAmount!.amount) ?? 0) +
          (int.tryParse(amountController.text) ?? 0);

      FirebaseFirestore.instance
          .collection("recharge")
          .doc("${loggedInUser.uid}")
          .set({
        "amount": amount.toString(),
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc("${loggedInUser.uid}")
          .collection("recharge")
          .doc("${loggedInUser.uid}")
          .set({
        "amount": amountController.text,
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }
}
