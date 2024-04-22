import 'package:bloc_posts/data/api/commentapiservice.dart';
import 'package:bloc_posts/domain/entities/postcommententities.dart';
import 'package:bloc_posts/domain/entities/postentities.dart';
import 'package:bloc_posts/domain/entities/postimageentity.dart';
import 'package:bloc_posts/presentation/utils/textstyles.dart';
import 'package:bloc_posts/presentation/widgets/commentwidget.dart';
import 'package:bloc_posts/presentation/widgets/popbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostDetailedScreen extends StatelessWidget {
  final PostModel? post;
  final PostImageModel? image;
  final commentService = CommentService();
  PostDetailedScreen({super.key, this.post, this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: PopButton(
          icon: Icons.arrow_back_ios_new,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Post Details"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${post?.title}",
                style: TextStyles.heading,
                overflow: TextOverflow.clip,
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: SizedBox(
                  height: 200,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: "${image?.url}",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.flag_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Discription :",
                    style: TextStyles.subheading,
                  )
                ],
              ),
              Text(
                " ${post?.body}",
                style: TextStyles.bodyText,
                overflow: TextOverflow.clip,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Comments :",
                style: TextStyles.subheading,
              ),
              Expanded(
                  child: FutureBuilder<List<PostCommentModel>>(
                future: commentService.fetchComments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No images available'));
                  } else {
                    final comments = snapshot.data!;
                    return CommentListBuilder(comments: comments);
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
