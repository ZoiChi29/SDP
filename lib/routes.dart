import 'package:flutter/material.dart';
import 'package:resturent_book/auth_pages/signup.dart';
import 'package:resturent_book/dashboard_pages/home.dart';
import 'package:resturent_book/dashboard_pages/home_without_search.dart';
import 'package:resturent_book/pages/book.dart';
import 'package:resturent_book/pages/dashboard.dart';
import 'package:resturent_book/shop_owner_side/booking_list.dart';
import 'package:resturent_book/shop_owner_side/shop_information.dart';
import 'package:resturent_book/shop_owner_side/shop_login.dart';
import 'package:resturent_book/shop_owner_side/shop_owner_started.dart';
import 'package:resturent_book/shop_owner_side/shop_sign_up.dart';
import 'package:resturent_book/shop_owner_side/booking_list.dart';

import 'auth_pages/login.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var signuparg = settings.arguments;

  switch (settings.name) {
    case 'signup':
      return MaterialPageRoute(builder: (context) => SignUp());

    case 'login':
      return MaterialPageRoute(builder: (context) => Login());

    case 'dashboard':
      return MaterialPageRoute(builder: (context) => Dashbaord());

    case 'booking':
      return MaterialPageRoute(builder: (context) => book(signuparg));

    case 'shop_manager':
      return MaterialPageRoute(builder: (context) => Shop_Getting_Started());

    case 'shop_login':
      return MaterialPageRoute(builder: (context) => Login_Shop());

    case 'shop_signup':
      return MaterialPageRoute(builder: (context) => SignUp_Shop());

    case 'shop_bookings':
      return MaterialPageRoute(builder: (context) => Shop_Bookings_List());

    case 'shop_inforamtion':
      return MaterialPageRoute(builder: (context) => Shop_Information());
  }
}
