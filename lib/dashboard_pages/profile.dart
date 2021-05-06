import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 65,
              ),
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: SvgPicture.asset("assets/shop.svg"),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 167,
                child: new FirebaseAnimatedList(
                    query: FirebaseDatabase.instance
                        .reference()
                        .child("users")
                        .orderByChild('userid')
                        .startAt(auth.currentUser.uid.toString())
                        .endAt(auth.currentUser.uid.toString() + "\uf8ff"),
                    padding: new EdgeInsets.only(bottom: 100),
                    reverse: false,
                    itemBuilder: (_, DataSnapshot snapshot,
                        Animation<double> animation, int x) {
                      return new Column(
                        children: [
                          profile(snapshot),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profile(DataSnapshot data) {
    return Column(
      children: [
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Theme(
              data: new ThemeData(
                primaryColor: Colors.transparent,
                primaryColorDark: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      LineAwesomeIcons.user,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Name",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.white.withOpacity(.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          data.value['name'],
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        )),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Theme(
              data: new ThemeData(
                primaryColor: Colors.transparent,
                primaryColorDark: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 13, bottom: 05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      LineAwesomeIcons.envelope_open_text,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Email",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.white.withOpacity(.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          data.value['mail'],
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        )),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Theme(
              data: new ThemeData(
                primaryColor: Colors.transparent,
                primaryColorDark: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 08),
                child: ListTile(
                  title: Text(
                    "FAQS",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    LineAwesomeIcons.question_circle,
                    color: Colors.white,
                  ),
                ),
              )),
        )),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Theme(
              data: new ThemeData(
                primaryColor: Colors.transparent,
                primaryColorDark: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 08),
                child: ListTile(
                  title: Text(
                    "Help & Support",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(
                    LineAwesomeIcons.headset,
                    color: Colors.white,
                  ),
                ),
              )),
        )),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "login", (route) => false);
          },
          child: Center(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            child: Theme(
                data: new ThemeData(
                  primaryColor: Colors.transparent,
                  primaryColorDark: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 08),
                  child: ListTile(
                    title: Text(
                      "Logout",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      LineAwesomeIcons.alternate_sign_out,
                      color: Colors.white,
                    ),
                  ),
                )),
          )),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
