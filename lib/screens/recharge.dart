import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../reuseable/text_field.dart';
import '../styles/constants.dart';
import 'home.dart';

class Recharge extends StatefulWidget {
  const Recharge({Key? key}) : super(key: key);

  @override
  _RechargeState createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  late double widthScale, heightScale, width;

  late int amount = 0;
  final formKey = GlobalKey<FormState>();

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
              MaterialPageRoute(builder: (context) => const HomePage()),
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

    var doRecharge = () {
      print(" on do Recharge...");
      print(amount);

      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        // details.user.accountBalance! +
        amount;
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
                        autofocus: false,
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
          GestureDetector(
            onTap: doRecharge,
            child: Padding(
              padding: EdgeInsets.only(
                top: heightScale * 15,
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
          ),
        ],
      ),
    );
  }
}
