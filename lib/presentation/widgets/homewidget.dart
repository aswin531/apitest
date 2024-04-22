import 'package:bloc_posts/domain/entities/postentities.dart';
import 'package:bloc_posts/domain/entities/postimageentity.dart';
import 'package:bloc_posts/presentation/screens/detailedscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostsListBuilder extends StatelessWidget {
  final List<PostModel> posts;
  final List<PostImageModel> images;

  const PostsListBuilder({
    super.key,
    required this.posts,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(thickness: 5),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        final image = images[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostDetailedScreen(
                post: post,image: image,
              ),
            ));
          },
          leading: CircleAvatar(
            child: CachedNetworkImage(
              imageUrl: image.url ?? '',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: Text(post.title ?? 'Post Title'),
          subtitle: Text(post.body ?? 'Post Details',
              overflow: TextOverflow.ellipsis),
        );
      },
    );
  }
}
