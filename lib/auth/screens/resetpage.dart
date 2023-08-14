import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  TextEditingController gmail=TextEditingController();
  resetpass(email){
    FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
          gradient: LinearGradient(
          colors: [Colors.brown.shade800, Color.fromARGB(255, 170, 20, 20)],

      )
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

            width: w*0.7,


            decoration: BoxDecoration(
                color: Colors.white,
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

                  prefixIcon: Icon(Icons.mail),
                  // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                  hintText: "Gmail:",
                  hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: w*0.05,fontStyle: FontStyle.italic),

                )

            ),),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              resetpass(gmail);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(),));
            },
            child: Container(
              width: w*0.3,
              height: w*0.12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w*0.025),
                  gradient: LinearGradient(
                    colors: [Colors.brown.shade800, Color.fromARGB(255, 170, 20, 20)],

                  )
              ),
              child: Center(child: Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: w*0.05),)),
            ),
          ),
        ],
      )
      ),
    );

  }
}
