import 'package:flutter/material.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User();
  //TripId _tripId = TripId();

  User get user => _user;

  //TripId get tripId => _tripId;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
