import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/admin_post.dart';
import 'package:red_flag/widgets/button_widget.dart';
import 'package:red_flag/widgets/custom_form_field.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CreateAffirmation extends StatefulWidget {
  const CreateAffirmation({ Key? key }) : super(key: key);

  @override
  State<CreateAffirmation> createState() => _CreateAffirmationState();
}

class _CreateAffirmationState extends State<CreateAffirmation> {
  File? _imageFile;
  final _picker = ImagePicker();
    /// Get image from gallery
  Future getFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 0);
    if (pickedFile != null) {
        // _imageLink = true;
        setState(() {
        _imageFile = File(pickedFile.path);
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminPost>(context); 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
        GestureDetector(
                child:  Image.asset("assets/icons/clarity_notification-outline-badged.png",width: 30,color:Colors.white)),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomText(text: UserData.fullName()),
        )
      ]),
    body: SingleChildScrollView(
      child: Padding(
        padding: kPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomText(text: "New Affirmation", size: 18.sp,weight: FontWeight.w700,),
          const SizedBox(height: 15,),
          TextFieldC(
          textColor: Colors.black,
          text: "Title",
           controller: provider.titleTex,
           onChanged: (value){},
          ),
          const SizedBox(height: 10,),
          const CustomText(text: "Upload Affirmation Videos"),
           Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: GestureDetector(
            onTap: () async => provider.getVideo(),
            child: Container(
              color: Colors.grey,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text('Upload Video',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Core Pro',
                        color: Colors.white,
                      )),
                  const SizedBox(height: 15),
                //   provider.videoFile == null
                //       ? Image.asset('assets/icons/gallery-add.png')
                //       : _videoPlayerController.value.initialized
                //     ? AspectRatio(
                //         aspectRatio: _videoPlayerController.value.aspectRatio,
                //         child: VideoPlayer(_videoPlayerController),
                //     )
                // : Container(),
                  const SizedBox(height: 15),
                  provider.videoFile == null
                      ? const Text('Tap to Add',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Core Pro',
                            color: Color(0xff116FFD),
                          ))
                      : const Text('Change Video',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Core Pro',
                            color: Color(0xff116FFD),
                          )),
                  Container(
                    height: 40.0,
                  ),
                 ],
              ),
            ))),
          const SizedBox(height:15),
          //  TextField(
          //  controller: provider.postDetailsTex,
          //  maxLines: 5,
          //   decoration:const InputDecoration(              
          //     // prefixIcon: ,
          //     filled: true,
          //     fillColor: Colors.white,
          //     floatingLabelStyle: TextStyle(
          //     ),
          //   contentPadding: EdgeInsets.only(left:10,bottom: 47 / 2),
          //     border: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.black),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //   ),
          //  onChanged: (value){},
          // ),
          const SizedBox(height: 10,),
          Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: GestureDetector(
            onTap: () async => getFromGallery(),
            child: Container(
              color: Colors.grey,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text('Add a Cover Image',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Core Pro',
                        color: Colors.white,
                      )),
                  const SizedBox(height: 15),
                  _imageFile == null
                      ? Image.asset('assets/icons/gallery-add.png')
                      : Image.file(
                          _imageFile!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(height: 15),
                  _imageFile == null
                      ? const Text('Tap to Add',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Core Pro',
                            color: Color(0xff116FFD),
                          ))
                      : const Text('Change Image',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Core Pro',
                            color: Color(0xff116FFD),
                          )),
                  Container(
                    height: 40.0,
                  ),
                 ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 15,),
        ButtonWidget(text:provider.isLoading ? "Loading...." : "Create Affirmation",press:provider.isLoading ? null : ()=> provider.createAffirmation(context,imageFile: _imageFile))
        ],),
      ),
    ),
    );
  }
}