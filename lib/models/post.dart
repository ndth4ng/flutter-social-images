import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagesio/models/comment.dart';

class Post {
  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.userRef,
    required this.comments,
  });

  final String? id, title, description;
  final String imageUrl;
  final DocumentReference<Map<String, dynamic>> userRef;
  List<Comment> comments;

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
      comments:
          data?['comments'] is Iterable ? List.from(data?['comments']) : [],
      userRef: data?['userRef'],
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      comments: json['comments'] is Iterable ? List.from(json['comments']) : [],
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
