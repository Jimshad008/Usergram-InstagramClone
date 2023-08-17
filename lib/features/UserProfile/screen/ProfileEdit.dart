

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task4/features/Auth/auth_controller.dart';
import 'package:task4/features/Home/screen/LoginList.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import '../../../models/UsersModel.dart';

import '../../../Core/Constant/ColorConstant/ColorConstant.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});




  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  File? _pickedMedia;
  String? _mediaUrl;

  Future<void> _pickMedia(ImageSource media) async {
    XFile?  pickedFile = await ImagePicker().pickImage(source: media,imageQuality: 30);/*pickVideo(source: ImageSource.gallery);*/
    // For images, use pickImage(source: ImageSource.gallery)

    if (pickedFile != null) {
      setState(() {
        _pickedMedia = File(pickedFile.path);
      });
    }
  }
  Future<void> _uploadMediaToFirebase() async {
    try {
      if (_pickedMedia == null) {
        print("Please pick an image or video first.");
        return;
      }

      // Upload the media file to Firebase Storage
      final TaskSnapshot uploadTaskSnapshot = await FirebaseStorage.instance
          .ref('media/${DateTime.now().millisecondsSinceEpoch}.jpg') // For images, replace '.mp4' with the appropriate file extension like '.jpg'
          .putFile(_pickedMedia as File);

      // Wait for the upload to complete and retrieve the download URL
      final String downloadURL = await uploadTaskSnapshot.ref.getDownloadURL();

      // Save the media details to Firestore
      // final CollectionReference mediaCollection = FirebaseFirestore.instance.collection('media');
      // await mediaCollection.add({
      //   'url': downloadURL,
      //   'timestamp': FieldValue.serverTimestamp(),
      //   // Add any other fields you want to store, like media title, description, etc.
      // });
      usersModel = (await obj.getUser(FirebaseAuth.instance.currentUser!.uid));
      var updateData = usersModel!.copyWith(profile: downloadURL);
      print("++++++++++++++++++++++++++++++++");
      print("++++++++++++++++$downloadURL+++++");
      FirebaseFirestore.instance
          .collection(FireBaseConstant.userCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        updateData.toJson(),
      );

      // Update the state with the media URL for display or further use.
      setState(() {
        _mediaUrl = downloadURL;
      });

      print('Media uploaded to Firebase Storage and Firestore successfully. Download URL: $_mediaUrl');
    } catch (e) {
      // Handle any exceptions that occur during media upload.
      print('Error: $e');
    }
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: ColorConstant().ternary,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

            content: SizedBox(
              height: MediaQuery.of(context).size.height / 7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: 105,
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800
                          // Background color
                        ),

                        onPressed: () {
                          _pickMedia(ImageSource.gallery);
                          Navigator.pop(context);

                        },
                        child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Icon(Icons.image_rounded),
                            Text('Gallery'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 105,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800, // Background color
                        ),
                        //if user click this button. user can upload image from camera
                        onPressed: () {
                          // Get the image from the gallery or camera
                          _pickMedia(ImageSource.camera);
                          Navigator.pop(context);
                          // getImage(ImageSource.camera);
                          // String downloadURL = await _uploadToFirebase(selectedImage?.path);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.camera_alt_rounded),
                            Text('Camera'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  var userUid=FirebaseAuth.instance.currentUser!.uid;
  TextEditingController gmail = TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  final formKey=GlobalKey<FormState>();
  AuthController obj =AuthController();
  getusermodel() async {
    usersModel = (await obj.getUser(FirebaseAuth.instance.currentUser!.uid));
  }
  @override
  void initState() {
    // TODO: implement initState
    getusermodel();
  }

  @override
  Widget build(BuildContext context) {

    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;

    return Scaffold(

      backgroundColor: ColorConstant().color,

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConstant().secondary),
        backgroundColor: ColorConstant().color,
        title:Text( "Profile Edit",style: TextStyle(color: ColorConstant().secondary),),
      ),
      body: Container(
        decoration: BoxDecoration(
        color: ColorConstant().color
        ),
        child: Stack(
          children: [Center(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Container(
                width: w*0.9,
                height: h*0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstant().secondary,width: 2),
                      borderRadius: BorderRadius.circular(w*0.05)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 68.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [ Container(
                      width: w*0.7,


                      decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant().secondary),
                          borderRadius: BorderRadius.circular(w*0.025)
                      ),
                      child:
                      TextFormField(
                        style: TextStyle(color: ColorConstant().secondary),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(value==null){
                            return "enter a name";

                          }
                          return null;
                        },
                          controller: username,


                          cursorColor: ColorConstant().secondary,
                          decoration: InputDecoration(border: InputBorder.none,
                            prefixIcon: Icon(Icons.person,color: ColorConstant().secondary,),

                            // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                            hintText: usersModel!.name,
                            hintStyle: TextStyle(color: ColorConstant().secondary,fontSize: w*0.04,fontStyle: FontStyle.italic),

                          )

                      ),

                    ),
                      Container(
                        width: w*0.7,


                        decoration: BoxDecoration(
                            border: Border.all(color: ColorConstant().secondary),
                            borderRadius: BorderRadius.circular(w*0.025)
                        ),
                        child: TextFormField(

                            style: TextStyle(color: ColorConstant().secondary),
                            cursorColor: ColorConstant().secondary,
                            controller: gmail,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator:(value) {
                              if(!value!.contains("@"))
                              {
                                return "Invalid Email";

                              }
                              else if(value==null){
                                return"enter a email";

                              }
                              return null;
                            },



                            decoration: InputDecoration(border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(left: 8,top: 12),

                              prefixIcon: Icon(Icons.mail,color: ColorConstant().secondary,),
                              // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                              hintText: usersModel!.email,
                              hintStyle: TextStyle(color: ColorConstant().secondary,fontSize: w*0.04,fontStyle: FontStyle.italic),

                            )

                        ),
                      ),Container(
                        width: w*0.7,


                        decoration: BoxDecoration(
                            border: Border.all(color: ColorConstant().secondary),
                            borderRadius: BorderRadius.circular(w*0.025)
                        ),
                        child:
                        TextFormField(
                            style: TextStyle(color: ColorConstant().secondary),

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(value !is int){
                              return "Invalid Phone number";
                            }
                            return null;
                          },
                            controller: phoneNo,
                               keyboardType: TextInputType.number,

                            cursorColor: Colors.white,
                            decoration: InputDecoration(border: InputBorder.none,
                              prefixIcon: Icon(Icons.phone,color: ColorConstant().secondary,),

                              // border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.zero),borderSide: BorderSide(color: Colors.white)),

                              hintText: usersModel!.phoneNumber,
                              hintStyle: TextStyle(color: ColorConstant().secondary,fontSize: w*0.04,fontStyle: FontStyle.italic),

                            )

                        ),

                      ),
                      InkWell(
                        onTap: () async {
                          final val=formKey.currentState!.validate();
                          if(val) {
                            usersModel=(await obj.getUser(FirebaseAuth.instance.currentUser!.uid));
                          var updateData=usersModel!.copyWith(email: gmail.text,name: username.text,phoneNumber: phoneNo.text);
                         usersModel!.ref!.update(
                          updateData.toJson());
                          _uploadMediaToFirebase();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Loginlist(),), (route) => false);

                          }},
                        child: Container(
                          width: w*0.25,
                          height: w*0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w*0.01)
                                ,color: ColorConstant().secondary

                          ),
                          child: Center(
                            child: Text("Save",style: TextStyle(
                              fontWeight: FontWeight.bold,color:ColorConstant().color,fontSize: w*0.045
                            ),),
                          ),
                        ),
                      )
                  ],
                  ),
                ),
              ),
            ),

          ),
            Positioned(
              left: w*0.35,
              top: w*0.130,
              child: InkWell(
                onTap: ()async{
                  myAlert();



                    // Wait for the upload to complete and retrieve the download URL


                },
                child: CircleAvatar(

                  radius: w*0.158,
                  backgroundColor: ColorConstant().secondary,
                  child:_pickedMedia != null? CircleAvatar(
                    backgroundImage:FileImage(_pickedMedia!),

                        // :
                    radius: w*0.15,
                  ):CircleAvatar(
                    backgroundImage:NetworkImage(usersModel!.profile),

                    // :
                    radius: w*0.15,
                  )
                ),
              ),
            )
        ]),
      ),
    );
  }
}
