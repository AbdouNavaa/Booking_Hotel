import 'dart:convert';
// import 'package:frontend/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookService {
  String BASE_URL = 'http://192.168.43.73:8000/';
  var client = http.Client();

//   Future<void> _storeUserId(int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setInt('user_id', id);
//   }
//
// // Get the user id from the local preferences
//   Future<int> _getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getInt('user_id')!;
//   }
  Future<List> getBook() async {
try {
  var response =
  await http.get(Uri.parse(BASE_URL+"booking/HotelListView/"));
  // await http.get(Uri.parse("http://10.0.2.2:8000/booking/bookList/"));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
    print('4e sla7 --------------------------------------------');
  } else {
    return Future.error('Server Error');
    print('4e 5asser sa77bi mad5al======================================');
  }
}catch(e){
  return Future.error(e);
}
  }
  Future<List<Hotel>> fetchData(String searchTerm) async {
    // API URL to fetch data
    try{
      var response =
      await http.get(Uri.parse(BASE_URL+"booking/HotelListView/"));

      // Parse data from API response
      // ...
      List<Hotel> dataList = [];
      // Filter data based on searchTerm
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        assert(data != null);
        assert(data['results'] != null);
        List<Hotel> filteredData = dataList.where((hotel) => hotel.place.contains(searchTerm)).toList();

        // Return filtered data
        return filteredData;
      } else {
        throw Exception('Failed to load data');
      }
    }
    catch(e){
      print(e.toString());

      // Return an empty list on error
      return [];
    }
  }
   String API_URL = 'http://192.168.43.73:8000/booking/hotels/';

  Future<List> getHotelsByPlace(String place) async {
    final response = await http.get(Uri.parse(API_URL + place ));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      print('4e sla7 --------------------------------------------');
    } else {
      return Future.error('Server Error');
      print('4e 5asser sa77bi mad5al======================================');
    }
  }

  Future<List> getRoom(int id) async {
try {
  var response =
  await http.get(Uri.parse(BASE_URL+"booking/api/hotels/$id/rooms/rooms/"));
  // await http.get(Uri.parse("http://10.0.2.2:8000/booking/bookList/"));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
    print('4e sla7 --------------------------------------------');
  } else {
    return Future.error('Server Error');
    print('4e 5asser sa77bi mad5al======================================');
  }
}catch(e){
  return Future.error(e);
}
  }
  Future<List> getBookings(int id) async {
try {
  var response =
  await http.get(Uri.parse(BASE_URL+"api/bookings/$id/books/books"));
  // await http.get(Uri.parse("http://10.0.2.2:8000/booking/bookList/"));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
    print('4e sla7 --------------------------------------------');
  } else {
    return Future.error('Server Error');
    print('4e 5asser sa77bi mad5al======================================');
  }
}catch(e){
  return Future.error(e);
}
  }

  Future<http.Response> addReservation(String username, int IdRoom, DateTime date,) async {
    Map<String, dynamic> data = {
      'username': username,
      'date': date,
      'IdRoom': IdRoom.toString(),
    };

    final response = await http.post(Uri.parse(BASE_URL+'booking/api/reservations/'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data)).then((response) {
      if (response.statusCode == 200) {
        print('Reservation created successfully');
      } else {
        print('Failed to create reservation');
      }
    });

    return response;
  }
   static Future<bool> createReservation(String username, int roomId, DateTime date) async {
    final response =  await http.post(Uri.parse('http://192.168.43.73:8000/booking/api/reservation/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'room_id': roomId, 'date': date.toString()}),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      // error
      print("---------------Desole-----------------");
      return false;
    }
  }


  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? UserData = prefs.getString('userdata');
    var json = jsonDecode(UserData!);
    return json['id'];
    // print(json);
  }

}

//http://192.168.43.73:8000/booking/api/reservations/

class Room {


  Room({
    required this.id,
    required this.type,
    required this.amount,
    required this.image,
    required this.hotelId, required available,
  });

  late final int id;
  late final String type;
  late final double amount;
  late final bool available;
  late final String image;
  late final int hotelId;

  factory Room.fromJson(map) {
    return Room(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      available: map['available'],
      image: map['image'],
      hotelId: map['hotelId'],
    );
  }
}
class User {


  User({
    required this.id,
    required this.username,
  });

  late final int id;
  late final String username;

  factory User.fromJson(map) {
    return User(
      id: map['id'],
      username: map['username'],
    );
  }
}
class Hotel {


  Hotel({
    required this.hotelId,
    required this.name,
    required this.place,
    required this.image,
    required this.likes,
  });
  late final int hotelId;
  late final String name;
  late final String place;
  late final String image;
  late final int likes;

  factory Hotel.fromJson(map) {
    return Hotel(
      hotelId: map['hotelId'],
      name: map['name'],
      place: map['place'],
      image: map['image'],
      likes: map['likes'],
    );
  }
}
