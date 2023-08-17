
import 'package:cloud_firestore/cloud_firestore.dart';
StoryModel? storyModel;

class StoryModel {
  Timestamp storyDate;
  String uid;
  String sid;
  String image;
  String name;
  String profile;

  DocumentReference ?ref;
  StoryModel({
     required this.profile,
    required this.uid,
required this.name,
    required this.sid,


    required this.image,
    required this.storyDate,

    this.ref,
  });
  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(

      storyDate: json["storyDate"]??Timestamp.now(),
      name: json["name"]??"",
      profile: json["profile"]??"",
      uid: json["uid"]??'',

      sid:json["sid"]??'',
      image: json["image"]??"",
      ref: json["ref"]
  );
  Map<String, dynamic> toJson() => {
    "profile":profile,
        "name":name,
    "storyDate": storyDate,
    "uid": uid,
    "sid":sid,
    "image":image,
    "ref":ref,
  };

  StoryModel copyWith({
    String? profile,
    String? name,
    Timestamp? storyDate,

    String? uid,

    String?sid,
    String? image,
    DocumentReference?ref,
  }) =>
      StoryModel(
          profile: profile??this.profile,
          storyDate: storyDate ?? this.storyDate,
          uid: uid ?? this.uid,
          sid: sid??this.sid,
          image: image??this.image,
          ref: ref??this.ref,
          name: name??this.name,
      );

}









