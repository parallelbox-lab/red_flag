import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/repository/post_repository.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/model/post_model.dart';
import 'package:red_flag/widgets/common.dart';

class PostViewModel extends ChangeNotifier{
  PostRepositoryImpl postRepositoryImpl = PostRepositoryImpl();
  List<PostModel> _postList = [];
  List<PostModel> _postByUsersList = [];
    List<PostModel> get postByUsersList =>  _postByUsersList;
  List<PostModel> get  postList => _postList;
  List<PostModel> get  searchList => _searchList;
  List<PostModel> _searchList = [];
  bool _isLoading = false;
  bool get isLoading =>_isLoading;
  Future<void> getPost() async {
    try{
    loading(true);
    _postList = await postRepositoryImpl.postCollection();
    notifyListeners();
    loading(false);
    } catch(e){
    loading(false);
    }
    // print(_postList.map((e) => print(e.postTitle)));
    // yield*
  }
   onSearchTextChanged(PostModel postDetail, String query) async {
       print(postDetail.details);
      if (postDetail.details!.contains(query)) _searchList.add(postDetail);
      print(_searchList.length.toString());
    // if (text.isEmpty) {
    //   return;
    // }
    //  _postList.forEach((postDetail) {
    //   print(postDetail.postTitle);
    //   if (postDetail.postTitle.contains(text) ||
    //       postDetail.details!.contains(text)) _searchList.add(postDetail);
    // });
    notifyListeners();
  }

Future<void> refreshPost() async {
    try{
    _postList = await postRepositoryImpl.postCollection();
    } catch(e){
      errorToast("unable to load");
    }
    // print(_postList.map((e) => print(e.postTitle)));
    // yield*
  }

 loading(bool? loading){
  _isLoading = loading ?? false;
  notifyListeners();
 }
  Future<void> getPostByUsers() async {
    try{
    loading(true);
    _postByUsersList = await postRepositoryImpl.getPostByUsers();
    loading(false);
    notifyListeners();
    }catch(e){
      loading(false);
    }
  }
Future commentPost({required String? postId, required String? postOwnerId,required String? comment}) async {
  try{
    await postRepositoryImpl.createCommentsCollection(
      id: postId,
      postOwnerId:postOwnerId,
      comment:comment,
      addedTime: DateTime.now().microsecondsSinceEpoch.toString()
    );
  } catch(e){
    rethrow;

  }
}
Future<void> searchPost(String query,BuildContext context) async {
    try{
    loading(true);
    final data = await postRepositoryImpl.searchPost(query: query);
    _searchList = data;
    notifyListeners();
        // data.
        // .then((value) {
      // ignore: prefer_is_empty
      // if (value.docs.length < 1) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text("No User Found")));
      // loading(false);
      //   return;
      // }
      //  _searchList =  data;
  //   final postList = await postRepositoryImpl.postCollection();
  //    // print(query);
  //    print(postList.length.toString());
  //   if (query.isEmpty) {
  //     showerrorDialog("not found", context, true);
  //   } 
  //   for(int i=0; i< postList.length; i++){
  //     if (postList[i].details!.contains(query)) _searchList.add(postList[i]);
  // }
  //     notifyListeners();
  //     print(_searchList.length.toString());
    //  postList.forEach((postDetail) {
    //   print(postDetail.postTitle);
    //   if (postDetail.postTitle!.contains(query) ||
    //       postDetail.details!.contains(query)) _searchList.add(postDetail);
    // });
  //  });
    // final data = await postRepositoryImpl.postCollection();
    // for(int i =0; i < data.length; i++ ){
    //   if(data[i].details.toString().toLowerCase().contains(query!.toLowerCase())){
    //     print(data[i].details);
    //       //  _searchList = data[i];
    //     } else {
          // _searchList = [];
    //     }
    // }
    //Future<List<DocumentSnapshot>> getSuggestion(String suggestion) =>
      
    
    // _searchList.where((post) => post.details!.contains(query!.toLowerCase()));
    
    loading(false);
  } catch (e){
    loading(false);
    errorToast(e.toString());
    }
  } 

  handleLikes({bool? isLiked, List<dynamic>? totalLikes, String? postId}) {
    if(totalLikes!.contains(UserData.getUserId())){
      totalLikes.remove(UserData.getUserId());
      postRepositoryImpl.unLikeHandler(postId: postId,likes: totalLikes);
      refreshPost();
     notifyListeners();
    } else {
      totalLikes.add(UserData.getUserId());
      postRepositoryImpl.likeHandler(postId: postId,likes: totalLikes);
      refreshPost();
      notifyListeners();
    }
  }

}