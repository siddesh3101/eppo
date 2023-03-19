import 'dart:developer';

import 'package:dio/dio.dart';
// import 'package:eppo/models/get_slots_response.dart';
import 'package:intl/intl.dart';

// import '../models/chat_room.dart';

class AppointmentService {
  late final _apiLink;
  late final Dio _dio;
  late final _timeNow;
  AppointmentService() {
    _apiLink = "https://E4.adityasurve1.repl.co";
    _dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
        },
        baseUrl: _apiLink,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 200) < 500;
        },
      ),
    );
    _timeNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  // Future<ChatRoom> getChatMessages(String userId, String otherId) async {
  //   Response response = await _dio.get('/chat/room?uid=$userId&oid=$otherId');
  //   print(response.data);

  //   return ChatRoom.fromJson(response.data);
  // }

  Future<void> sendMessage(String userId, String otherId, String text) async {
    final data = {"id": userId, "oid": otherId, "message": text};
    Response response = await _dio.post('/chat/message', data: data);
  }

  // Future<GetSlotResponse> getSlotsByProfId(
  //     String professionalId, String token) async {
  //   final data = {"professionalId": professionalId};
  //   Response response = await _dio.post('/user/get-slot-by-professional-id',
  //       data: data,
  //       options: Options(headers: Map.fromEntries([MapEntry("token", token)])));
  //   print(response.data);
  //   return GetSlotResponse.fromJson(response.data);
  // }

  Future<Map<dynamic, dynamic>> getPendingAppointments() async {
    Response response =
        await _dio.post('/user/get-pending-appointments-by-professional-id',
            data: {"professionalId": "6415da02cc26535ffc32da5c"},
            options: Options(headers: {
              "token":
                  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MTU3Yjk5MzAzYWM0OGZiNjljZDEyZSIsImlhdCI6MTY3OTE3NjYzMiwiZXhwIjoxNjc5MjYzMDMyfQ._PwHChUhLHZzUWEfTPQ-ovut0p44W7J0OqGcTM8GX34"
            }));

    return response.data;
  }

  Future<bool> updateAppointment(String id) async {
    Response response = await _dio.post(
      '/user/change-appointment-status',
      data: {"appointmentId": id, "status": "approved"},
    );
    if (response.statusCode == 200) {
      print(response.data);
      return true;
    } else {
      return false;
    }
  }

  Future<List<dynamic>> getTrending() async {
    Response response = await _dio.get(
      '/user/get-users',
    );
    if (response.statusCode == 200) {
      print(response.data);
      return response.data["data"];
    } else {
      return [];
    }
  }

  Future<bool> release() async {
    Response response = await _dio.get(
      '/user/approved',
    );
    if (response.statusCode == 200) {
      print(response.data);
      return true;
    } else {
      return false;
    }
  }
}
