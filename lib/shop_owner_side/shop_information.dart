import 'package:flutter/material.dart';
import 'package:resturent_book/dashboard_pages/profile.dart';

class Shop_Information extends StatefulWidget {
  @override
  _Shop_InformationState createState() => _Shop_InformationState();
}

class _Shop_InformationState extends State<Shop_Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Shop Info"),
      ),
      body: Profile(),
    );
  }
}
