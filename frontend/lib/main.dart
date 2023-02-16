import 'package:flutter/material.dart';
import 'package:frontend/home/home_page.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/register.dart';
// import 'package:toast/toast.dart';


import 'home/reservation.dart';
import 'home/reservation_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ToastContext().init(context);
    return MaterialApp(
        title: 'Hotel ',
        theme: ThemeData(
            // primarySwatch: Colors.grey
        ),
        debugShowCheckedModeBanner: false,
        routes:{
          '/': (context) => LoginPage(),
          '/home': (context) => Home(),
          // '/reservation': (context) => ReservationPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          // '/reservation_details': (context) => ReservationDetailsPage(username: '', roomId: 0, date: '',),
        }

    );
  }
}