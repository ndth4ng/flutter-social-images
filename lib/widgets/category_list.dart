import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final categoryList = [
    'Tech',
    'Sport',
    'Anime',
    'Game',
    'Fashion',
    'Tech',
    'Sport',
    'Anime',
    'Game',
    'Fashion',
  ];

  int _currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 30,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => setState(() {
                  _currentSelected = index;
                }),
                child: Text(
                  categoryList[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: _currentSelected == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color:
                        _currentSelected == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
          separatorBuilder: (_, index) => const SizedBox(width: 20),
          itemCount: categoryList.length),
    );
  }
}
