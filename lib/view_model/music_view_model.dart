import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/data/repository/music_repository.dart';
import 'package:red_flag/model/music_model.dart';
import 'package:red_flag/widgets/common.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';

class MusicViewModel extends ChangeNotifier{
  MusicRepositoryImpl postRepositoryImpl = MusicRepositoryImpl();
  List<MusicModel> _musicList = [];
  List<MusicModel> get  musicList => _musicList;
  // late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loading(bool? loading){
    _isLoading = loading ?? false;
    notifyListeners();
  }
  Future<void> getPost() async {
    try{
      loading(true);
    _musicList = await postRepositoryImpl.musicCollection();
    loading(false);
    } catch(e){
      loading(false);
      errorToast("Unable to load music videos");
    }
  }
  loadVideoPlayer(VideoPlayerController videoController, {required String? url}) async {
    // videoPlayerController = VideoPlayerController.network(url ?? "");
    // videoPlayerController.addListener(() { 
    //   notifyListeners();
    // });
  
  chewieController = ChewieController(
    autoPlay: true,
    autoInitialize: true,
    videoPlayerController: videoController,
    aspectRatio: 16/9,
    errorBuilder: (context, errorMessage) {
      return const Center(
        child: CustomText(text: "Unable to load Video")
      );
    },
  );
 notifyListeners();
  //  videoPlayerController.initialize().then((value){
  //     notifyListeners();
  //   });
  }

  void closeAll() {
    chewieController.dispose();
  }
}