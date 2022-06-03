import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/comment.dart';
import 'package:imagesio/models/post.dart';

class PostService with ChangeNotifier {
  CollectionReference postsRef = FirebaseFirestore.instance.collection('posts');

  Future<Post?> getPost(String postId) async {
    try {
      final ref = postsRef.doc(postId).withConverter(
            fromFirestore: Post.fromFirestore,
            toFirestore: (Post post, _) => post.toFirestore(),
          );

      final docSnap = await ref.get();
      Post? post = docSnap.data();
      if (post != null) {
        List<Comment> listComments = await getPostComments(postId);
        // print('LIST COMMENTS: ${listComments.length}');
        return post;
      } else {
        print("No such document.");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Post>> getPosts() async {
    try {
      QuerySnapshot querySnapshot = await postsRef.get();

      List<Post> listPosts = querySnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // posts = listPosts;
      return listPosts;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Comment>> getPostComments(String postId) async {
    try {
      List<Comment> comments = [];

      QuerySnapshot result =
          await postsRef.doc(postId).collection('comments').get();

      for (var comment in result.docs) {
        Comment newComment =
            Comment.fromJson(comment.data() as Map<String, dynamic>);
        comments.add(newComment);
      }

      return comments;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<Author?> getPostAuthor(
      DocumentReference<Map<String, dynamic>> userRef) async {
    try {
      DocumentSnapshot result = await userRef.get();
      Author author = Author.fromJson(result.data() as Map<String, dynamic>);

      return author;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
