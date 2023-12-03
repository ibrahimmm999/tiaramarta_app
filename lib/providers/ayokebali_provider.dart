import 'package:flutter/material.dart';
import 'package:tiaraamarta_mobile/models/ayokebali_model.dart';
import 'package:tiaraamarta_mobile/services/ayokebali_service.dart';

class AyoKeBaliProvider extends ChangeNotifier {
  List<AyoKeBaliModel> _destinations = [];

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  List<AyoKeBaliModel> get destinations => _destinations;

  set setDestinations(List<AyoKeBaliModel> destinations) {
    _destinations = destinations;
    notifyListeners();
  }

  Future<bool> getDestinations(String accessToken) async {
    try {
      _destinations = await AyoKeBaliService().getDestinations(accessToken);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      print(e);
      rethrow;
    }
  }
}
