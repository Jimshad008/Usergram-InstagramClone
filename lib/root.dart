import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task4/features/Auth/auth_controller.dart';
import 'package:task4/features/Home/screen/LoginList.dart';
import 'package:task4/features/Login/screen/login.dart';

import 'models/UsersModel.dart';
bool dark = true;
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
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Loginlist(),), (route) => false);

    }
    else{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const login(),), (route) => false);
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
        decoration: const BoxDecoration(
         color: Colors.black
        ),
        child: const Center(
          child: Image(image: AssetImage("assets/images/logo.png"),width: 150,),
        ),
      ),
    );
  }
}
