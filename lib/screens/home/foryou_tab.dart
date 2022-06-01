import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imagesio/widgets/category_list.dart';

class ForYouTab extends StatelessWidget {
  const ForYouTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate a list of dummy items
    final List<Map<String, dynamic>> _items = List.generate(
        200,
        (index) => {
              "id": index,
              "title": "Item $index",
              "height": Random().nextInt(150) + 50.5
            });

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
                      mainAxisSpacing: 4,
                      // horizontal gap between two items
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) {
                        return Card(
                          // Give each item a random background color
                          color: Color.fromARGB(
                              Random().nextInt(256),
                              Random().nextInt(256),
                              Random().nextInt(256),
                              Random().nextInt(256)),
                          key: ValueKey(_items[index]['id']),
                          child: SizedBox(
                            height: _items[index]['height'],
                            child: Center(
                              child: Text(_items[index]['title']),
                            ),
                          ),
                        );
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
