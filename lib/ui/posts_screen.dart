

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_youtube/bloc/posts/posts_bloc.dart';
import 'package:post_youtube/bloc/posts/posts_state.dart';
import 'package:post_youtube/utils/enums.dart';

import '../bloc/posts/posts_event.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState(){
    super.initState();
    context.read<PostsBloc>().add(PostFetched());
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts API'),
      ),
      body: BlocBuilder<PostsBloc, PostStates>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostStatus.failure:
              return Center(child: Text(state.message.toString()));
            case PostStatus.success:
              return ListView.builder(
                itemCount: state.postList.length,
                itemBuilder: (context, index) {
                  final item = state.postList[index];
                  return ListTile(
                    title: Text(item.email.toString()),
                    subtitle: Text(item.body.toString()),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
