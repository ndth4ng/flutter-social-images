import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/post.dart';
import 'package:imagesio/services/post.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  void handleTap(DocumentReference<Map<String, dynamic>> userRef) async {
    Author? author = await PostService().getPostAuthor(userRef);

    Navigator.pushNamed(
      context,
      '/post',
      arguments: {
        'postId': widget.post.id,
        'author': author,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            handleTap(widget.post.userRef);
          },
          child: Card(
            elevation: 5,
            semanticContainer: true,
            key: ValueKey(widget.post.id),
            child: Image.network(
              widget.post.imageUrl,
              fit: BoxFit.fill,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(36),
                    ),
                    child: Image.network(
                      'https://scontent.fsgn2-6.fna.fbcdn.net/v/t1.6435-9/32235283_112498146291756_1524370110523899904_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=D2XTKNlyqtkAX9BAeAn&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT8MVS4Bz9yv0uUHNYiqnpBSg0-hkiNECjwi8n_9FTXiaQ&oe=62C00232',
                      height: 25,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  const Text(
                    'huuloc888',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0,
                width: 18.0,
                child: IconButton(
                  splashRadius: 16.0,
                  padding: const EdgeInsets.all(0.0),
                  icon: const Icon(Icons.more_horiz, size: 18.0),
                  onPressed: () {},
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
