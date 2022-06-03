import 'package:flutter/material.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/comment.dart';

class CommentItem extends StatelessWidget {
  final Author author;
  final Comment comment;
  const CommentItem({
    Key? key,
    required this.author,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(999),
            ),
            child: Image.network(
              'https://scontent.fsgn2-6.fna.fbcdn.net/v/t1.6435-9/32235283_112498146291756_1524370110523899904_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=D2XTKNlyqtkAX9BAeAn&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT8MVS4Bz9yv0uUHNYiqnpBSg0-hkiNECjwi8n_9FTXiaQ&oe=62C00232',
              height: 40,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${author.username}: ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: comment.content),
              ],
            ),
          )
        ],
      ),
    );
  }
}
