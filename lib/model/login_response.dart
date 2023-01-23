///    Created By Bhavesh Makwana on 11/01/23
import 'dart:convert';

LoginResponse? loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse? data) => json.encode(data!.toJson());

class LoginResponse {
  LoginResponse({
    this.token,
  });

  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
