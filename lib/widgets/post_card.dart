import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const PostCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      semanticContainer: true,
      // Give each item a random background color
      key: ValueKey(item['id']),
      child: Image.network(
        item['image'],
        fit: BoxFit.fill,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    );
  }
}
