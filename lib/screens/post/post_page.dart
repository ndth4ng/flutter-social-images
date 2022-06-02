import 'package:flutter/material.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/post.dart';

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
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Post post = arg['post'];
    Author author = arg['author'];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                          child: Container(
                            color: Colors.red,
                            child: Image(
                              image: NetworkImage(post.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                color: Colors.white,
                                icon: const Icon(Icons.arrow_back_ios_rounded),
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
                                        onPrimary: Colors.black.withOpacity(
                                            _currentTab == 0 ? 1 : 0.6),
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
                                    ElevatedButton(
                                      onPressed: () => setState(() {
                                        _currentTab = 1;
                                      }),
                                      child: const Text('Comment'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white.withOpacity(
                                            _currentTab == 1 ? 1 : 0.6),
                                        onPrimary: Colors.black.withOpacity(
                                            _currentTab == 1 ? 1 : 0.6),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                  ? const Icon(
                                      Icons.keyboard_double_arrow_down_rounded)
                                  : const Icon(
                                      Icons.keyboard_double_arrow_up_rounded),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Author
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
