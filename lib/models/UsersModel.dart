
import 'package:cloud_firestore/cloud_firestore.dart';
UsersModel? usersModel;
UsersModel? usersModel2;

class UsersModel {
  Timestamp createdDate;
  Timestamp loginDate;
  String name;
  String profile;
  String email;
  String phoneNumber;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic>saved;
  DocumentReference? ref;
  // List<dynamic> myPost;
  String uid;
  UsersModel({
    this.ref,
    required this.createdDate,
    required this.loginDate,
    required this.name,
    required this.profile,
    required this.email,
    required this.phoneNumber,
    required this.followers,
    required this.following,
    required this.uid,
    required this.saved
    // required this.myPost

  });
  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    createdDate: json["createdDate"]??'',
    loginDate: json["loginDate"]??'',
    name: json["name"]??'',
    profile: json["profile"]??'',
    email: json["email"]??'',
    phoneNumber: json["phoneNumber"]??'',
    followers: List<dynamic>.from(json["followers"].map((x) => x)),
    following: List<dynamic>.from(json["following"].map((x) => x)),
    uid: json["uid"]??'',
    saved: List<dynamic>.from(json["saved"].map((x) => x)),
    ref: json["ref"]
    // myPost: List<dynamic>.from(json["myPost"].map((x) => x)),
  );
  Map<String, dynamic> toJson() => {
    "createdDate": createdDate,
    "loginDate": loginDate,
    "name": name,
    "profile": profile,
    "email": email,
    "phoneNumber": phoneNumber,
    "followers": List<dynamic>.from(followers.map((x) => x)),
    "following": List<dynamic>.from(following.map((x) => x)),
    "uid": uid,
    "saved":saved,
    "ref":ref,

    // "myPost":List<dynamic>.from(myPost.map((x) => x)),
  };

  UsersModel copyWith({
    Timestamp? createdDate,
   Timestamp? loginDate,
    String? name,
    String? profile,
    String? email,
    String? phoneNumber,
    List<dynamic>? followers,
    List<dynamic>? following,
    String? uid,
    List<dynamic>? saved,
    DocumentReference? ref,
    // List<dynamic>? myPost,

  }) =>
      UsersModel(
        createdDate: createdDate ?? this.createdDate,
        loginDate: loginDate ?? this.loginDate,
        name: name ?? this.name,
        profile: profile ?? this.profile,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        uid: uid ?? this.uid,
        saved: saved??this.saved,
        ref: ref??this.ref,
        // myPost: myPost??this.myPost,
      );

}









