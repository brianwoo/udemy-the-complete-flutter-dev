import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late double _deviceHeight, _deviceWidth;
  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      child: _postsListView(),
    );
  }

  Widget _postsListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService.getLatestPosts(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          List posts = snapshot.data!.docs.map((e) => e.data()).toList();
          print(posts);
          return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, i) {
                Map post = posts[i];
                return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: _deviceHeight * 0.01,
                    horizontal: _deviceWidth * 0.05,
                  ),
                  height: _deviceHeight * 0.30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(post['image']),
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
