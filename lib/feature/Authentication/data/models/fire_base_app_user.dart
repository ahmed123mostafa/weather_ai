import 'package:flutter_weather_ai/feature/Authentication/domain/entities/app_user.dart';

class AppModel extends AppUser {
  AppModel({required super.email, required super.uid, required super.name});
  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(uid: json['uid'], email: json['email'], name: json['name']);
  }

  // Convert UserModel (data) to JSON (for Firebase)
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'name': name};
  }
}
