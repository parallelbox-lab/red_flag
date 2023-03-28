import 'package:flutter/material.dart';
import 'package:red_flag/data/repository/our_stories_repository.dart';
import 'package:red_flag/model/our_stories_model.dart';
import 'package:red_flag/widgets/common.dart';

class OurStoriesViewModel extends ChangeNotifier{
  List<OurStoriesModel> _ourStoriesList = [];
  List<OurStoriesModel> get ourStoriesList => _ourStoriesList;
  OurStoriesRepositoryImpl ourStoriesRepositoryImpl = OurStoriesRepositoryImpl();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loading(bool? loading){
    _isLoading = loading ?? false;
    notifyListeners();
  }
  Future<void> getOurStories() async{
    try{
      loading(true);
     _ourStoriesList = await ourStoriesRepositoryImpl.getStories();
     loading(false);
    } catch(e){
      loading(false);
      errorToast("Unable to load Our Stories");
    }

  }
  Future<void> searchOurStories(String?query) async{
    try{
      loading(true);
      final data = await ourStoriesRepositoryImpl.getStories();
      _ourStoriesList = data;
      if(query!.isEmpty){
      _ourStoriesList;
      }
      _ourStoriesList.where((ourPost) => ourPost.postDetails!.contains(query.toLowerCase()),);
      notifyListeners();
     loading(false);
    } catch(e){
      loading(false);
      errorToast("Unable to load Our Stories");
    }

  }
}