
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
MediaModel? mediaModel;

class MediaModel {
  Timestamp postDate;
  String image;
  String description;
  List likes;
  String mid;
  List comment;
  String uid;
  DocumentReference ?ref;
  MediaModel({

    required this.postDate,

    required this.image,

    required this.description,
    required this.comment,
    required this.uid,
    required this.likes,
    required this.mid,
 this.ref,
  });
  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(

    postDate: json["postDate"]??DateTime.now(),
    image: json["image"]??'',
  description: json["description"]??'',
    uid: json["uid"]??'',
    likes: json["likes"]??[],
    mid:json["mid"]??'',
    comment: json["comment"]??[],
    ref: json["ref"]
  );
  Map<String, dynamic> toJson() => {

    "postDate": postDate,
    "image": image,
    "description": description,
    "uid": uid,
    "likes":likes,
    "mid":mid,
    "comment":comment,
    "ref":ref,
  };

MediaModel copyWith({

    Timestamp? postDate,
    String? image,
    String? description,
    String? uid,
  List? likes,
  String?mid,
  List? comment,
  DocumentReference?ref,
  }) =>
      MediaModel(

        postDate: postDate ?? this.postDate,
        image: image ?? this.image,
        description: description ?? this.description,
        uid: uid ?? this.uid,
        likes: likes??this.likes,
          mid: mid??this.mid,
          comment: comment??this.comment,
          ref: ref??this.ref
      );

}









