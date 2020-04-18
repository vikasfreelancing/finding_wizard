import 'package:http/http.dart' as http;
import 'package:lost_and_found/dto/User.dart';
import 'dart:convert' as decoder;
import 'package:lost_and_found/constants/constants.dart';
import 'package:lost_and_found/model/findItem.dart';
import 'package:lost_and_found/model/LostItem.dart';

class ItemService {
  String data;
  int responseCode;
  Future<void> saveLostItem(User user, List<String> images) async {
    String url = "";
    for (String s in images) url += s + ",";
    print("Saving lost items with image urls : " + url);
    String endPoint = userPlatformbaseUrl + 'items/lost/save';
    print("endpoint : " + endPoint);
    print(decoder.jsonEncode(user.toJson()));
    http.Response response = await http.post(
      endPoint,
      body: decoder
          .jsonEncode({'images': url, 'userId': user.id, 'type': 'person'}),
      headers: {"Content-Type": "application/json"},
    );
    responseCode = response.statusCode;
    print("Response code: " + responseCode.toString());
    if (responseCode == 200) {
      data = response.body;
      print("Response : " + data);
    }
  }

  Future<void> saveFoundItem(User user, String url) async {
    print("saving found image in item service with url : " + url);
    print(decoder.jsonEncode(user.toJson()));
    http.Response response = await http.post(
      userPlatformbaseUrl + 'items/found/save',
      body: decoder
          .jsonEncode({'images': url, 'userId': user.id, 'type': 'person'}),
      headers: {"Content-Type": "application/json"},
    );
    responseCode = response.statusCode;
    print("Response Code : " + responseCode.toString());
    if (responseCode == 200) {
      data = response.body;
      print("Response body :" + data);
    }
  }

  Future<List<LostItem>> getLostItems(String userId) async {
    print(" Calling getLost Item Service");
    String url = (userId == null)
        ? userPlatformbaseUrl + '/items/lost/items'
        : userPlatformbaseUrl + '/items/lost/items?user_id=' + userId;
    http.Response response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print("Response get Lost Items : " + response.body);
      List<LostItem> items = (decoder.json.decode(response.body) as List)
          .map((i) => LostItem.fromJson(i))
          .toList();
      print(items.last.createdAt + " , " + items.last.id);
      return items;
    } else
      return null;
  }
}
