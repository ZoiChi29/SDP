import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:resturent_book/dashboard_pages/bookings_list.dart';
import 'package:resturent_book/dashboard_pages/home.dart';
import 'package:resturent_book/dashboard_pages/home_without_search.dart';
import 'package:resturent_book/dashboard_pages/profile.dart';
class Dashbaord extends StatefulWidget {
  @override
  _DashbaordState createState() => _DashbaordState();
}

class _DashbaordState extends State<Dashbaord> {
  int _selectedIndex = 0;
   List<Widget> _widgetOptions = <Widget>[
     Home_Dashboard(),
     Home(),
     Profile(),
     Bookings_List()


  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar:  Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child:  BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(LineAwesomeIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LineAwesomeIcons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LineAwesomeIcons.user),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LineAwesomeIcons.bookmark),
                  label: 'Bookings',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              unselectedItemColor: Colors.white,
              selectedLabelStyle: GoogleFonts.poppins(),
              onTap: _onItemTapped,
            ),
          )
      )




      
    );
  }
}
