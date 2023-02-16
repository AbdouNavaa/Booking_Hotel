import 'package:flutter/material.dart';
// import 'package:hotel_app/models/hotel.dart';

import '../data_service/book_service.dart';
import '../models/login_response_model.dart';
import 'booking.dart';

class HotelListScreen extends StatefulWidget {
  // final List<Hotel> hotels;

  HotelListScreen({required this.search, this.id, this.Username});
  final String search;
  final int? id;
  final String? Username;
  @override
  State<HotelListScreen> createState() => _HotelListScreen();
}
//
class _HotelListScreen extends State<HotelListScreen> {

  BookService bookService = BookService();
  late final Data data;
  // late List<Book>? books;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
  TextEditingController _controller = TextEditingController();
  // late String _searchTerm;
  late bool like = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hôtels de '+widget.search),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List>(
          future: bookService.getHotelsByPlace(widget.search),
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
                                    fav: like ?Icon(Icons.favorite_border): Icon(Icons.favorite),),
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
      ,);
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
    Key? key, required this.onPessed1, required this.icon, required this.title, required this.place, required this.hotelId, required this.fav,
  }) : super(key: key);
  final VoidCallback onPessed1;
  final UserPicture icon;
  final String title;
  final int hotelId;
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
