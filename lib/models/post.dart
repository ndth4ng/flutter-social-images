import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/comment.dart';

class Post {
  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.imageId,
    required this.userRef,
    this.keywords,
    required this.createdAt,
    this.comments,
    this.likes,
    this.author,
  });

  final String id, title, description, imageUrl;
  String? imageId;
  int createdAt;
  final DocumentReference userRef;
  final List<String>? keywords;

  List<Comment>? comments;
  List<DocumentReference>? likes;

  Author? author;

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Post(
      id: data?['id'],
      title: data?['title'],
      description: data?['description'],
      imageUrl: data?['imageUrl'],
      imageId: data?['imageId'],
      createdAt: data?['createdAt'],
      likes: data?['likes'] is Iterable ? List.from(data?['likes']) : [],
      keywords:
          data?['keywords'] is Iterable ? List.from(data?['keywords']) : [],
      comments:
          data?['comments'] is Iterable ? List.from(data?['comments']) : [],
      userRef: data?['userRef'],
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'],
      imageId: json['imageId'] ?? '',
      createdAt: json['createdAt'],
      likes: json['likes'] is Iterable ? List.from(json['likes']) : [],
      keywords: json['keywords'] is Iterable ? List.from(json['keywords']) : [],
      // comments: json['comments'] is Iterable ? List.from(json['comments']) : [],
      userRef: json['userRef'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (imageUrl != null) "imageUrl": imageUrl,
      if (comments != null) "comments": comments,
      if (userRef != null) "userRef": userRef,
    };
  }
}
