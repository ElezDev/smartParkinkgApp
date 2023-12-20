import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String token;

    User({
        required this.token,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
