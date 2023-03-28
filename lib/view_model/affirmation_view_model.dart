import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/repository/affirmation_repository.dart';
import 'package:red_flag/model/affirmation_model.dart';
import 'package:red_flag/widgets/common.dart';
import 'package:video_player/video_player.dart';

class AffirmationViewModel extends ChangeNotifier{
   AffirmationRepositoryImpl riddleRepositoryImpl = AffirmationRepositoryImpl();
  List<AffirmationModel> _affirmationList = [];
  List<AffirmationModel> get affirmationList => _affirmationList;
  bool _isLoading = false;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  bool get isLoading => _isLoading;
  loading(bool? loading){
    _isLoading = loading ?? false;
    notifyListeners();
  }
  Future<void> getAffirmation() async {
    try{
    loading(true);
    _affirmationList = await riddleRepositoryImpl.affirmationCollection();
        loading(false);
    notifyListeners();
    } catch (e){
      loading(false);
      errorToast("Unable to load Riddles");
    }
    // print(riddleList.map((e) => print(e.title)));
  }
  loadVideoPlayer({required String? url}) {
    videoPlayerController = VideoPlayerController.network(url ?? "");
    videoPlayerController!.addListener(() { 
      notifyListeners();
    });
  
  chewieController = ChewieController(videoPlayerController: videoPlayerController!,
  aspectRatio: 16/9
  );
   videoPlayerController!.initialize().then((value){
      notifyListeners();
    });
  }

  // void closeAll() {
    
  //   videoPlayerController!.dispose();
  //   chewieController!.dispose();
  // }
  
  Future<void> searchAffirmation(String? query) async {
    try{
      loading(true);
    final data = await riddleRepositoryImpl.affirmationCollection();
    _affirmationList = data;
    if(query!.isEmpty){
    _affirmationList;
      loading(false);
    }
    _affirmationList.where((affirmation) => affirmation.post!.contains(query.toLowerCase()));
    loading(false);
    notifyListeners();
  } catch (e){
      loading(false);
      errorToast("Unable to load Riddles");
    }
  } 
}