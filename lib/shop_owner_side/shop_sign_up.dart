import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resturent_book/firebase.dart';
import 'package:path/path.dart';

class SignUp_Shop extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp_Shop> {
  final formkey = new GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool radio = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _limit = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  File _imageFile;
  final picker = ImagePicker();
  bool _success;
  String _userEmail;
  String _password;
  String _fullname;

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  String url;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  uploadImageToFirebase(var users, BuildContext context, String uid) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();

    if (_imageFile != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage
          .ref()
          .child('images/imageName' + uid + DateTime.now().toString())
          .putFile(_imageFile);
      var downloadUrl =
          await snapshot.ref.getDownloadURL().then((value) => url = value);
      setState(() {
        Firebase_Helper helper = new Firebase_Helper();
        helper.insert_user_info(
            uid, _emailController.text, _fullnameController.text);
        helper.insert_shop_info(
            url, _fullnameController.text, uid, _limit.text);
        Fluttertoast.showToast(
            msg: "Sign Up Completed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        _responsehandle(
            users,
            message(
                "Sign Up Completed", Icons.check_circle_outline, Colors.green),
            context);
      });
    } else {
      print('No Image Path Received');
    }
  }

  Widget build(BuildContext context) {
    print(url);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add Your Shop",
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                pickImage();
                              },
                              child: Container(
                                height: 100,
                                child: SvgPicture.asset(
                                  "assets/add.svg",
                                  color: Colors.white,
                                  height: 150,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 35, right: 35),
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  TextFormField(
                                    controller: _fullnameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Shop Name';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    keyboardType: TextInputType.name,
                                    decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.all(0.0),
                                        labelText: "Enter your Shop Name",
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
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _limit,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter Booking Limit';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    keyboardType: TextInputType.name,
                                    decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.all(0.0),
                                        labelText:
                                            "Enter your shop booking limit",
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
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Email';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.all(0.0),
                                        labelText: "Enter e-mail",
                                        labelStyle: GoogleFonts.poppins(
                                          //  fontFamily: "OpenSansBold",
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
                                    obscureText: true,
                                    controller: _passwordController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Password';
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
                                          //fontFamily: "OpenSansBold",
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
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    "By Signing Up you agree to our Terms and Conditions.",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      // fontFamily: 'OpenSans',
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side:
                                              BorderSide(color: Colors.white)),
                                      onPressed: () async {
                                        if (true) {
                                          //onLoading(context);

                                          try {
                                            final user = (await _auth
                                                    .createUserWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            ))
                                                .user;
                                            uploadImageToFirebase(
                                                user, context, user.uid);
                                          } catch (error) {
                                            print(error.code);
                                            switch (error.code) {
                                              case 'email-already-in-use':
                                                _responsehandle(
                                                    null,
                                                    message(
                                                        "Duplicate Email",
                                                        Icons.cancel,
                                                        Colors.red),
                                                    context);
                                                break;
                                              case 'network-request-failed':
                                                _responsehandle(
                                                    null,
                                                    message(
                                                        "No Network Connection",
                                                        Icons.network_check,
                                                        Colors.orange),
                                                    context);
                                                break;
                                              case 'invalid-email':
                                                _responsehandle(
                                                    null,
                                                    message(
                                                        "Invalid Email",
                                                        Icons.alternate_email,
                                                        Colors.red),
                                                    context);
                                                break;
                                            }
                                          }
                                        }
                                      },
                                      textColor: Colors.black87,
                                      color: Colors.white,
                                      child: Text(
                                          "Click to Register Your Restaurant",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            )),
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
      ),
    );
  }

  Widget _responsehandle(var user, Widget response, BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);

            return null;
          },
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
