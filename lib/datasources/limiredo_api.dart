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
}
