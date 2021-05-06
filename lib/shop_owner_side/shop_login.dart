import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login_Shop extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login_Shop> {
  bool radio = false;
  final TextEditingController emailcont = TextEditingController();
  final TextEditingController passcont = TextEditingController();
  final formkey = new GlobalKey<FormState>();

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            child: SvgPicture.asset(
                              "assets/shop.svg",
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: Form(
                          key: formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login to Continue",
                                style: GoogleFonts.poppins(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              TextFormField(
                                controller: emailcont,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(0.0),
                                    labelText: "Enter e-mail",
                                    labelStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      //  when the TextFormField in unfocused
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                      //  when the TextFormField in focused
                                    ),
                                    border: UnderlineInputBorder()),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: passcont,
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.all(0.0),
                                    labelText: "Enter password",
                                    labelStyle: GoogleFonts.poppins(
                                      // fontFamily: "OpenSansBold",
                                      color: Colors.white,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      //  when the TextFormField in unfocused
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                      //  when the TextFormField in focused
                                    ),
                                    border: UnderlineInputBorder()),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            child: radio
                                                ? Icon(
                                                    Icons.not_interested,
                                                    size: 20.0,
                                                    color: Color(0xff71828A),
                                                  )
                                                : Icon(
                                                    Icons.check_circle,
                                                    size: 20.0,
                                                    color: Colors.white,
                                                  ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              radio = !radio;
                                            });
                                          },
                                        ),
                                        InkWell(
                                            child: Text(
                                              '  Remember me',
                                              style: GoogleFonts.poppins(
                                                color: Color(0xff71828A),
                                                fontSize: 12,
                                                //  fontFamily: 'Poppins',
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                radio = !radio;
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            child: Text('Forgot password?',
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xff71828A),
                                                  fontSize: 12,
                                                  //  fontFamily: 'Poppins',
                                                )),
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "forgetpass");
                                            },
                                          )
                                        ],
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "With our app you can win prize with foodball anytime and everywhere",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white.withOpacity(.8),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: BorderSide(color: Colors.white)),
                                  onPressed: () async {
                                    if (formkey.currentState.validate()) {
                                      //   onLoading(context);
                                      try {
                                        //   LinkApi apilink=await fetchlink();

                                        final user = (await _auth
                                                .signInWithEmailAndPassword(
                                          email: emailcont.text,
                                          password: passcont.text,
                                        ))
                                            .user;
                                        Navigator.pushNamed(
                                            context, "shop_bookings");
                                      } catch (error) {
                                        //print(error.code);
                                        switch (error.code) {
                                          case 'user-not-found':
                                            _responsehandle(
                                                null,
                                                message("Incorrect Email",
                                                    Icons.close, Colors.red));
                                            break;
                                          case 'wrong-password':
                                            _responsehandle(
                                                null,
                                                message("Wrong Password",
                                                    Icons.close, Colors.red));
                                            break;
                                          case 'invalid-email':
                                            _responsehandle(
                                                null,
                                                message(
                                                    "Invalid Email",
                                                    Icons.alternate_email,
                                                    Colors.red));
                                            break;
                                        }
                                      }
                                    }
                                  },
                                  color: Colors.white,
                                  textColor: Colors.black87,
                                  child: Text("Login into Shop",
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
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: new AssetImage("assets/ap.jpg"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _responsehandle(var user, Widget response) {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            //Navigator.pop(context);
            return null;
          },
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              //Navigator.pop(context);
            },
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: response,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget message(String message, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        new Icon(
          icon,
          color: color,
          size: 50,
        ),
        SizedBox(
          height: 20,
        ),
        new Text(
          message,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
