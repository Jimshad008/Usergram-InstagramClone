
import 'package:cloud_firestore/cloud_firestore.dart';
CommentModel? commentModel;

class CommentModel {
  Timestamp commentDate;
  String uid;
  String cid;
  String comment;

  DocumentReference ?ref;
  CommentModel({

    required this.uid,

    required this.cid,


    required this.comment,
    required this.commentDate,

    this.ref,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(

      commentDate: json["commentDate"]??DateTime.now(),

      uid: json["uid"]??'',

      cid:json["cid"]??'',
      comment: json["comment"]??"",
      ref: json["ref"]
  );
  Map<String, dynamic> toJson() => {

    "commentDate": commentDate,
    "uid": uid,
    "cid":cid,
    "comment":comment,
    "ref":ref,
  };

  CommentModel copyWith({

    Timestamp? commentDate,

    String? uid,

    String?cid,
    String? comment,
    DocumentReference?ref,
  }) =>
      CommentModel(

          commentDate: commentDate ?? this.commentDate,
          uid: uid ?? this.uid,
          cid: cid??this.cid,
          comment: comment??this.comment,
          ref: ref??this.ref
      );

}









