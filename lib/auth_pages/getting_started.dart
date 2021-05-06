import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Getting_Started extends StatefulWidget {
  @override
  _Getting_StartedState createState() => _Getting_StartedState();
}

class _Getting_StartedState extends State<Getting_Started> {
  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget build(BuildContext context) {
    // createData();

    SystemChrome.setEnabledSystemUIOverlays([]);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Container(
                      child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: SvgPicture.asset(
                          "assets/appointment.svg",
                          color: Colors.white,
                          height: 100,
                        ),
                      ),
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Book Appointment Easily From Home",
                          style: GoogleFonts.poppins(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "Book Appointment Easily From Anywhere Without Payment",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withOpacity(.8),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Navigator.pushNamed(context, "signup");
                            },
                            color: Colors.white,
                            textColor: Colors.black87,
                            child: Text("Create an Account",
                                style: GoogleFonts.poppins(fontSize: 14)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            },
                            color: Colors.transparent,
                            textColor: Colors.white,
                            child: Text("Login with e-mail",
                                style: GoogleFonts.poppins(fontSize: 14)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {
                              Navigator.pushNamed(context, 'shop_manager');
                            },
                            color: Colors.transparent,
                            textColor: Colors.white,
                            child: Text("Shop Manager Access",
                                style: GoogleFonts.poppins(fontSize: 14)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            decoration: new BoxDecoration(
              color: Colors.black,
              image: new DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: new AssetImage("assets/ap.jpg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
