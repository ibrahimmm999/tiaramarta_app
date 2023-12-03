import 'package:flutter/material.dart';
import 'package:tiaraamarta_mobile/models/room_model.dart';
import 'package:tiaraamarta_mobile/services/room_service.dart';

class RoomProvider extends ChangeNotifier {
  List<RoomModel> _listRoom = [];

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  List<RoomModel> get listRoom => _listRoom;

  set setlistRoom(List<RoomModel> listRoom) {
    _listRoom = listRoom;
    notifyListeners();
  }

  Future<bool> getDataRooms(String accessToken) async {
    try {
      _listRoom = await RoomService().getRooms(accessToken);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      print(_errorMessage);
      rethrow;
    }
  }
}
