import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imagesio/models/author.dart';
import 'package:imagesio/models/post.dart';
import 'package:imagesio/shared/constants.dart';
import 'package:imagesio/widgets/custom_floating_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, String>> listPosts = [
    {
      'image': 'assets/images/post-1.jpg',
    },
    {
      'image': 'assets/images/post-2.jpg',
    },
    {
      'image': 'assets/images/post-3.jpg',
    },
    {
      'image': 'assets/images/post-4.jpg',
    },
    {
      'image': 'assets/images/post-5.jpg',
    },
    {
      'image': 'assets/images/post-6.jpg',
    },
    {
      'image': 'assets/images/post-7.jpg',
    },
    {
      'image': 'assets/images/post-8.jpg',
    },
    {
      'image': 'assets/images/post-9.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    User? currentUser = Provider.of<User?>(context);

    final Stream<DocumentSnapshot> _stream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .snapshots();

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // topbar
            SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: _stream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasData) {
                          Author? author = Author.fromJson(
                              snapshot.data.data() as Map<String, dynamic>);

                          return Text(
                            author.username!,
                            style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo),
                    ),
                    IconButton(
                      onPressed: () {
                        MyFloatingActionButton();
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                        stream: _stream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasData) {
                            Author? author = Author.fromJson(
                                snapshot.data.data() as Map<String, dynamic>);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 14),
                                // prifule statistic
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          author.avatar,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              author.followings?.length
                                                      .toString() ??
                                                  '0',
                                              style: const TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const Text(
                                              'Following',
                                              style: TextStyle(
                                                color: black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              author.followers?.length
                                                      .toString() ??
                                                  '0',
                                              style: const TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const Text(
                                              'Followers',
                                              style: TextStyle(
                                                color: black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '1,042',
                                              style: TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Text(
                                              'Like',
                                              style: TextStyle(
                                                color: black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // username
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    '@${author.username}',
                                    style: const TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                // display name
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    author.displayName ?? author.username!,
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                // bio
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    author.bio ?? '',
                                    style: const TextStyle(
                                      color: hyperlinkColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          return const CircularProgressIndicator();
                        }),

                    // Follow and Message buttons
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Follow'),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF26BAEE),
                              onPrimary: Colors.white,
                              fixedSize: const Size(170, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Message'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              fixedSize: const Size(170, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Stories
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF26BAEE),
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/highlight-1.jpg',
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('Nguyen'),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: secondaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/highlight-2.jpg',
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('Huu'),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: secondaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/highlight-3.jpg',
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('Loc'),
                            ],
                          ),
                          const SizedBox(width: 14),
                          Column(
                            children: [
                              Container(
                                height: 74,
                                width: 74,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: secondaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(74),
                                ),
                                child: const Center(
                                  child: Icon(Icons.add, size: 40),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text('New'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tab menu
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/icons/post.svg',
                                  height: 24,
                                  width: 24,
                                  color: black,
                                ),
                                const Spacer(),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: black,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/icons/panduan.svg',
                                  height: 24,
                                  width: 24,
                                ),
                                const Spacer(),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: white,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/icons/tag.svg',
                                  height: 24,
                                  width: 24,
                                ),
                                const Spacer(),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // grid post
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('posts')
                          .where('userRef',
                              isEqualTo: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(currentUser?.uid))
                          .get(),
                      builder: ((BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasData) {
                          // return Container();
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1 / 1,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                color: hyperlinkColor,
                                child: Image.network(
                                  snapshot.data!.docs[index]['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            itemCount: snapshot.data!.docs.length,
                          );
                        }

                        return const CircularProgressIndicator();
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// bottom sheet modal
class BottomSheetModal extends StatelessWidget {
  const BottomSheetModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(23),
              topLeft: Radius.circular(40),
            ),
          ),
          isScrollControlled: false, // chi co the keo xuong
          isDismissible: true, // co the keo xuong va an vao auto out
          backgroundColor: Colors.white,
          context: context,
          builder: (context) => DraggableScrollableSheet(
            // initialChildSize: 0.4,
            // minChildSize: 0.2,
            // maxChildSize: 0.6,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: ModalScrollController.of(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Infomation',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Support',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Get Support',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const Text(
                      'Security and privacy',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Message'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.black,
                        fixedSize: const Size(170, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 300,
                      width: 250,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 36,
        decoration: buttonDecoration,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
