import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('_id', user.id.toString());
    prefs.setString('firstName', user.firstName.toString());
    prefs.setString('lastName', user.lastName.toString());
    prefs.setString('email', user.email.toString());
    prefs.setInt('phoneNumber', user.phoneNumber!.toInt());
    prefs.setString('password', user.password.toString());

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString('_id');
    String? firstName = prefs.getString('firstName');
    String? lastName = prefs.getString('lastName');
    String? email = prefs.getString('email');
    int? phoneNumber = prefs.getInt('phoneNumber');
    String? password = prefs.getString('password');

    return User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password);
  }
}
