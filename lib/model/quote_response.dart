// To parse this JSON data, do
//
//     final quoteResponse = quoteResponseFromJson(jsonString);

import 'dart:convert';

JokeResponse quoteResponseFromJson(String str) => JokeResponse.fromJson(json.decode(str));

String quoteResponseToJson(JokeResponse data) => json.encode(data.toJson());

class JokeResponse {
  JokeResponse({
    required this.id,
    required this.type,
    required this.setup,
    required this.punchline,
  });

  int id;
  String type;
  String setup;
  String punchline;

  factory JokeResponse.fromJson(Map<String, dynamic> json) => JokeResponse(
        id: json["id"],
        type: json["type"],
        setup: json["setup"],
        punchline: json["punchline"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "setup": setup,
        "punchline": punchline,
      };
}
