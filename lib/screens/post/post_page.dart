import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/post.dart';
import 'package:imagesio/screens/post/comment_item.dart';
import 'package:imagesio/screens/post/fullscreen_image.dart';
import 'package:imagesio/services/post.dart';

import '../../widgets/draggable_line.dart';

class PostPage extends StatefulWidget {
  static const routeName = '/post';

  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  int _currentTab = 0;
  bool _seeMore = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String postId = arg['postId'];
    Author author = arg['author'];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(postId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                var docsnap = snapshot.data;
                Post post =
                    Post.fromJson(docsnap?.data() as Map<String, dynamic>);
                print(post.title);

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(36),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3.0,
                            offset: Offset(0, 3.0),
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 450,
                                  minWidth: MediaQuery.of(context).size.width,
                                ),
                                child: GestureDetector(
                                  child: Image(
                                    image: NetworkImage(post.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return FullScreenImage(
                                        imageUrl: post.imageUrl,
                                      );
                                    }));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.white,
                                      icon: const Icon(
                                          Icons.arrow_back_ios_rounded),
                                      iconSize: 24.0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 8.0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        color: Color.fromRGBO(38, 38, 38, 0.2),
                                      ),
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () => setState(() {
                                              _currentTab = 0;
                                            }),
                                            child: const Text('Picture'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white.withOpacity(
                                                  _currentTab == 0 ? 1 : 0.6),
                                              onPrimary: Colors.black
                                                  .withOpacity(_currentTab == 0
                                                      ? 1
                                                      : 0.6),
                                              textStyle: TextStyle(
                                                  fontWeight: _currentTab == 0
                                                      ? FontWeight.w700
                                                      : FontWeight.normal),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(36),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),

                                          // Open Comment Sheet
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _currentTab = 1;
                                              });

                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) =>
                                                    buildCommentSheet(
                                                        post, author),
                                              ).whenComplete(
                                                () => setState(() {
                                                  _currentTab = 0;
                                                }),
                                              );
                                            },
                                            child: const Text('Comment'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white.withOpacity(
                                                  _currentTab == 1 ? 1 : 0.6),
                                              onPrimary: Colors.black
                                                  .withOpacity(_currentTab == 1
                                                      ? 1
                                                      : 0.6),
                                              textStyle: TextStyle(
                                                  fontWeight: _currentTab == 1
                                                      ? FontWeight.w700
                                                      : FontWeight.normal),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(36),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      color: Colors.white,
                                      icon: const Icon(Icons.more_horiz),
                                      iconSize: 36.0,
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Author
                                const AuthorWidget(),

                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    post.title!,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 4.0,
                                ),

                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    post.description!,
                                    textAlign: TextAlign.left,
                                    maxLines: _seeMore == false ? 4 : null,
                                    overflow: _seeMore == false
                                        ? TextOverflow.ellipsis
                                        : null,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () => setState(() {
                                      _seeMore = !_seeMore;
                                    }),
                                    child: _seeMore == false
                                        ? const Icon(Icons
                                            .keyboard_double_arrow_down_rounded)
                                        : const Icon(Icons
                                            .keyboard_double_arrow_up_rounded),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReactionWidget(currentTab: _currentTab),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Widget buildCommentSheet(Post post, Author author) {
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.85,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(36),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DraggableLine(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: post.comments.length,
                  itemBuilder: (context, index) {
                    return CommentItem(
                        author: author, comment: post.comments[index]);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Flexible(
                      child: CommentInput(),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.arrow_circle_right,
                      size: 36.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReactionWidget extends StatelessWidget {
  const ReactionWidget({
    Key? key,
    required int currentTab,
  })  : _currentTab = currentTab,
        super(key: key);

  final int _currentTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.heart_broken),
          label: const Text('7.654'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0.0,
            primary: Colors.grey[200],
            onPrimary: Colors.black,
            textStyle: TextStyle(
                fontWeight:
                    _currentTab == 0 ? FontWeight.w700 : FontWeight.normal),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.comment_rounded,
            color: Colors.grey,
          ),
          label: const Text('5.687'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0.0,
            primary: Colors.grey[200],
            onPrimary: Colors.black,
            textStyle: TextStyle(
                fontWeight:
                    _currentTab == 0 ? FontWeight.w700 : FontWeight.normal),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => {},
          icon: const Icon(
            Icons.download,
            color: Colors.grey,
          ),
          label: const Text('3.879'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 0.0,
            primary: Colors.grey[200],
            onPrimary: Colors.black,
            textStyle: TextStyle(
                fontWeight:
                    _currentTab == 0 ? FontWeight.w700 : FontWeight.normal),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),
      ],
    );
  }
}

class AuthorWidget extends StatelessWidget {
  const AuthorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(999),
              ),
              child: Image.network(
                'https://scontent.fsgn2-6.fna.fbcdn.net/v/t1.6435-9/32235283_112498146291756_1524370110523899904_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=D2XTKNlyqtkAX9BAeAn&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT8MVS4Bz9yv0uUHNYiqnpBSg0-hkiNECjwi8n_9FTXiaQ&oe=62C00232',
                height: 50,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Huu Loc',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '@huuloc888',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Follow'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
        ),
      ],
    );
  }
}

class CommentInput extends StatelessWidget {
  const CommentInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        minLines: 1,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          fillColor: Colors.grey[200],
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          hintStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
          ),
          isDense: true,
        ));
  }
}
