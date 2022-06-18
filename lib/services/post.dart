import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/comment.dart';
import 'package:imagesio/models/post.dart';

class PostService with ChangeNotifier {
  CollectionReference postsRef = FirebaseFirestore.instance.collection('posts');

  Future<Post?> getPost(String postId) async {
    try {
      DocumentSnapshot docSnapshot = await postsRef.doc(postId).get();

      Post post = docSnapshot.data() as Post;

      // print(docSnapshot.data().toString());

      // List<Comment> listComments = await getPostComments(postId);
      return post;
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

  Future<Author?> getPostAuthor(DocumentReference userRef) async {
    try {
      DocumentSnapshot result = await userRef.get();
      Author author = Author.fromJson(result.data() as Map<String, dynamic>);

      return author;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void likePost(Post post, String uid) async {
    List<DocumentReference> postLikes = post.likes ?? [];

    //Create userRef
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(uid);

    // Check if user is already liked this post
    bool isLiked = postLikes
        .map((DocumentReference userRef) => userRef.id)
        .toList()
        .contains(uid);

    if (isLiked) {
      final index = postLikes.indexWhere((userRef) => userRef.id == uid);
      postLikes.removeAt(index);
    } else {
      postLikes.add(userRef);
    }

    FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .update({'likes': postLikes});
  }
}
