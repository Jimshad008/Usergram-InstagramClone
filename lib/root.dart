import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task4/auth/controller/auth_controller.dart';
import 'package:task4/auth/screens/AddToPost.dart';
import 'package:task4/auth/screens/LoginList.dart';
import 'package:task4/auth/screens/login.dart';

import 'models/UsersModel.dart';
bool dark = false;
class Rootpage extends StatefulWidget {
  const Rootpage({super.key});

  @override
  State<Rootpage> createState() => _RootpageState();
}

class _RootpageState extends State<Rootpage> {
  getLocalStatus() async {
    final SharedPreferences local=await SharedPreferences.getInstance();
    if(local.containsKey('id')) {
      loginId = local.getString("id");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginlist(),), (route) => false);

    }
    else{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => login(),), (route) => false);
    }
  }
  AuthController obj=AuthController();
  getusermodel() async {
    usersModel = (await obj.getUser(FirebaseAuth.instance.currentUser!.uid));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds:5),(){
      getLocalStatus();

    });
    getusermodel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
         color: Colors.black
        ),
        child: Center(
          child: Image(image: AssetImage("assets/images/logo.png"),width: 150,),
        ),
      ),
    );
  }
}
