import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task4/Core/Constant/FirebaseConstant/FireBaseConstants.dart';
import 'package:task4/features/Home/screen/LoginList.dart';
import 'package:task4/models/CommentModel.dart';
import 'package:task4/models/UsersModel.dart';
import 'package:task4/models/mediaModel.dart';

import '../../models/StoryModel.dart';
import '../Login/screen/login.dart';

var currentUserid;
var loginId;

class AuthController {
  Future<UsersModel?> getUser(String a) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(FireBaseConstant.userCollection)
        .doc(a)
        .get();
    if (snapshot.exists) {
      final data = UsersModel.fromJson(snapshot.data()!);
      return data;
    }
    return null;
  }
  Future<CommentModel?> getUserComment(String a,String b) async {
    var snapshot = await FirebaseFirestore.instance.collection(FireBaseConstant.mediaCollection).doc(a)
        .collection(FireBaseConstant.commentCollection)
        .doc(b)
        .get();
    if (snapshot.exists) {
      final data = CommentModel.fromJson(snapshot.data()!);
      return data;
    }
    return null;
  }
  Future<StoryModel?> getUserStory(String a,String b) async {
    var snapshot = await FirebaseFirestore.instance.collection(FireBaseConstant.userCollection).doc(a)
        .collection(FireBaseConstant.storyCollection)
        .doc(b)
        .get();
    if (snapshot.exists) {
      final data = StoryModel.fromJson(snapshot.data()!);
      return data;
    }
    return null;
  }
  Future<MediaModel?> getUserMedia(String a) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(FireBaseConstant.mediaCollection)
        .doc(a)
        .get();
    if (snapshot.exists) {
      final data = MediaModel.fromJson(snapshot.data()!);
      return data;
    }
    return null;
  }

  ///Signin with Google
  signInWithGoogle(BuildContext context) async {
    try {

      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        // final currentUserUid=FirebaseAuth.instance.currentUser!.uid;
        currentUserid = FirebaseAuth.instance.currentUser!.uid;
        if (value.additionalUserInfo!.isNewUser) {
          var newUser = UsersModel(
              createdDate: Timestamp.now(),
              loginDate: Timestamp.now(),
              name: googleUser!.displayName.toString(),
              profile: googleUser.photoUrl.toString(),
              email: googleUser.email.toString(),
              phoneNumber: "",
              followers: [],
              following: [],
              uid: currentUserid,saved: [],

          // myPost: [],
          );
          FirebaseFirestore.instance
              .collection(FireBaseConstant.userCollection)
              .doc(value.user!.uid)
              .set(newUser.toJson()).then((value) async {
                var a=await FirebaseFirestore.instance.collection(FireBaseConstant.userCollection).doc(currentUserid).get();
                usersModel = (await getUser(FirebaseAuth.instance.currentUser!.uid));
                var updateData = usersModel!.copyWith(ref:a.reference);
                FirebaseFirestore.instance
                    .collection(FireBaseConstant.userCollection)
                    .doc(currentUserid)
                    .update(
                  updateData.toJson(),
                );
          });
          loginId=FirebaseAuth.instance.currentUser!.uid;
        } else {

          usersModel = (await getUser(FirebaseAuth.instance.currentUser!.uid));
          final SharedPreferences local=await SharedPreferences.getInstance();
          local.setString("id", FirebaseAuth.instance.currentUser!.uid);
          var updateData = usersModel!.copyWith(loginDate: Timestamp.now());
          usersModel!.ref
              !.update(
                updateData.toJson(),
              );
        }
        // if(FirebaseFirestore.instance.collection('user').where(email==googleUser.email))

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Loginlist(),
            ));
      });
    } catch (e) {
      showErr(context, e.toString());
    }
  }

  ///logout
  signOut(BuildContext context)  async {
    final SharedPreferences local=await SharedPreferences.getInstance();
    local.remove("id");
    GoogleSignIn().signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const login(),
          ),
          (route) => false);
    });
  }

  ///UserLogin
  userLogin(email, password, BuildContext context) async {
    UserCredential? user;

    try {
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
            return null;
          });
    } catch (e) {
      showErr(context, e.toString());
    }
  }

  ///UserSignup
  userRegister(gmail, pass, username, BuildContext context) {
    final auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(email: gmail.text, password: pass.text)
        .then((value) {
      FirebaseFirestore.instance.collection('user').doc(value.user!.uid).set({
        "email": gmail.text,
        "password": pass.text,
        "username": username.text,
        "date": FieldValue.serverTimestamp()
      });
      Navigator.pop(context);
    });
  }
}
