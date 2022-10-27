import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late double widthScale, heightScale;

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  final formKey = GlobalKey<FormState>();
  late String fname, lname, email, phone, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: RegisterDetails()),
      ),
    );
  }

  Widget RegisterDetails() {
    widthScale = MediaQuery.of(context).size.width / 207;
    heightScale = MediaQuery.of(context).size.height / 448;

    // AuthProvider auth = Provider.of<AuthProvider>(context);

    var loading = Padding(
      padding: EdgeInsets.only(
        bottom: widthScale * 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text("Registering.... Please wait"),
        ],
      ),
    );

    doRegister() {
      print('on doRegister');

      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();

        // auth.loggedInStatus = Status.authenticating;
        // auth.notify();
        //
        // Future.delayed(loginTime).then((_) {
        //   Navigator.pushReplacementNamed(context, '/login');
        //   auth.loggedInStatus = Status.loggedIn;
        //   auth.notify();
        // });

        // auth.register(fname, lname, email, phone, password).then((response){
        //   if(response['status']){
        //     print('===================================worksAuthRegister==========================');
        //     print(response['data']);
        //     User user = response['data'];
        //    // Provider.of<UserProvider>(context,listen: false).setUser(user);
        //     Navigator.pushReplacementNamed(context, '/login');
        //   }else{
        //     Flushbar(
        //       title: 'Registration Faild',
        //       message: response.toString(),
        //       duration: Duration(seconds: 10),
        //     ).show(context);
        //   }
        // });

      } else {
        Flushbar(
          title: 'Invalid form',
          message: 'Please complet the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: widthScale * 10,
          ),
          child: Text(
            'Create an account',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: kDarkBlue,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'Create Account And Make Your Journey Easy',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 16,
              color: kDarkBlue.withOpacity(0.7),
            ),
          ),
        ),

        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
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
                          value!.isEmpty ? "Please Enter First Name" : null,
                      onSaved: (value) => fname = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'First Name',
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
                          value!.isEmpty ? "Please Enter Last Name" : null,
                      onSaved: (value) => lname = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Last Name',
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
                      validator: (value) => value!.isEmpty
                          ? "Please Enter Valid Email Address"
                          : null,
                      onSaved: (value) => email = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Email Address',
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
                          value!.isEmpty ? "Please Enter Phone Number" : null,
                      onSaved: (value) => phone = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Phone Number',
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
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? "Please Enter Password" : null,
                      onSaved: (value) => password = value!,
                      style: TextStyle(color: kDarkBlue),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Password',
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
        // auth.loggedInStatus == Status.authenticating ? loading :
        GestureDetector(
          onTap: doRegister,
          child: Padding(
            padding: EdgeInsets.only(
                left: widthScale * 20,
                right: widthScale * 20,
                top: widthScale * 10,
                bottom: widthScale * 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: heightScale * 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kDarkBlue,
              ),
              child: Center(
                child: Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: kWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Text(
            "Already have an account",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: kDarkGreen,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
