import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ticketingsystem/screens/homescreen.dart';
import 'package:ticketingsystem/screens/recharge.dart';

import '../model/user_model.dart';
import '../reuseable/container_card.dart';
import '../styles/constants.dart';
import 'login.dart';
import 'my_booking.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key}) : super(key: key);

  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  late double widthScale, heightScale;
  // for fetch data 14 th line and 15 th line very important
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.formMap(value.data());
      setState(() {});
    });
  }

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
          'Account',
          style: GoogleFonts.dmSans(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kWhite,
          )),
        ),
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: accountDetails(),
    );
  }

  Widget accountDetails() {
    // final details = Provider.of<UserProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: heightScale * 30,
          ),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            radius: 40,
          ),
        ),
        Text(
          "${loggedInUser.uid}",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
        ),
        Text(
          "${loggedInUser.email}",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
        ),
        Text(
          "${loggedInUser.firstName}${loggedInUser.secondName}",
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: kWhite,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Recharge()),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: heightScale * 40,
              bottom: heightScale * 10,
            ),
            child: ContainerWithText(
                icon: Icon(
                  Icons.receipt,
                  color: kDarkBlue,
                ),
                text: 'Recharge'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyBooking()),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: heightScale * 10,
            ),
            child: ContainerWithText(
                icon: Icon(
                  Icons.history_edu,
                  color: kDarkBlue,
                ),
                text: 'History'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: heightScale * 10,
            ),
            child: ContainerWithText(
                icon: Icon(
                  Icons.account_balance,
                  color: kDarkBlue,
                ),
                text: 'Account Balance'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: heightScale * 10,
            ),
            child: ContainerWithText(
                icon: Icon(
                  Icons.logout,
                  color: kDarkBlue,
                ),
                text: 'Log Out'),
          ),
        ),
      ],
    );
  }
}
