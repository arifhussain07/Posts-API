
 import 'package:equatable/equatable.dart';
import 'package:post_youtube/utils/enums.dart';

import '../../model/posts_model.dart';

class PostStates extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> postList;
  final List<PostModel> temPostList;
  final String message;
  final String searchMessage;

  const PostStates( {this.postStatus = PostStatus.loading,
    this.postList = const <PostModel>[],
    this.temPostList = const <PostModel>[],
    this.message = '',
    this.searchMessage = '',

});

  PostStates copyWith({PostStatus? postStatus,List<PostModel>? postList, String ? message, List<PostModel>? temPostList, String ? searchMessage}){
    return PostStates(
    postStatus: postStatus ?? this.postStatus,
      postList: postList ?? this.postList,
      temPostList: temPostList ?? this.temPostList,
    message: message?? this.message ,
      searchMessage: searchMessage ?? this.searchMessage ,
    );
 }


  @override
  // TODO: implement props
  List<Object?> get props => [postStatus, postStatus, temPostList, message , searchMessage];
}

