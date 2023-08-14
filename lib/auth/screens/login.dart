
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/Homepage.dart';
import 'package:task4/auth/screens/Register.dart';
import 'package:task4/main.dart';
import 'package:task4/auth/screens/resetpage.dart';

import '../../Constant/FireBaseConstants.dart';
import '../controller/auth_controller.dart';
// SHA1: 31:61:4A:E9:4E:E1:84:6D:F9:92:D7:6D:CA:2A:1C:BD:29:1C:64:46
// SHA-256: 5F:51:A7:9E:26:AF:38:DC:37:D7:9E:64:43:18:B9:EF:BB:B6:30:01:0D:FD:CD:8C:02:AA:36:A3:A7:13:17:AA


// showErr(BuildContext context,String message){
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       backgroundColor: Theme.of(context).errorColor,
//     ),
//   );
showErr(BuildContext context,String msg){
  final snackBar=SnackBar(content: Text(msg),
    backgroundColor: Constant().secondary,
    action: SnackBarAction(label: "OK", onPressed:(){}),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
 bool p=true;

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController gmail = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthController _auth= AuthController();








  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
         color: Constant().color
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:18.0),
                child: Text("Welcome!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.09,color: Constant().secondary),),
              ),
              Container(
                width: w*0.80,
                height: h*0.45,
                decoration: BoxDecoration(
                  color: Colors.grey[100],

                  borderRadius: BorderRadius.circular(w*0.05),
                   boxShadow: [
                     BoxShadow(
                       color: Constant().color,
                       blurRadius: 20.0, // soften the shadow
                       spreadRadius: 1.0, //extend the shadow
                       offset: Offset(
                         5.0, // Move to right 5  horizontally
                         5.0, // Move to bottom 5 Vertically
                       ),
                     )
                   ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(onTap: () {
                      _auth.signInWithGoogle(context);
                    },
                      child: Container(
                        width: w*0.5,
                        height: w*0.09,
                        decoration: BoxDecoration(
                            border: Border.all(color: Constant().color),
                            borderRadius: BorderRadius.circular(w*0.025)
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage("assets/images/google.png")),
                            Text("Login with  Google",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),

                      ),
                    ),
                    Text("Or"),
                    Container(
                      width: w*0.7,


                      decoration: BoxDecoration(
                          border: Border.all(color: Constant().color),
                          borderRadius: BorderRadius.circular(w*0.025)
                      ),
                      child: TextFormField(
                        controller: gmail,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator:(value) {
                         if(!value!.contains("@"))
                         {
                           return "Invalid Email";

                         }
                         return null;
                        },


                          cursorColor: Colors.black,
                          decoration: InputDecoration(border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 8,top: 12),

                                prefixIcon: Icon(Icons.mail,color: Constant().color,),
                            // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                            hintText: "Gmail:",
                            hintStyle: TextStyle(color: Constant().color,fontSize: w*0.05,fontStyle: FontStyle.italic),

                          )

                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: w*0.7,
                          height: w*0.12,
                          decoration: BoxDecoration(
                             border: Border.all(color: Constant().color),
                              borderRadius: BorderRadius.circular(w*0.025)
                          ),
                          child: TextFormField(
                            controller: password,
                            obscureText: p,

                              cursorColor: Colors.black,
                              decoration: InputDecoration(border: InputBorder.none,

                               prefixIcon: Icon(CupertinoIcons.lock,color: Constant().color,),
                                suffixIcon: InkWell(onTap: () {setState(() {
                                  p=!p;
                                });

                                },
                                    child: p?Icon(Icons.visibility,color: Constant().color,):Icon(Icons.visibility_off,color: Constant().color,)),
                                // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                                hintText: "Password:",
                                hintStyle: TextStyle(color: Constant().color,fontSize: w*0.05,fontStyle: FontStyle.italic),

                              )

                          ),
                        ),
                        InkWell(onTap:() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Reset(),));
                        },
                            child: Text("Forgot Password?",style: TextStyle(fontStyle: FontStyle.italic,color:Constant().color),))
                      ],
                    ),
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _auth.userLogin(gmail, password, context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(),));
                          },
                          child: Container(
                            width: w*0.3,
                            height: w*0.12,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(w*0.025),
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  1.0, // Move to right 5  horizontally
                                  1.0, // Move to bottom 5 Vertically
                                ),
                              )],
                             color: Constant().color
                            ),
                            child: Center(child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Constant().secondary,fontSize: w*0.05),)),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have a Account?"),InkWell(onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                            },child: Text("Register",style: TextStyle(color: Constant().color),))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
