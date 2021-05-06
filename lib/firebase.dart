import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Firebase_Helper {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void insert_user_info(String id, String mail, String fullname) {
    databaseReference.child("users").child(id).set({
      'userid': id,
      'name': fullname,
      'mail': mail,
    });
  }

  Future<void> create_booking(String res_id, String res_name, String date, String clock,
      String people, String time, String image) async {
    String key = databaseReference.child("bookings").push().key.toUpperCase();
    String result;



    databaseReference
        .child("shops")
        .child(res_id)
        .child("booked_dates")
        .child(date)
        .child(time)
        .set('booked');

    databaseReference
        .child("bookings")
        .child(auth.currentUser.uid.toString())
        .child(key)
        .set({
      'shop_id': res_id,
      'shop_name': res_name,
      'date': date,
      'time': clock,
      'people': people,
      'time': time,
      'image': image,
      'booking_id': key,
      'status': 'waiting',
      'user_id': auth.currentUser.uid
    });



  }



  Future<String> check_status(String res_id, String res_name, String date, String clock,
      String people, String time, String image) async {
    String result;
    await databaseReference.child('shops').child(res_id)
        .child("booked_dates")
        .child(date)
        .child(time).once().
    then((snapshot){
      if(snapshot.value==null){
        result='notbooked';
      }
      else{
        result='booked';
      }
    });
    return result;
  }

  Future<String> reset_booking_status(String date,String uid) async {
    String result='ds';
    await databaseReference.child('shops').child(uid)
        .child("booked_dates")
        .child(date)
        .remove();

    return result;
  }

  void remove_booking(String bookingid) {
    databaseReference
        .child("bookings")
        .child(auth.currentUser.uid)
        .child(bookingid)
        .remove();
  }

  void update_stuats(String bookingid, String status, String uid) {
    databaseReference
        .child("bookings")
        .child(uid)
        .child(bookingid)
        .child('status')
        .set(status);
  }

  void insert_shop_info(
      String image, String fullname, String user, String limit) {
    databaseReference.child("shops").child(user).set({
      'id': user,
      'image': image,
      'name': fullname,
      'reviews': "234",
      'limit': limit
    });
  }
}
