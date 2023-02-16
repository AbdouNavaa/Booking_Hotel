import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data_service/book_service.dart';

class ReservationDetailsPage extends StatelessWidget {
  // final String username;
  // final int roomId;
  // final double price;
  // final int days;
  // final DateTime date;

  // ReservationDetailsPage({
  //   // required this.username,
  //   // required this.roomId,
  //   // required this.date, required this.price, required this.days,
  // });
  double total =0;
  BookService bookService = BookService();
_getUserId() async {
    final prefs = await SharedPreferences.getInstance();
  final String? UserData = prefs.getString('userdata');
  var json = jsonDecode(UserData!);
   json['id'];
  print(json);
  }
    late String s =  _getUserId() ;

  @override
  Widget build(BuildContext context) {
    // var total = price * days;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Details'),
      ),
      body: Text('_getUserId()')
    );
  }
}
