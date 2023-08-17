import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/features/Auth/auth_controller.dart';
import 'package:task4/features/Login/screen/login.dart';
bool setpassword=true;
bool confirmpassword=true;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username=TextEditingController();
  TextEditingController gmail=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController conpassword=TextEditingController();
final AuthController _auth=AuthController();


  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.brown.shade800, const Color.fromARGB(255, 170, 20, 20)],

              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:18.0),
                  child: Text("Register!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.09,color: Colors.white),),
                ),
                Form(

                  child: Container(
                    width: w*0.89,
                    height: h*0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w*0.05),
                        color: Colors.grey.withOpacity(0.9)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // GoogleSignIn

                       Container(
                        width: w*0.7,
                        height: w*0.12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(w*0.025)
                        ),
                        child: TextFormField(
                          controller: username,


                            cursorColor: Colors.black,
                            decoration: InputDecoration(border: InputBorder.none,
                            prefixIcon: const Icon(Icons.person),

                              // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                              hintText: "Username:",
                              hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: w*0.05,fontStyle: FontStyle.italic),

                            )

                        ),
                      ),
                        Container(
                          width: w*0.7,

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(w*0.025)
                          ),
                          child: TextFormField(
                              controller: gmail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if(!value!.contains("@")){
                               return "Invalid Gmail";
                              }
                              return null;
                            },
                                 autovalidateMode: AutovalidateMode.onUserInteraction,

                              decoration: InputDecoration(border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(left: 8,top: 12),
                                  prefixIcon: const Icon(Icons.mail),

                                // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                                hintText: "Gmail:",
                                hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: w*0.05,fontStyle: FontStyle.italic),

                              )

                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: w*0.7,

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(w*0.025)
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: password,
                                  validator: (value) {

                                      if(value!.length<8){

                                        return "password should be graterthan 7 digit";
                                      }
                                      return null;
                                  },
                                  obscureText: setpassword,

                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(border: InputBorder.none,
                                    prefixIcon: const Icon(CupertinoIcons.lock),
                                   contentPadding: const EdgeInsets.only(left: 8,top: 12),
                                   suffixIcon: InkWell(
                                     onTap: () {
                                       setState(() {



                                         setpassword = !setpassword;

                                       });
                                     },
                                       child: setpassword?const Icon(Icons.visibility):const Icon(Icons.visibility_off)),
                                    // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                                    hintText: "Set a Password",
                                    hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: w*0.05,fontStyle: FontStyle.italic),

                                  )

                              ),
                            ),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                width: w*0.7,
                              decoration: BoxDecoration(
                                color: Colors.white,

                                  borderRadius: BorderRadius.circular(w*0.025)
                              ),
                              child: TextFormField(

                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: conpassword,
                                  obscureText: confirmpassword,

                                  validator: (value) {
                                    if(value!=password.text){
                                      return "Passwords are not same";
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(border:InputBorder.none,
                                     contentPadding: const EdgeInsets.only(left: 8,top:12 ),


                                     fillColor: Colors.red,
                                     prefixIcon: const Icon(CupertinoIcons.lock),
                                    suffixIcon: InkWell(onTap: () {
                                      setState(() {



                                        confirmpassword=!confirmpassword;

                                      });

                                    },
                                        child:confirmpassword?const Icon(Icons.visibility):const Icon(Icons.visibility_off),),

                                    // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: w*0.05,fontStyle: FontStyle.italic),

                                  )

                              ),
                            ),

                          ],
                        ),
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: w*0.3,
                              height: w*0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(w*0.025),
                                  gradient: LinearGradient(
                                    colors: [Colors.brown.shade800, const Color.fromARGB(255, 170, 20, 20)],

                                  )
                              ),
                              child: Center(child: InkWell(onTap: () {
                                _auth.userRegister(gmail, password, username, context);
                                // FirebaseFirestore.instance.collection(collectionPath)
                              },
                                  child: const Text("Register",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already a Member?"),InkWell(onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const login(),));
                                },child: Text("Login",style: TextStyle(color: Colors.blue.shade900),))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

