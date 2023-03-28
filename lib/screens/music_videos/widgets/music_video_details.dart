import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_flag/model/music_model.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/back_btn.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';

class MusicVideoDetaild extends StatefulWidget {
  const MusicVideoDetaild({ Key? key,this.musicModel }) : super(key: key);
  final MusicModel? musicModel;
  @override
  State<MusicVideoDetaild> createState() => _MusicVideoDetaildState();
}

class _MusicVideoDetaildState extends State<MusicVideoDetaild> {
  // VideoPlayerController? videoPlayerController;
  // ChewieController? chewieController;
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    controller = VideoPlayerController.network(widget.musicModel?.post ?? "");
    futureController = controller!.initialize();
  }
  @override
  void initState() {
    //videoPlayerController = VideoPlayerController.network(widget.musicModel?.post ?? "");
    //print(widget.musicModel?.post);
     initVideo();
    controller!.addListener(() {
      if (controller!.value.isInitialized) {
        currentPosition.value = controller!.value;
      }
    });
  //   chewieController = ChewieController(
  //   autoPlay: false,
  //   looping: false,
  //   // autoInitialize: true,
  //   videoPlayerController: videoPlayerController!,
  //   aspectRatio: 16/9,
  //   errorBuilder: (context, errorMessage) {
  //     return Center(
  //       child: CustomText(text: errorMessage)
  //     );
  //   },
  // );
    // context.read<MusicViewModel>().loadVideoPlayer(videoPlayerController!,url: widget.musicModel?.post ??"");  
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    // videoPlayerController?.dispose();
    // chewieController?.dispose();
    controller!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<MusicViewModel>(context);
    return Scaffold(
       backgroundColor: kPrimaryColor,
      // appBar: AppBar(
      //  // backgroundColor: Colors.transparent,
      //   iconTheme:const IconThemeData(color: Colors.white),
      // ),
      body:  Column(
          children: [
          const CustomBackButton(),
           Container(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Container(
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(.7),
                                Colors.transparent
                              ],
                              stops: const [
                                0,
                                .3
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                        child: VideoPlayer(controller!)) ),
                Positioned.fill(
                    child: Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child:controller!.value.isInitialized
                           ?   IconButton(
                                icon: Icon(
                                  controller!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.grey,
                                  size: 60,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (controller!.value.isPlaying) {
                                      controller!.pause();
                                    } else {
                                      controller!.play();
                                    }
                                  });
                                },
                              ) : const Center(child: CircularProgressIndicator())),
                        ],
                      ),
                    ),
                 
                  ],
                )),
              ],
            ),
          ),
          const SizedBox(height: 15,),
          CustomText(text: widget.musicModel?.title)
          ],
        )
    
    );
  }
}