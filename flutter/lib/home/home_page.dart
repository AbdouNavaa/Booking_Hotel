// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:frontend/data_service/book_service.dart';
import 'package:frontend/home/reservation_details.dart';
import 'package:frontend/pages/login.dart';

import '../models/login_response_model.dart';
import 'HotelsByPlace.dart';
import 'booking.dart';

class Home extends StatefulWidget {
   Home({super.key, this.Username, this.id});
  final int? id;
  final String? Username;
  @override
  State<Home> createState() => _HomeState();
}
//
class _HomeState extends State<Home> {

  BookService bookService = BookService();
  late final Data data;
  // late List<Book>? books;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     like = false;
  }
  TextEditingController _controller = TextEditingController();
   late String _searchTerm;
   late bool like = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Hotels', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),),
          centerTitle: true,

          actions: [
            const Padding(padding: EdgeInsets.all(12.0)),


            IconButton(
              onPressed: () {     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ); },
              icon:  const Icon(
                Icons.logout_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],

        ),
        body: Padding(
            padding: EdgeInsets.only(top: 10),
              child: Column(
              children: [
              TextField(
                // maxLength: 20,
                style: TextStyle(height: 0.5),
              controller: _controller,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(50),),
              hintText: 'Enter search term',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              ),
              onChanged: (value) {
                  setState(() {
                  _searchTerm = value;
                  });
                },
    ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(355, 40),
                      backgroundColor: Colors.black,
                  ),
                  onPressed: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HotelListScreen( search: _searchTerm,Username: widget.Username,)),
                  );},
                      // bookService.getHotelsByPlace(_searchTerm),
                  child: Text('Search'),
                ),
    Expanded(child:
    FutureBuilder<List>(
        future: bookService.getBook(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i){
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Row(
                              children: [
                                HomeCard(onPessed1: (){
                                  setState(() {
                                    like = true;
                                    print(like);
                                  });
                                },
                                  //mages
                                  icon: UserPicture( picAdderess: 'images/'+ snapshot.data![i]["image"].split('/').last,
                                    onPressed: (){  }, hotelId:snapshot.data![i]["id"] ,Username: widget.Username),

                                  title:snapshot.data![i]["name"], place: snapshot.data![i]["place"], hotelId: (snapshot.data![i]["id"]),
                                  fav: like ?Icon(Icons.favorite_border): Icon(Icons.favorite), likes: snapshot.data![i]["likes"],),
                                SizedBox(width: 15,),
                              ],
                            ),
                          ]
                      ),
                    ),
                  );
                });
          }else{return CircularProgressIndicator();
          }
        })
      ,)
    ])));
  }
}

class UserPicture extends StatelessWidget {
  const UserPicture({Key? key, required this.picAdderess, required this.onPressed, required this.hotelId, this.Username}) : super(key: key);
  final String picAdderess;
  final VoidCallback onPressed;
  final int hotelId;
  final String? Username;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  BookingScreen(hotelId: hotelId,Username: Username,)),
        );
      },
      child: Container(
        color: Colors.grey,
        child: Image.asset(picAdderess, width: 290,height: 220,fit: BoxFit.cover,),
      ),
    )
    ;
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key, required this.onPessed1, required this.icon, required this.title, required this.place, required this.hotelId, required this.fav, required this.likes,
  }) : super(key: key);
  final VoidCallback onPessed1;
  final UserPicture icon;
  final String title;
  final int hotelId;
  final int likes;
  final String place;
  final Icon fav;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPessed1 ,
      child: Container(
        // margin: EdgeInsets.only(top: kDefaultPadding / 2),
        width: MediaQuery.of(context).size.width /1.2,
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
                Text(title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                  ),),
                // Text(hotelId.toString(),
                //   textAlign: TextAlign.start,
                //   style: TextStyle(
                //       fontSize: 20,
                //       color: Colors.blueGrey,
                //       fontStyle: FontStyle.italic,
                //       fontWeight: FontWeight.bold
                //   ),),
            IconButton(
              icon: fav,
              color: Colors.black,
               onPressed: onPessed1,
            ),
                Text(place,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold
                  ),),
              ],
            )


          ],
        ),
      ),
    );
  }
}
