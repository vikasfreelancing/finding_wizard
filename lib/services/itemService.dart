import 'package:http/http.dart' as http;
import 'package:lost_and_found/dto/User.dart';
import 'dart:convert' as decoder;

class ItemService {
  String data;
  int responseCode;
  Future<void> saveItem(User user, List<String> images) async {
    String url = "";
    for (String s in images) url += s + ",";
    print(decoder.jsonEncode(user.toJson()));
    http.Response response = await http.post(
      'http://localhost:9093/saveItem',
      body: decoder
          .jsonEncode({'images': url, 'userId': user.id, 'type': 'person'}),
      headers: {"Content-Type": "application/json"},
    );
    responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      data = response.body;
      print(data);
    }
  }

  Future<void> saveFoundItem(User user, String url) async {
    print(decoder.jsonEncode(user.toJson()));
    http.Response response = await http.post(
      'http://localhost:9093/saveFoundItem',
      body: decoder
          .jsonEncode({'images': url, 'userId': user.id, 'type': 'person'}),
      headers: {"Content-Type": "application/json"},
    );
    responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      data = response.body;
      print(data);
    }
  }
}
