import 'package:flutter/material.dart';

class TabbarWidget extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;
  const TabbarWidget({
    Key? key,
    required this.index,
    required this.onChangedTab,
  }) : super(key: key);

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget> {
  @override
  Widget build(BuildContext context) {
    const placeholder = Opacity(
      opacity: 0,
      child: IconButton(onPressed: null, icon: Icon(Icons.no_cell)),
    );

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        buildTabItem(
          index: 0,
          icon: const Icon(Icons.home),
        ),
        buildTabItem(
          index: 1,
          icon: const Icon(Icons.search),
        ),
        placeholder,
        buildTabItem(
          index: 2,
          icon: const Icon(Icons.notifications),
        ),
        buildTabItem(
          index: 3,
          icon: const Icon(Icons.account_circle),
        )
      ]),
    );
  }

  Widget buildTabItem({
    required int index,
    required Icon icon,
  }) {
    final isSelected = index == widget.index;

    return IconTheme(
      data: IconThemeData(
        color: isSelected ? Colors.blue : Colors.black,
      ),
      child: IconButton(
        onPressed: () => widget.onChangedTab(index),
        icon: icon,
      ),
    );
  }
}
