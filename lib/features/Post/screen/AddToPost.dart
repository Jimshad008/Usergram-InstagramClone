


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'package:task4/Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import 'package:task4/features/Auth/auth_controller.dart';
import 'package:task4/features/Home/screen/LoginList.dart';
import 'package:task4/models/mediaModel.dart';

import '../../../Core/Constant/ColorConstant/ColorConstant.dart';



class AddToPost extends StatefulWidget {
  const AddToPost({super.key});

  @override
  State<AddToPost> createState() => _AddToPostState();
}

class _AddToPostState extends State<AddToPost> {
  AuthController obj=AuthController();
  TextEditingController description = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    description.dispose();
  }
  // Future<void> _uploadToFirestore(String imagePath, String downloadURL) async {
  //   try {
  //     // Get a reference to the Firestore collection where you want to store the image data
  //     final CollectionReference imageCollection = FirebaseFirestore.instance.collection('images');
  //
  //     // Create a document with a unique ID to store the image details
  //     final DocumentReference imageDocument = imageCollection.doc();
  //
  //     // Save the image details to Firestore
  //     await imageDocument.set({
  //       'image_url': downloadURL,
  //       'timestamp': FieldValue.serverTimestamp(),
  //       // Add any other fields you want to store, like image name, description, etc.
  //     });
  //
  //
  //     print("++++++++++++++++++++++++++++++++++++++++");// Show a message or perform any other actions after the upload is successful.
  //     print('Image uploaded to Firestore successfully.');
  //   } catch (e) {
  //     // Handle any exceptions that occur during image upload.
  //     print("++++++++++++++++++++++++++++++++++++++++");
  //     print('Error: $e');
  //   }
  // }

  // Future<String?> _uploadToFirebase(String imagePath) async {
  //   try {
  //     File imageFile = File(imagePath);
  //
  //     // Get the reference to the Firebase Storage location where you want to upload the image
  //     final Reference storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
  //
  //     // Upload the file to Firebase Storage
  //     final TaskSnapshot uploadTaskSnapshot = await storageRef.putFile(imageFile);
  //
  //     // Wait for the upload to complete and retrieve the download URL
  //     final String downloadURL = await uploadTaskSnapshot.ref.getDownloadURL();
  //
  //     // Show a message or perform any other actions after the upload is successful.
  //     print('Image uploaded to Firebase Storage successfully. Download URL: $downloadURL');
  //
  //     // Return the download URL
  //     return downloadURL;
  //   } catch (e) {
  //     // Handle any exceptions that occur during image upload.
  //     print('Error: $e');
  //     return null;
  //   }
  // }
 File? _pickedMedia;
 String? _mediaUrl;
  Future<void> _pickMedia(ImageSource media) async {
    final pickedFile = await ImagePicker().pickImage(source: media,imageQuality: 50);/*pickVideo(source: ImageSource.gallery);*/
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
         .putFile(_pickedMedia!);

     // Wait for the upload to complete and retrieve the download URL
     final String downloadURL = await uploadTaskSnapshot.ref.getDownloadURL();

     // Save the media details to Firestore
     var a=MediaModel(postDate:Timestamp.now(), image:downloadURL, description: description.text, uid: FirebaseAuth.instance.currentUser!.uid,likes: [], mid: '',);
     final CollectionReference mediaCollection = FirebaseFirestore.instance.collection(FireBaseConstant.mediaCollection);
     await mediaCollection.add(
       a.toJson(),
       // 'image': downloadURL,
       // 'postDate': FieldValue.serverTimestamp(),
       // 'description':description.text,
       // 'uid':FirebaseAuth.instance.currentUser!.uid
       // Add any other fields you want to store, like media title, description, etc.
     ).then((value) async{

       mediaModel=await obj.getUserMedia(value.id);
       var b=mediaModel!.copyWith(
         mid: value.id,
             ref: value
       );
       value.update(b.toJson());

     },);
    //  usersModel = (await obj.getUser(FirebaseAuth.instance.currentUser!.uid));
    // usersModel!.myPost.add(downloadURL);
    //  var updateData = usersModel!.copyWith(myPost:usersModel!.myPost );
    //  FirebaseFirestore.instance
    //      .collection(FireBaseConstant.userCollection)
    //      .doc(FirebaseAuth.instance.currentUser!.uid)
    //      .update(
    //    updateData.toJson(),
    //  );

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
                          backgroundColor: Colors.grey.shade800, // Background color
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
                          print("+++++++++++++++++++++++++++++++++");
                          print(_pickedMedia!.path);
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



  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorConstant().secondary),
        backgroundColor: ColorConstant().color,
      ),
            body:
      Container(
        decoration: BoxDecoration(
          color: ColorConstant().color,
        ),
        child: Center(
          child: Column(


              children:[
                const SizedBox(
                  height: 10,
                ),
                _pickedMedia != null
                    ? Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(border: Border.all(color: ColorConstant().secondary,width: 2)),
                      child: Image.file(
                        //to show image, you type like this.
                           File(_pickedMedia!.path),

                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: 300,

                      ),
                    ),

                  ),

                )
                    : Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(border: Border.all(color:ColorConstant().secondary,width: 2)),
                      child: Center(
                        child: InkWell(
                            onTap: () {
                              myAlert();

                            },


                              child: Container(


                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(80),border: Border.all(color: ColorConstant().secondary,width: 2)),



                                child: Icon(Icons.add,color:ColorConstant().secondary,size: 40,),
                              ),
                        ),
                            )),


                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: w*0.9,
                  decoration: BoxDecoration(
                    border:Border.all(color:ColorConstant().secondary,width: 2)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextFormField(
                      cursorColor: ColorConstant().secondary,
                      style: TextStyle(color: ColorConstant().secondary),

                      controller: description,
                      decoration: InputDecoration(border: InputBorder.none,
                        hintText: "description..",
                         hintStyle: TextStyle(color: ColorConstant().secondary,fontSize: w*0.04,fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height:w*0.05 ,
                ),
                InkWell(onTap: () {
                  _uploadMediaToFirebase();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Loginlist(),), (route) => false);
                },
                  child: Container(
                    width: w*0.3,
                    height: w*0.1,
                    decoration:   BoxDecoration(
                      color: ColorConstant().secondary,
                      borderRadius: BorderRadius.circular(w*0.015)
                    ),

                    child: Center(
                      child: Text("Add to Post",style: TextStyle(color: ColorConstant().color,fontWeight: FontWeight.bold),),
                    ),
                  ),
                )
           ] ),
          ),
      ),

    );
  }
}
