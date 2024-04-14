import 'package:deapplication/database/Database.dart';
import 'package:deapplication/homepage/homepage.dart';
import 'package:deapplication/homepage/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class splashpage extends StatefulWidget {
  static SharedPreferences? prefe;
  static Database? db1;

  @override
  State<splashpage> createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  bool status = false;
  String name = "";
  String email = "";
  int? id;
//   String name12 = splashpage.prefe!.getString("getprofilename") ?? "Name";
// // String profilepic = splashpage.prefe!.getString("getprofilepic") ?? "pic";
//   String email12 =splashpage.prefe!.getString("getprofileemail") ?? "xyz@gmail.com";
//   double number = splashpage.prefe!.getDouble("getprofilenumber") ?? 0000;
//   String dob = splashpage.prefe!.getString("getprofiledob") ?? "00/00/0000";
//   String gender = splashpage.prefe!.getString("getprofilegender")?? " ";
//   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Lottie.asset("Icon/98481-e-commerce-shop-online.json"),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    foraddpersonaldata();
    forlogindata();
    forinsertdata();
  }

  void foraddpersonaldata() {
    MyDataBase().ForGetDataBase().then((value) {
      setState(() {
        splashpage.db1 = value;

        print("=====${splashpage.db1}");
      });
    });
  }

  Future<void> forlogindata() async {
    // Obtain shared preferences.
    Duration(seconds: 5);
    splashpage.prefe = await SharedPreferences.getInstance();
    print("${status}********************************");

    setState(() {
      status = splashpage.prefe!.getBool("logininfo") ?? false;
      name = splashpage.prefe!.getString("getlname") ?? "Name";
      email = splashpage.prefe!.getString("getlemail") ?? "Email";

    });

    Future.delayed(Duration(seconds: 3)).then((value) {
      if (status) {
        setState(() {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {

              return homepage();
            },
          ));
        });
      } else {
        setState(() {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return signin();
            },
          ));
        });
      }
    });
  }

  void forinsertdata() {
    print("hello how are jfhdjf.....");
    setState(() {
      MyDataBase mm = MyDataBase();

      mm.ForGetDataBase().then((value) {
        signin.db = value;
      });
    });
  }
}
