import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/user.dart';
import '../utility/shared_preference.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggedIn,
  registered,
  authenticating,
  registering,
  loggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.notLoggedIn;
  Status _registeredInStatus = Status.notRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  // Future<Map<String?, dynamic>> register(String? fname, String lname,
  //     String email, String phone, String password) async {
  //   final Map<String?, dynamic> apiBodyData = {
  //     'firstName': fname,
  //     'lastName': lname,
  //     'email': email,
  //     'phoneNumber': phone,
  //     'password': password
  //   };
  //
  //   // return await post(AppUrl.register,
  //   //         body: json.encode(apiBodyData),
  //   //         headers: {'Content-Type': 'application/json'})
  //   //     .then(onValue)
  //   //     .catchError(onError);
  // }

  notify() {
    notifyListeners();
  }

  static Future<Map<String, dynamic>> onValue(Response response) async {
    var result;

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      var userData = responseData['user'];

      //model
      User authUser = User.fromJson(userData);

      //preferences
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Unsuccessfully registered',
        'data': responseData
      };
    }

    return result;
  }

  // Future<Map<String, dynamic>> login(
  //     String phoneNumber, String password) async {
  //   var result;
  //
  //   final Map<String, dynamic> loginData = {
  //     'phoneNumber': phoneNumber,
  //     'password': password
  //   };

  // _loggedInStatus = Status.authenticating;
  // notifyListeners();
  //
  // Response response = await post(
  //   // AppUrl.login,
  //   body: json.encode(loginData),
  //   headers: {'Content-Type': 'application/json'},
  // );

  //   if (response.statusCode == 200) {
  //     print("=======================workslogin===============");
  //
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //
  //     var userData = responseData['user'];
  //
  //     User authUser = User.fromJson(userData);
  //
  //     UserPreferences().saveUser(authUser);
  //
  //     _loggedInStatus = Status.loggedIn;
  //     notifyListeners();
  //
  //     result = {'status': true, 'message': 'Successful', 'user': authUser};
  //   } else {
  //     print(response);
  //     _loggedInStatus = Status.notLoggedIn;
  //     notifyListeners();
  //     result = {
  //       'status': false,
  //       'message': json.decode(response.body)['error']
  //     };
  //   }
  //   return result;
  // }

  static onError(error) {
    // print('Error is : ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
