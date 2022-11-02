import 'dart:convert';

Bookings articlesFromJson(String str) => Bookings.fromJson(json.decode(str));

String articlesToJson(Bookings data) => json.encode(data.toJson());

class Bookings {
  Bookings({
    required this.id,
    required this.From,
    required this.To,
    required this.Date,
    required this.Time,
    required this.Amount,
  });
  String id;
  String From;
  String To;
  String Date;
  String Time;
  String Amount;

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        id: json["id"] ?? "",
        From: json["From"] ?? "",
        To: json["To"] ?? "",
        Date: json["Date"] ?? "",
        Time: json["Time"] ?? "",
        Amount: json["Amount"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "From": From,
        "To": To,
        "Date": Date,
        "Time": Time,
        "Amount": Amount,
      };
}
