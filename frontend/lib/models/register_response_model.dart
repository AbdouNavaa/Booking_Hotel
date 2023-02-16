import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));
class RegisterResponseModel {
  RegisterResponseModel({required this.message, required this.data});
  late final String message;
  late final Data? data;
  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = this.message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  // String token;

  Data({required this.username, required this.email, required this.password1, required this.password2});
  late final String username;
  late final String email;
  late final String password1;
  late final String password2;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password1 = json['password1'];
    password2 = json['password2'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = this.username;
    _data['email'] = this.email;
    _data['password1'] = this.password1;
    _data['password2'] = this.password2;
    return _data;
  }
}


