// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tiaraamarta_mobile/models/ayokebali_model.dart';
import 'package:tiaraamarta_mobile/services/url_service.dart';

class AyoKeBaliService {
  Future<List<AyoKeBaliModel>> getDestinations(String accessToken) async {
    var url = UrlService().api('destination');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    var response = await http.get(
      url,
      headers: headers,
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      List<AyoKeBaliModel> destination = List<AyoKeBaliModel>.from(
        data.map((e) => AyoKeBaliModel.fromJson(e)),
      );
      return destination;
    } else {
      throw "Get data destination failed";
    }
  }
}
