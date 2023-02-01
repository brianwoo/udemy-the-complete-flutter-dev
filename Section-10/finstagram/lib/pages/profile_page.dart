import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.05,
        vertical: _deviceHeight * 0.02,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImage(),
            _postsGridView(),
          ]),
    );
  }

  Widget _profileImage() {
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight * 0.02),
      child: CircleAvatar(
        radius: 50,
        foregroundImage: NetworkImage(_firebaseService.currentUser!['image']),
      ),
    );
  }

  Widget _postsGridView() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List posts = snapshot.data!.docs.map((e) => e.data()).toList();
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: posts.length,
              itemBuilder: (ctx, index) {
                Map post = posts[index];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(post['image']),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }
        },
        stream: _firebaseService.getPostsForUser(),
      ),
    );
  }
}
