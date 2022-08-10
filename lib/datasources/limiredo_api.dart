import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'limiredo_api_constants.dart';
import 'package:limiredo/models/sound_model';

class LimiredoApi {
  Future<SoundModel?> getSound(int soundId) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.soundEndpoint + "/$soundId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        SoundModel _model = SoundModel.fromJson(json.decode(response.body));
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<http.Response> getSounds(int number) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.soundEndpoint +
          "/random?count=$number");
      var response = await http.get(url);
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<http.Response> getInterval() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.intervalEndpoint);
      var response = await http.get(url);
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
