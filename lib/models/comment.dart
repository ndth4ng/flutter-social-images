import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/reply.dart';

class Comment {
  final String id, content;
  final List<String>? likes;
  final List<Reply>? replies;
  final DocumentReference userRef, postRef;
  final int createdAt;

  Author? author;

  Comment({
    required this.id,
    required this.content,
    required this.likes,
    required this.userRef,
    required this.postRef,
    required this.createdAt,
    this.author,
    this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      createdAt: json['createdAt'],
      likes: [],
      replies: [],
      userRef: json['userRef'],
      postRef: json['postRef'],
    );
  }
}
