import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:canoa_v3_frontend/models/search_song.dart';
import 'package:http/http.dart' as http;
import 'package:canoa_v3_frontend/models/song.dart';
class API {
  /// local dev environment
  static final String _url = "http://127.0.0.1:5000/api=";
  /// dev environment
  // static final String _url = "http://192.168.1.76:5000/api=";


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/search_song.json');
  }

  static Future<List<SearchSong>> fetchAvailableSongs() async {
      print(_url + "get_available_songs");
      var response = await http.get(Uri.parse(_url + "get_available_songs"));
      var body = json.decode(response.body);
      var res = body["data"].map<SearchSong>(SearchSong.fromJson).toList();
      return res;
  }
}