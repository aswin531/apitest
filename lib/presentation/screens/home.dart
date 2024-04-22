import 'package:bloc_posts/data/api/imageservice.dart';
import 'package:bloc_posts/presentation/utils/textstyles.dart';
import 'package:bloc_posts/presentation/widgets/homewidget.dart';
import 'package:flutter/material.dart';
import 'package:bloc_posts/data/api/apiservices.dart';
import 'package:bloc_posts/domain/entities/postentities.dart';
import 'package:bloc_posts/domain/entities/postimageentity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final postServices = PostServices();
  final imageService = ImageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts", style: TextStyles.heading),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All Posts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<PostModel>>(
                future: postServices.fetchAllPosts(),
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (postSnapshot.hasError) {
                    return Center(child: Text('Error: ${postSnapshot.error}'));
                  } else if (!postSnapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final posts = postSnapshot.data!;
                    return FutureBuilder<List<PostImageModel>>(
                      future: imageService.fetchImages(),
                      builder: (context, imageSnapshot) {
                        if (imageSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (imageSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${imageSnapshot.error}'));
                        } else if (!imageSnapshot.hasData) {
                          return const Center(
                              child: Text('No images available'));
                        } else {
                          final images = imageSnapshot.data!;
                          return PostsListBuilder(images: images, posts: posts);
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
