import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task4/features/Auth/auth_controller.dart';
import 'package:task4/features/Home/screen/LoginList.dart';
import 'package:task4/models/StoryModel.dart';
import 'package:task4/models/UsersModel.dart';

import '../../../Core/Constant/ColorConstant/ColorConstant.dart';
import '../../../Core/Constant/FirebaseConstant/FireBaseConstants.dart';

class AddaStory extends StatefulWidget {
  const AddaStory({super.key});

  @override
  State<AddaStory> createState() => _AddaStoryState();
}

class _AddaStoryState extends State<AddaStory> {
  File? _pickedMedia;
String? _mediaUrl;

  AuthController obj =AuthController();
Future<void> _pickMedia(ImageSource media) async {
  final pickedFile = await ImagePicker().pickImage(source: media,imageQuality: 30);/*pickVideo(source: ImageSource.gallery);*/
  // For images, use pickImage(source: ImageSource.gallery)

  if (pickedFile != null) {
    setState(() {
      _pickedMedia = File(pickedFile.path);
    });
  }
}
Future<void> _uploadStoryToFirebase() async {
  try {
    if (_pickedMedia == null) {
      print("Please pick an image or video first.");
      return;
    }

    // Upload the media file to Firebase Storage
    final TaskSnapshot uploadTaskSnapshot = await FirebaseStorage.instance
        .ref('story/${DateTime.now().millisecondsSinceEpoch}.jpg') // For images, replace '.mp4' with the appropriate file extension like '.jpg'
        .putFile(_pickedMedia!);

    // Wait for the upload to complete and retrieve the download URL
    final String downloadURL = await uploadTaskSnapshot.ref.getDownloadURL();

    // Save the media details to Firestore
    var a=StoryModel(uid: FirebaseAuth.instance.currentUser!.uid, sid: "", image: downloadURL, storyDate: Timestamp.now(),name: usersModel!.name,profile: usersModel!.profile);
    final CollectionReference storyCollection = FirebaseFirestore.instance.collection(FireBaseConstant.userCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection(FireBaseConstant.storyCollection);
    await storyCollection.add(
      a.toJson(),
      // 'image': downloadURL,
      // 'postDate': FieldValue.serverTimestamp(),
      // 'description':description.text,
      // 'uid':FirebaseAuth.instance.currentUser!.uid
      // Add any other fields you want to store, like media title, description, etc.
    ).then((value) async{

      storyModel=await obj.getUserStory(FirebaseAuth.instance.currentUser!.uid,value.id);
      var b=storyModel!.copyWith(
          sid: value.id,
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
// @override
//   void initState() {
//     // TODO: implement initState
//     setState(() {
// _pickedMedia;
//     });
//   }
  @override
  Widget build(BuildContext context) {
    var w=MediaQuery.sizeOf(context).width;
    var h=MediaQuery.sizeOf(context).height;
    return _pickedMedia!=null? Scaffold(
      body: SizedBox(
        width: w,
        height: h,

        child: Column(
          children: [
            SizedBox(
              width: w,
              height: h*0.92,
              child: Image.file(
                //to show image, you type like this.
                File(_pickedMedia!.path),

                fit: BoxFit.fill,


              ),
            ),
            Container(
              width: w,
              height: h*0.08,
              color: ColorConstant().color,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add to Story",style: TextStyle(color:ColorConstant().secondary ),),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: InkWell(onTap: () {
                        _uploadStoryToFirebase();
                        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const Loginlist(),), (route) => false);
                      },
                        child: CircleAvatar(
                          backgroundColor: ColorConstant().secondary,
                          child: Icon(Icons.navigate_next_sharp,color: ColorConstant().color,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ):Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.infinity,
        color: ColorConstant().color,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SizedBox(
             width: 105,
             child: ElevatedButton(

               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.grey.shade800, // Background color
               ),

               onPressed: () async {
                 await _pickMedia(ImageSource.gallery);


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
               onPressed: () async {
                 // Get the image from the gallery or camera
                 await _pickMedia(ImageSource.camera);
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
    );

  }
}
