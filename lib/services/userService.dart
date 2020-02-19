import 'package:http/http.dart' as http;
import 'package:lost_and_found/dto/User.dart';
import 'dart:convert' as decoder;

class UserService {
  String data;
  int responseCode;
  Future<void> registerUser(User user) async {
    print(decoder.jsonEncode(user.toJson()));
    http.Response response = await http.post(
      'https://userplatform.herokuapp.com//register',
      body: decoder.jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      data = response.body;
      print(data);
    }
  }

  Future<User> loginUser(String email, String password) async {
    print(email);
    print(password);
    http.Response response = await http.post(
      'https://userplatform.herokuapp.com//login',
      body: decoder.jsonEncode({'email': email, 'password': password}),
      headers: {"Content-Type": "application/json"},
    );
    responseCode = response.statusCode;
    print(responseCode);
    if (responseCode == 200) {
      data = response.body;
      print(data);
      return User.fromJson(decoder.json.decode(data));
    } else
      return null;
  }
}
