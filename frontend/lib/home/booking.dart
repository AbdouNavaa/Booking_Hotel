// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/data_service/book_service.dart';
import 'package:frontend/home/reservation.dart';
import 'package:frontend/models/login_response_model.dart';
import 'package:frontend/pages/login.dart';

import 'booking.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key, required this.hotelId, this.Username});
  final int hotelId;
  final String? Username;

  // int? UserId;
  // LoginResponseModel model = LoginResponseModel( key: '');

  // String? username;
  BookService bookService = BookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Details du hotel', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),),
        centerTitle: true,
      ),

      body: Container(
          child:
          FutureBuilder<List>(
              future: bookService.getRoom(hotelId),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, i){
                        return SingleChildScrollView(
                          child: Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Row(
                                      children: [
                                        HomeCard( onPessed: (){Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReservationPage(username: Username!,id: snapshot.data![i]["id"],
                                price: double.parse(snapshot.data![i]["amount"]),)),
                              ); },
                              // onPessed: () =>     bookService.addReservation(Username!,
                                          //   DateTime.now().toString(), snapshot.data![i]["id"],),
                                        //  Navigator.push(
                                          //                           context,
                                          //                           MaterialPageRoute(builder: (context) => ReservationPage()),
                                          //                           ); }

                                            icon: UserPicture( picAdderess: 'images/'+ snapshot.data![i]["image"].split('/').last, onPressed: () {  },
                                             ),
                                            type:snapshot.data![i]["type"], amount: double.parse(snapshot.data![i]["amount"]),),

                                      ],
                                    ),
                                  ]
                              )),
                        );
                      });
                }else{return CircularProgressIndicator();};
              })
      ),
    );
  }
}

class UserPicture extends StatelessWidget {
  const UserPicture({Key? key, required this.picAdderess, required this.onPressed}) : super(key: key);
  final String picAdderess;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        color: Colors.grey,
        child: Image.asset(picAdderess, width: 300,height: 200,fit: BoxFit.cover,),
      ),
    )
    ;
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key, required this.onPessed, required this.icon, required this.type, required this.amount,
  }) : super(key: key);
  final VoidCallback onPessed;
  final UserPicture icon;
  final String type;
  final double amount;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){} ,
      child: Container(
        width: MediaQuery.of(context).size.width /1.01,
        height: MediaQuery.of(context).size.height/ 2.3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(type,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                  ),),
                Text(amount.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                  ),),
              ],
            ),
            ElevatedButton(onPressed: onPessed, child: Text("Book"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 50),
                  backgroundColor: Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }
}
