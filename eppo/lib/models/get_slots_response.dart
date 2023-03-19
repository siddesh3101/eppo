import 'dart:convert';

GetSlotResponse getSlotResponseFromJson(String str) =>
    GetSlotResponse.fromJson(json.decode(str));

String getSlotResponseToJson(GetSlotResponse data) =>
    json.encode(data.toJson());

class GetSlotResponse {
  GetSlotResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  String message;
  bool success;
  List<Datum> data;

  factory GetSlotResponse.fromJson(Map<String, dynamic> json) =>
      GetSlotResponse(
        message: json["message"],
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.start,
    required this.end,
    required this.isBooked,
  });

  String start;
  String end;
  bool isBooked;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        start: json["start"],
        end: json["end"],
        isBooked: json["isBooked"],
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
        "isBooked": isBooked,
      };
}
