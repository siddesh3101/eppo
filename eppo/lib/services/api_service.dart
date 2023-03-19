import 'dart:developer';

import 'package:dio/dio.dart';
// import 'package:eppo/models/get_slots_response.dart';
import 'package:intl/intl.dart';

// import '../models/chat_room.dart';
import 'package:eppo/models/get_booked_slot_response.dart';
import 'package:eppo/models/get_slots_response.dart';
import 'package:eppo/models/order.dart';
import 'package:intl/intl.dart';

import '../models/chat_room.dart';

class ApiService {
  late final _apiLink;
  late final Dio _dio;
  late final _timeNow;
  ApiService() {
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
  Future<ChatRoom> getChatMessages(String userId, String otherId) async {
    Response response = await _dio.get('/chat/room?uid=$userId&oid=$otherId');
    print(response.data);

    return ChatRoom.fromJson(response.data);
  }

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

  Future<Map<dynamic, dynamic>> getQueueDetails() async {
    Response response = await _dio.get('/user/virtualqueue',
        options: Options(headers: {
          "token":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MTU3Yjk5MzAzYWM0OGZiNjljZDEyZSIsImlhdCI6MTY3OTE3NjYzMiwiZXhwIjoxNjc5MjYzMDMyfQ._PwHChUhLHZzUWEfTPQ-ovut0p44W7J0OqGcTM8GX34"
        }));
    print(response.data);
    return response.data;
  }

  Future<GetSlotResponse> getSlotsByProfId(
      String professionalId, String token, String date) async {
    final data = {"professionalId": professionalId, "date": date};
    Response response = await _dio.post(
        '/user/get-slot-by-professional-id-final',
        data: data,
        options: Options(headers: Map.fromEntries([MapEntry("token", token)])));
    print(response.data);
    return GetSlotResponse.fromJson(response.data);
  }

  Future<GetBookedSlotResponse> getBookedSlotByDayAndProfId(
      String token, String professionalId, String date) async {
    final data = {"professionalId": professionalId, "date": date};
    Response response = await _dio.post(
        '/user/get-booked-appointments-by-professional-id',
        data: data,
        options: Options(headers: Map.fromEntries([MapEntry("token", token)])));
    print(response.data);
    return GetBookedSlotResponse.fromJson(response.data);
  }

  Future<bool> bookSlot(String token, String professionalId, String date,
      List<String> time) async {
    final data = {"professionalId": professionalId, "date": date, "time": time};
    Response response = await _dio.post('/user/book-appointment-final',
        data: data,
        options: Options(headers: Map.fromEntries([MapEntry("token", token)])));
    print(response.data);
    return response.data["success"];
  }

  Future<void> sendFcmToken(String token, String userId) async {
    final data = {"id": userId, "token": token};
    Response response = await _dio.post('/user/pushToken', data: data);
    print(response.data);
  }

  Future<Order> getOrder(String professionalId) async {
    var data = {"pid": professionalId};
    Response response = await _dio.post('/user/getprice', data: data);
    print(response.data);
    return Order.fromJson(response.data);
  }
}
