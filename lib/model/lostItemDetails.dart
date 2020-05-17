import 'package:lost_and_found/dto/User.dart';
import 'package:lost_and_found/model/LostItem.dart';
import 'package:lost_and_found/model/findItem.dart';
import 'dart:convert' as decoder;

class LostItemDetailsModel {
  User user;
  User foundUser;
  FoundItem foundItem;
  LostItem lostItem;
  LostItemDetailsModel.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        foundItem = FoundItem.fromJson(json['foundItem']),
        lostItem = LostItem.fromJson(json['lostItem']),
        foundUser = User.fromJson(json['foundUser']);
}
