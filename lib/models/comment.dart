import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagesio/models/reply.dart';

class Comment {
  final String id, content;
  final List<String>? likes;
  final List<Reply>? replies;
  final String userRef, postRef;

  Comment({
    required this.id,
    required this.content,
    required this.likes,
    required this.replies,
    required this.userRef,
    required this.postRef,
  });

  // factory Comment.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  // ) {
  //   final data = snapshot.data();
  //   return Comment(
  //     id: data?['id'],
  //     content: data?['content'],
  //     likes: data?['likes'],
  //     replies:
  //         data?['replies'] is Iterable ? List.from(data?['replies']) : null,
  //     userRef: data?['userRef'],
  //     postRef: data?['postRef'],
  //   );
  // }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      likes:
          json['likes'] is Iterable ? List<String>.from(json['likes']) : null,
      replies: null,
      userRef: json['userRef'].path,
      postRef: json['postRef'].path,
    );
  }
}
