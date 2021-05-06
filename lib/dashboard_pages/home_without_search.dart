import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
class Home_Dashboard extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20,right: 12,left: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Center(
                  child:   Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.transparent,
                          primaryColorDark: Colors.transparent,

                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Transform.rotate(
                                angle: 45,
                                child: Icon(LineAwesomeIcons.location_arrow,color: Colors.white,)),
                            SizedBox(width: 05,),

                            Text("Featured Shops",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                          ],
                        )
                    ),
                  )
              ),
              SizedBox(height: 20,),
              new Container(
                height: MediaQuery.of(context).size.height-167,
                child: new FirebaseAnimatedList(
                    query: FirebaseDatabase.instance
                        .reference().child("shops")
                        .orderByChild("reviews"),
                    padding: new EdgeInsets.only(bottom: 100),
                    reverse: false,
                    itemBuilder: (_, DataSnapshot snapshot,
                        Animation<double> animation, int x) {

                      return new Column(
                        children: [
                          Item(snapshot.value['name'].toString(),snapshot.value['image'].toString(),snapshot.value['reviews'].toString(),snapshot),
                          SizedBox(height: 20,),

                        ],

                      );
                    }

                ),
              ),

              // SizedBox(height: 20,),
              // Item("Pizza Hut","assets/buger.png","(300)"),
              // SizedBox(height: 10,),
              // Item("Subway","assets/sub.jpeg","(200)"),
              // SizedBox(height: 10,),
              // Item("Biryani House","assets/kar.jpg","(330)"),
              // SizedBox(height: 10,),
              // Item("Pizza Hut","assets/buger.png","(300)"),


            ],
          ),
        ),
      ),
    );
  }
  Widget Item(String name,String image, String reviews,DataSnapshot data){
    print(image);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black26,
      ),
      height: 250,

      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                color: Colors.black26,
                image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover
                )
            ),
            height: 185,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child:Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SizedBox(height: 03,),
                        Text(name,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 03,),
                        Row(
                          children: [
                            Container(

                              child: RatingBar.builder(
                                itemSize: 12,
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),

                              ),
                            ),
                            SizedBox(width: 03,),
                            Text("("+reviews+")",
                              style: GoogleFonts.poppins(fontSize: 10),)
                          ],
                        )
                      ],
                    ),flex: 3,),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(top: 07),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Navigator.pushNamed(context, "booking",arguments: data);
                            },
                            color: Colors.white,
                            textColor: Colors.black,
                            child: Text("BOOK NOW".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          )
                        ],
                      ),
                    ),flex:2)

                  ],
                ),
              )
          ),


        ],
      ),
    );
  }
}
