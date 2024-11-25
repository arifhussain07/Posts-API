import 'package:bloc/bloc.dart';
import 'package:post_youtube/bloc/posts/posts_event.dart';

import 'package:post_youtube/bloc/posts/posts_state.dart';

import '../../model/posts_model.dart';
import '../../repository/post_repository.dart';
import '../../utils/enums.dart';


class PostsBloc extends Bloc<PostsEvent, PostStates> {

  List<PostModel> temPostList = [];

  PostRepository postRepository =PostRepository();
  PostsBloc() : super(PostStates()) {
on<PostFetched>(fetchPostAPI);
on<SearchItem>(_filterList);

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

  void _filterList(SearchItem event, Emitter<PostStates>emit)async{

    if(event.stSearch.isEmpty){
      emit(state.copyWith(temPostList: [], searchMessage: ''));
    }else{
      temPostList = state.postList.where((element)=> element.email.toString().toLowerCase().contains(event.stSearch.toLowerCase())).toList();
      if(temPostList.isEmpty){

        emit(state.copyWith(temPostList: temPostList , searchMessage: 'No Data found'));

      }else{
        emit(state.copyWith(temPostList: temPostList));

      }
    }

  }
}
