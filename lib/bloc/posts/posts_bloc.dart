import 'package:bloc/bloc.dart';
import 'package:post_youtube/bloc/posts/posts_event.dart';

import 'package:post_youtube/bloc/posts/posts_state.dart';

import '../../repository/post_repository.dart';
import '../../utils/enums.dart';

PostRepository postRepository =PostRepository();
class PostsBloc extends Bloc<PostsEvent, PostStates> {
  PostsBloc() : super(PostStates()) {
on<PostFetched>(fetchPostAPI);

  }
  void fetchPostAPI(PostFetched event, Emitter<PostStates>emit)async{
   await postRepository.fetchPost().then((value){
      emit(state.copyWith(postStatus: PostStatus.success,message: 'success',
      postList: value
      ));
    }).onError((error , stackTrace) {
      print(error);
      print(stackTrace);
      emit(state.copyWith(postStatus: PostStatus.failure, message: error.toString()));
    });
  }
}
