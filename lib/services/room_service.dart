// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tiaraamarta_mobile/models/room_model.dart';
import 'package:tiaraamarta_mobile/services/url_service.dart';
import 'package:tiaraamarta_mobile/services/user_service.dart';

class RoomService {
  Future<List<RoomModel>> getRooms(String accessToken) async {
    var url = UrlService().api('room');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      List<RoomModel> room = List<RoomModel>.from(
        data.map((e) => RoomModel.fromJson(e)),
      );
      return room;
    } else {
      throw "Get data room failed";
    }
  }

  Future<bool> postRoom({
    required int id,
    required String name,
    required String price,
    required String desc,
    required String urlVideo,
    String? userId,
  }) async {
    late Uri url = UrlService().api('room');
    String? token = await UserService().getTokenPreference();
    print(token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };
    var body = {
      'id': id,
      'name': name,
      'price': int.parse(price),
      'description': desc,
      'url_video': urlVideo,
      'user': userId == null ? 0 : int.parse(userId),
    };
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        print(data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editRoom({
    required int id,
    required String name,
    required String price,
    required String desc,
    required String urlVideo,
    String? userId,
  }) async {
    late Uri url = UrlService().api('room/$id');
    String? token = await UserService().getTokenPreference();
    print(token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };
    var body = {
      'id': id,
      'name': name,
      'price': int.parse(price),
      'description': desc,
      'url_video': urlVideo,
      'user': userId == null ? 0 : int.parse(userId),
    };
    try {
      var response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        print(data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteRoom({
    required int id,
  }) async {
    late Uri url = UrlService().api('room/$id');
    String? token = await UserService().getTokenPreference();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token",
    };
    try {
      var response = await http.delete(
        url,
        headers: headers,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        print(data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
