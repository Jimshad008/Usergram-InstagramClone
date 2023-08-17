
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/Core/Constant/AssetConstant/AssetConstant.dart';

import 'package:task4/features/Login/screen/Register.dart';

import 'package:task4/features/Login/screen/resetpage.dart';
import '../../../Core/Constant/ColorConstant/ColorConstant.dart';

import '../../Auth/auth_controller.dart';
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
    backgroundColor: ColorConstant().secondary,
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

  final AuthController _auth= AuthController();








  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
         color: ColorConstant().color
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:18.0),
                child: Text("Welcome!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.09,color: ColorConstant().secondary),),
              ),
              Container(
                width: w*0.80,
                height: h*0.45,
                decoration: BoxDecoration(
                  color: Colors.grey[100],

                  borderRadius: BorderRadius.circular(w*0.05),
                   boxShadow: [
                     BoxShadow(
                       color: ColorConstant().color,
                       blurRadius: 20.0, // soften the shadow
                       spreadRadius: 1.0, //extend the shadow
                       offset: const Offset(
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
                            border: Border.all(color: ColorConstant().color),
                            borderRadius: BorderRadius.circular(w*0.025)
                        ),
                        child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image: AssetImage(AssetConstant.googlelogo)),
                            Text("Login with  Google",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),

                      ),
                    ),
                    const Text("Or"),
                    Container(
                      width: w*0.7,


                      decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant().color),
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
                                contentPadding: const EdgeInsets.only(left: 8,top: 12),

                                prefixIcon: Icon(Icons.mail,color: ColorConstant().color,),
                            // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                            hintText: "Gmail:",
                            hintStyle: TextStyle(color: ColorConstant().color,fontSize: w*0.05,fontStyle: FontStyle.italic),

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
                             border: Border.all(color: ColorConstant().color),
                              borderRadius: BorderRadius.circular(w*0.025)
                          ),
                          child: TextFormField(
                            controller: password,
                            obscureText: p,

                              cursorColor: Colors.black,
                              decoration: InputDecoration(border: InputBorder.none,

                               prefixIcon: Icon(CupertinoIcons.lock,color: ColorConstant().color,),
                                suffixIcon: InkWell(onTap: () {setState(() {
                                  p=!p;
                                });

                                },
                                    child: p?Icon(Icons.visibility,color: ColorConstant().color,):Icon(Icons.visibility_off,color: ColorConstant().color,)),
                                // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                                hintText: "Password:",
                                hintStyle: TextStyle(color: ColorConstant().color,fontSize: w*0.05,fontStyle: FontStyle.italic),

                              )

                          ),
                        ),
                        InkWell(onTap:() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Reset(),));
                        },
                            child: Text("Forgot Password?",style: TextStyle(fontStyle: FontStyle.italic,color:ColorConstant().color),))
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
                              boxShadow: const [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  1.0, // Move to right 5  horizontally
                                  1.0, // Move to bottom 5 Vertically
                                ),
                              )],
                             color: ColorConstant().color
                            ),
                            child: Center(child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: ColorConstant().secondary,fontSize: w*0.05),)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have a Account?"),InkWell(onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Register(),));
                            },child: Text("Register",style: TextStyle(color: ColorConstant().color),))
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
