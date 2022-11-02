import 'dart:convert';

Amounts articlesFromJson(String str) => Amounts.fromJson(json.decode(str));

String articlesToJson(Amounts data) => json.encode(data.toJson());

class Amounts {
  Amounts({
    required this.id,
    required this.amount,
  });
  String id;
  String amount;

  factory Amounts.fromJson(Map<String, dynamic> json) => Amounts(
        id: json["id"] ?? "",
        amount: json["amount"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
      };
}
