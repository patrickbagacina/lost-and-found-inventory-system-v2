import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int userId;
  String username;
  String name;
  String accessToken;

  User({
    required this.userId,
    required this.username,
    required this.name,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        username: json["username"],
        name: json["name"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "name": name,
        "access_token": accessToken,
      };
}
