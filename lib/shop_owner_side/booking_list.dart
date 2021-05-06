import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../firebase.dart';

class Shop_Bookings_List extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Shop_Bookings_List> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<dynamic, dynamic>> lists = [];
  Firebase_Helper helper = new Firebase_Helper();
  final dbRef = FirebaseDatabase.instance.reference().child("bookings");


  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate){
      Firebase_Helper help=new Firebase_Helper();
      help.reset_booking_status(  picked.toString().substring(0, 10),auth.currentUser.uid);
      setState(() {
        selectedDate = picked;
      });
      Fluttertoast.showToast(
          msg: "Selected Date Bookings Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Container(
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
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.bookmark,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 05,
                        ),
                        Text(
                          "Manage Your Shop",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              )),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'shop_inforamtion');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black45,
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info),
                              SizedBox(
                                width: 05,
                              ),
                              Text('Shop Info')
                            ],
                          )),
                        ),
                      ),
                    )),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          _selectDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.black45,
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.restore),
                                SizedBox(
                                  width: 05,
                                ),
                                Text('Reset')
                              ],
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Center(
                  child: Container(
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
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.bookmark,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 05,
                        ),
                        Text(
                          "Recent Bookings",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              )),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder(
                    future: dbRef.once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        lists.clear();

                        Map<dynamic, dynamic> values = snapshot.data.value;
                        values.forEach((key, values) {
                          for (var key in values.keys) {
                            if (auth.currentUser.uid ==
                                values[key]['shop_id']) {
                              lists.add(values[key]);
                            }
                          }
                        });
                        return new ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 05,
                                ),
                            shrinkWrap: true,
                            itemCount: lists.length,
                            itemBuilder: (BuildContext context, int index) {
                              print(lists.length);
                              return Bookingitem(lists[index]);
                            });
                      }
                      return CircularProgressIndicator();
                    }),
              )

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

  Widget Bookingitem(Map<dynamic, dynamic> lists) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black26,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black26,
                    image: DecorationImage(
                        image: NetworkImage(lists['image'].toString()),
                        fit: BoxFit.cover)),
                height: 90,
              ),
            ),
            flex: 5,
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 05, right: 15, top: 04),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 03,
                            ),
                            Text(
                              "BOOKING ID",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.white.withOpacity(.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              lists['booking_id'].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(.8)),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            Row(
                              children: [
                                Text(
                                  lists['shop_name'].toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '  ['+lists['people'].toString()+' Members] ',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 03,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 03,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 01),
                                  child: Text(
                                    lists['date'].toString(),
                                    style: GoogleFonts.poppins(fontSize: 10),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                booking_builder(lists['status']),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 01),
                                    child: Text(
                                      lists['time'].toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(fontSize: 10),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: lists['status'] == 'waiting'
                                        ? Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    helper.update_stuats(
                                                        lists['booking_id']
                                                            .toString(),
                                                        'declined',
                                                        lists['user_id']);
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.clear_sharp,
                                                    size: 25,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    helper.update_stuats(
                                                        lists['booking_id']
                                                            .toString(),
                                                        'accepted',
                                                        lists['user_id']);
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      size: 25)),
                                            ],
                                          )
                                        : SizedBox()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        flex: 3,
                      ),
                    ],
                  ),
                )),
            flex: 10,
          )
        ],
      ),
    );
  }

  Widget booking_builder(String status) {
    Color color;

    if (status == 'waiting') {
      color = Colors.orange;
    } else if (status == 'accepted') {
      color = Colors.green;
    } else if (status == 'declined') {
      color = Colors.red;
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(05)), color: color),
      child: Padding(
        padding: const EdgeInsets.only(left: 05, right: 05),
        child: Text(
          status,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }
}
