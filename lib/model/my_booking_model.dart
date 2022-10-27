// To parse this JSON data, do
//
//     final tripClass = tripClassFromJson(jsonString);

import 'dart:convert';

TripClass tripClassFromJson(String str) => TripClass.fromJson(json.decode(str));

String tripClassToJson(TripClass data) => json.encode(data.toJson());

class TripClass {
  TripClass({
    required this.success,
    required this.trips,
  });

  bool success;
  List<Trip> trips;

  factory TripClass.fromJson(Map<String, dynamic> json) => TripClass(
    success: json["success"],
    trips: List<Trip>.from(json["trips"].map((x) => Trip.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "trips": List<dynamic>.from(trips.map((x) => x.toJson())),
  };
}

class Trip {
  Trip({
    this.isCompleted,
    this.id,
    this.tripId,
  });

  bool? isCompleted;
  String? id;
  TripId? tripId;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    isCompleted: json["isCompleted"],
    id: json["_id"],
    tripId: TripId.fromJson(json["tripID"]),
  );

  Map<String, dynamic> toJson() => {
    "isCompleted": isCompleted,
    "_id": id,
    "tripID": tripId!.toJson(),
  };
}

class TripId {
  TripId({
    this.price,
    this.countPassengers,
    this.maxPassengers,
    this.id,
    this.route,
    this.vehicalNumber,
    this.startTime,
    this.endTime,
    this.startLocation,
    this.endLocation,
    this.passengers,
    this.v,
  });

  int? price;
  int? countPassengers;
  int? maxPassengers;
  String? id;
  String? route;
  String? vehicalNumber;
  DateTime? startTime;
  DateTime? endTime;
  String? startLocation;
  String? endLocation;
  List<Passenger>? passengers;
  int? v;

  factory TripId.fromJson(Map<String, dynamic> json) => TripId(
    price: json["price"],
    countPassengers: json["countPassengers"],
    maxPassengers: json["maxPassengers"],
    id: json["_id"],
    route: json["route"],
    vehicalNumber: json["vehicalNumber"],
    startTime: DateTime.parse(json["startTime"]),
    endTime: DateTime.parse(json["endTime"]),
    startLocation: json["startLocation"],
    endLocation: json["endLocation"],
    passengers: List<Passenger>.from(json["passengers"].map((x) => Passenger.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "countPassengers": countPassengers,
    "maxPassengers": maxPassengers,
    "_id": id,
    "route": route,
    "vehicalNumber": vehicalNumber,
    "startTime": startTime!.toIso8601String(),
    "endTime": endTime!.toIso8601String(),
    "startLocation": startLocation,
    "endLocation": endLocation,
    "passengers": List<dynamic>.from(passengers!.map((x) => x.toJson())),
    "__v": v,
  };
}

class Passenger {
  Passenger({
    this.isPaid,
    this.checkInTime,
    this.checkOutTime,
    this.id,
    this.passengerId,
  });

  bool? isPaid;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  String? id;
  String? passengerId;

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    isPaid: json["isPaid"],
    checkInTime: DateTime.parse(json["checkInTime"]),
    checkOutTime: DateTime.parse(json["checkOutTime"]),
    id: json["_id"],
    passengerId: json["passengerID"],
  );

  Map<String, dynamic> toJson() => {
    "isPaid": isPaid,
    "checkInTime": checkInTime!.toIso8601String(),
    "checkOutTime": checkOutTime!.toIso8601String(),
    "_id": id,
    "passengerID": passengerId,
  };
}
