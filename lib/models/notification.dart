import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/post.dart';

class NotificationType {
  final String id, state;
  final int createdAt;
  final bool isSeen;
  final DocumentReference? postRef;
  final DocumentReference userSendRef, userReceiveRef;

  Author? userSend;
  Author? userReceive;
  Post? post;

  NotificationType({
    required this.id,
    required this.state,
    required this.userSendRef,
    required this.userReceiveRef,
    required this.createdAt,
    required this.isSeen,
    this.postRef,
    this.userSend,
    this.userReceive,
    this.post,
  });

  factory NotificationType.fromJson(Map<String, dynamic> json) {
    return NotificationType(
      id: json['id'],
      state: json['state'],
      userSendRef: json['userSendRef'],
      userReceiveRef: json['userReceiveRef'],
      createdAt: json['createdAt'],
      isSeen: json['isSeen'],
      postRef: json['postRef'],
    );
  }
}
