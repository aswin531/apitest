import 'package:bloc_posts/domain/entities/postcommententities.dart';
import 'package:flutter/material.dart';

class CommentListBuilder extends StatelessWidget {
  final List<PostCommentModel>? comments;
   const CommentListBuilder({super.key,this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(separatorBuilder: (context, index) =>const Divider(thickness: 1,color: Colors.grey),itemCount: comments!.length,
      itemBuilder: (context, index) {
        final comment = comments?[index];
        return ListTile(
          title: Text("${comment!.body}"),
        );
    },);
  }
}