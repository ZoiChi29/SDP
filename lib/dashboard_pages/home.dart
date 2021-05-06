import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = new TextEditingController();
  bool issearch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                        child: Container(
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
                        child: TextFormField(
                          controller: search,
                          style: GoogleFonts.poppins(color: Colors.white),
                          //controller: searchc,
                          decoration: InputDecoration(
                            border: InputBorder.none,

//                      border: new OutlineInputBorder(
//                          borderSide: new BorderSide(color: Colors.transparent,width: 0.0)),
                            contentPadding: EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 20,
                                right: 10), // add padding to adjust icon
                            isDense: true,
                            hintText: "Search",
                            hintStyle: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ),
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 10), // add padding to adjust icon
                    child: issearch == false
                        ? InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                issearch = true;
                              });
                            },
                            child: Icon(
                              Icons.search_sharp,
                              size: 25,
                              color: Colors.white,
                            ))
                        : InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                issearch = false;
                              });
                            },
                            child: Icon(
                              Icons.clear,
                              size: 25,
                              color: Colors.white,
                            )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              new Container(
                height: MediaQuery.of(context).size.height - 167,
                child: new FirebaseAnimatedList(
                    query: FirebaseDatabase.instance
                        .reference()
                        .child("shops")
                        .orderByChild("reviews"),
                    padding: new EdgeInsets.only(bottom: 100),
                    reverse: false,
                    itemBuilder: (_, DataSnapshot snapshot,
                        Animation<double> animation, int x) {
                      if (issearch) {
                        if (snapshot.value['name']
                            .toString()
                            .toLowerCase()
                            .contains(search.text.toLowerCase())) {
                          return new Column(
                            children: [
                              Item(
                                  snapshot.value['name'].toString(),
                                  snapshot.value['image'].toString(),
                                  snapshot.value['reviews'].toString(),
                                  snapshot),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        } else {
                          SizedBox();
                        }
                      } else {
                        return new Column(
                          children: [
                            Item(
                                snapshot.value['name'].toString(),
                                snapshot.value['image'].toString(),
                                snapshot.value['reviews'].toString(),
                                snapshot),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      }
                      return SizedBox();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Item(String name, String image, String reviews, DataSnapshot data) {
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.black26,
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
            height: 185,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 03,
                          ),
                          Text(
                            name,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 03,
                          ),
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
                              SizedBox(
                                width: 03,
                              ),
                              Text(
                                "(" + reviews + ")",
                                style: GoogleFonts.poppins(fontSize: 10),
                              )
                            ],
                          )
                        ],
                      ),
                      flex: 3,
                    ),
                    Expanded(
                        child: Padding(
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
                                  Navigator.pushNamed(context, "booking",
                                      arguments: data);
                                },
                                color: Colors.white,
                                textColor: Colors.black,
                                child: Text("BOOK NOW".toUpperCase(),
                                    style: TextStyle(fontSize: 14)),
                              )
                            ],
                          ),
                        ),
                        flex: 2)
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
