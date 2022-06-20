import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/category.dart';
import 'package:imagesio/models/comment.dart';
import 'package:imagesio/models/post.dart';

class PostService with ChangeNotifier {
  CollectionReference postsRef = FirebaseFirestore.instance.collection('posts');

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future<List<Post>> getPosts(String category) async {
    try {
      QuerySnapshot querySnapshot = category == ''
          ? await postsRef.limit(10).get()
          : await postsRef
              .where('keywords',
                  arrayContains: category.toString().toLowerCase())
              .get();

      List<Post> listPosts = querySnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return listPosts;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Category>> getCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('keywords').get();

    return querySnapshot.docs
        .map((DocumentSnapshot categorySnapshot) =>
            Category.fromJson(categorySnapshot.data() as Map<String, dynamic>))
        .toList();
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

  void commentPost(String content, String postId, String userId) {
    // create comment Id
    String commentId = firestore.collection('posts').doc().id;

    Comment comment = Comment(
        id: commentId,
        content: content,
        likes: [],
        userRef: firestore.collection('users').doc(userId),
        postRef: firestore.collection('posts').doc(postId),
        createdAt: DateTime.now().millisecondsSinceEpoch);

    firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .set(comment.toFirestore());
    print(comment);
  }
}
