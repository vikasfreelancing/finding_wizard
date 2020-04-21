import 'package:http/http.dart' as http;
import 'package:lost_and_found/dto/User.dart';
import 'dart:convert' as decoder;
import 'package:lost_and_found/constants/constants.dart';

class UserService {
  String data;
  int responseCode;
  Future<User> registerUser(User user) async {
    print(decoder.jsonEncode(user.toJson()));
    http.Response response = await http.post(
      userPlatformbaseUrl + 'user/register',
      body: decoder.jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    responseCode = response.statusCode;
    print("Response code : " + responseCode.toString());

    if (responseCode == 441) {
      User temp = User();
      temp.message = "Email Already in use ";
      return temp;
    }

    if (responseCode == 200 && response != null && response.body != null) {
      data = response.body;
      print("response : " + data);
      User user = User.fromJson(decoder.json.decode(data));
      user.message = "Registered sucessfully";
      return user;
    } else
      return null;
  }

  Future<User> loginUser(String email, String password) async {
    print("User Email :" + email);
    print("User Password :" + password);
    http.Response response = await http.post(
      userPlatformbaseUrl + 'user/login',
      body: decoder
          .jsonEncode({'email': email.trim(), 'password': password.trim()}),
      headers: {"Content-Type": "application/json"},
    );
    responseCode = response.statusCode;
    print("Response Code : " + responseCode.toString());
    if (responseCode == 200 && response.body != null) {
      data = response.body;
      print("Response Body : " + data);
      if (response == null || data == null) return null;
      try {
        User user = User.fromJson(decoder.json.decode(data));
      } on Exception {
        return null;
      }
      return User.fromJson(decoder.json.decode(data));
    } else
      return null;
  }
}
