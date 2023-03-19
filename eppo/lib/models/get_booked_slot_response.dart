import 'dart:convert';

GetBookedSlotResponse getBookedSlotResponseFromJson(String str) =>
    GetBookedSlotResponse.fromJson(json.decode(str));

String getBookedSlotResponseToJson(GetBookedSlotResponse data) =>
    json.encode(data.toJson());

class GetBookedSlotResponse {
  GetBookedSlotResponse({
    required this.message,
    required this.success,
    required this.data,
  });

  String message;
  bool success;
  List<Datum> data;

  factory GetBookedSlotResponse.fromJson(Map<String, dynamic> json) =>
      GetBookedSlotResponse(
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
    required this.professionalId,
    required this.duration,
    required this.date,
    required this.time,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String professionalId;
  int duration;
  DateTime date;
  List<String> time;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        professionalId: json["professionalId"],
        duration: json["duration"],
        date: DateTime.parse(json["date"]),
        time: List<String>.from(json["time"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "professionalId": professionalId,
        "duration": duration,
        "date": date.toIso8601String(),
        "time": List<dynamic>.from(time.map((x) => x)),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
