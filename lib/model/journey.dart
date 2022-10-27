// To parse this JSON data, do
//
//     final pastJourney = pastJourneyFromJson(jsonString);

import 'dart:convert';

PastJourney pastJourneyFromJson(String str) => PastJourney.fromJson(json.decode(str));

String pastJourneyToJson(PastJourney data) => json.encode(data.toJson());

class PastJourney {
  PastJourney({
    required this.success,
    required this.journey,
  });

  bool success;
  List<Journey> journey;

  factory PastJourney.fromJson(Map<String, dynamic> json) => PastJourney(
    success: json["success"],
    journey: List<Journey>.from(json["journey"].map((x) => Journey.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "journey": List<dynamic>.from(journey.map((x) => x.toJson())),
  };
}

class Journey {
  Journey({
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
  List<dynamic>? passengers;
  int? v;

  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
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
    passengers: List<dynamic>.from(json["passengers"].map((x) => x)),
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
    "passengers": List<dynamic>.from(passengers!.map((x) => x)),
    "__v": v,
  };
}
