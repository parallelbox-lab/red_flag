import 'dart:io';

import 'package:flutter/material.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({ Key? key, this.imagePreview }) : super(key: key);
 final File? imagePreview;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){ 
              imagePreview;
              Navigator.pop(context);
            }
            , icon:const Icon(Icons.close)),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CustomText(text: "Next", size: 15.sp,),
            ),
          ],
        )
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
         Image.file(
                  imagePreview!,
                  fit: BoxFit.cover,)
        ],),
      )
      
    );
  }
}