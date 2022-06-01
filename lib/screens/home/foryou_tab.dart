import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imagesio/services/post.dart';
import 'package:imagesio/widgets/category_list.dart';
import 'package:imagesio/widgets/post_card.dart';

class ForYouTab extends StatelessWidget {
  const ForYouTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate a list of dummy items
    final List<Map<String, dynamic>> _items = PostService().getDummyPosts;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          const CategoryList(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _items.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      // the number of columns
                      crossAxisCount: 2,
                      // vertical gap between two items
                      mainAxisSpacing: 2,
                      // horizontal gap between two items
                      crossAxisSpacing: 2,
                      itemBuilder: (context, index) {
                        return PostCard(item: _items[index]);
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
