import 'dart:convert';
import 'package:frontend/models/login_request_model.dart';
import 'package:frontend/services/booking_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import 'package:http/http.dart' as httpC;

import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

class APIService {
  static var client = httpC.Client();


 static Future<int> login1(String username, String password) async {
    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var response = await httpC.post(Uri.parse('http://192.168.41.42:8080/accounts/login/'), body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      int userId = user['id'];
      return userId;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<bool> login(LoginRequestModel model) async {
    // Map<String, String> requestHeaders = {
    //   'Content-Type': 'application/json',
    // };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    print(model.username+" "+model.password+" From func");

    var response = await httpC.post(
        Uri.parse('http://192.168.43.73:8000/accounts/login/'),
        // headers: requestHeaders,
        body: {
          "username":model.username,
          "password":model.password
        });
    if (response.statusCode == 200) {
      print("___________________________________________________________________________ true");
      print(response.body);
      final prefs = await SharedPreferences.getInstance();
      final u = prefs.setString('userdata', response.body);
      return Future.value(true);
    } else {
      print("___________________________________________________________________________    false");
      return false;
    }
    return false;

  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson())
    );
    return registerResponseModel(response.body);
  }
}