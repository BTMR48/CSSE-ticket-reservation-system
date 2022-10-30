import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late double widthScale, heightScale, width, height;

  final formKey = GlobalKey<FormState>();

  late String _phoneNumber, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: LoginBody()),
      ),
    );
  }

  Widget LoginBody() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
          Text("Login.... Please wait"),
        ],
      ),
    );

    doLogin() {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();
        print(_phoneNumber);
        print(_password);
        //
        // final Future<Map<String,dynamic>> response = auth.login(_phoneNumber,_password);

        // response.then((response){
        //   if(response['status']){
        //     print("========================works======================");
        //     User user = response['user'];
        //     // Provider.of<UserProvider>(context,listen: false).setUser(user);
        //     Navigator.pushReplacementNamed(context, '/home');
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

    return Padding(
      padding: EdgeInsets.only(
        top: widthScale * 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Log In',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: kDarkBlue,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: heightScale * 15,
              ),
              child: Image.asset(
                'assets/images/login.jpg',
                width: widthScale * 100,
                height: heightScale * 100,
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
                            value!.isEmpty ? "Please Enter Phone Number" : null,
                        onSaved: (value) => _phoneNumber = value!,
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
                        onSaved: (value) => _password = value!,
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
          Padding(
            padding: EdgeInsets.only(
                left: widthScale * 20,
                right: widthScale * 20,
                top: widthScale * 30,
                bottom: widthScale * 20),
            child: GestureDetector(
              onTap: doLogin,
              child: Container(
                width: width,
                height: heightScale * 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kDarkBlue,
                ),
                child: Center(
                  child: Text(
                    'Log In',
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
              Navigator.pushReplacementNamed(context, '/register');
            },
            child: Text(
              "Don't have an account",
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
      ),
    );
  }
}
