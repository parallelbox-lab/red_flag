import 'package:flutter/material.dart';
import 'package:red_flag/screens/forum/widgets/music_video_forum.dart';
import 'package:red_flag/screens/forum/widgets/riddle_forum.dart';
import 'package:red_flag/screens/search/widgets/affirmation.dart';
import 'package:red_flag/screens/search/widgets/music_video_search.dart';
import 'package:red_flag/screens/search/widgets/riddles_search.dart';
import 'package:red_flag/utils/constants.dart';


class ForumSearch extends StatefulWidget {
  const ForumSearch({ Key? key,this.searchQuery }) : super(key: key);
  final String? searchQuery;

  @override
  State<ForumSearch> createState() => _ForumSearchState();
}

class _ForumSearchState extends State<ForumSearch> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // ScreenUtil.init();
    return Scaffold(
      
    body: SingleChildScrollView(child: Padding(
      padding:kPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [       
        const SizedBox(height:10),
        AffirmationSearch(searchQuery: widget.searchQuery,),
        const SizedBox(height:20),
        RiddlesSearch(searchQuery:  widget.searchQuery,),
        const SizedBox(height:20),
        MusicViewVideoSearch(searchQuery:widget.searchQuery ,)    
       ],),
    )),
    );
  }
  @override
  bool get wantKeepAlive => true;
}