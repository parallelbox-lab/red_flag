import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:red_flag/data/services/user_data.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/view_model/register_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:red_flag/widgets/image_preview.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isEdited = false;
File? imageFile;
final _picker = ImagePicker();
/// Get image from gallery
 Future getFromGallery(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 0);
    if (pickedFile != null) {
      setState(() {
        isEdited = true;
       imageFile = File(pickedFile.path);
      });
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => ImagePreview(imagePreview: imageFile,)));
    }
  }
  
  TextEditingController fullNameTex = TextEditingController();
  @override
  void initState() {
    fullNameTex.text = UserData.fullName() ?? "";
    super.initState();
  }
  // TextEditingController 
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xffF5F8FA),
        centerTitle: true,
        iconTheme:const IconThemeData(color: Colors.black),
        title: CustomText(text: "Edit Profile",size: 14.sp,weight: FontWeight.w600,color: Colors.black,),
        actions: [
          Padding(
            padding:const EdgeInsets.all(15.0),
            child:provider.profileEdit ? Row(
              children: [
               CustomText(text: "Saving",size: 13.sp,),
               const CircularProgressIndicator(
                   strokeWidth: 1.5,
                   valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)
                )
              ],
            )  : GestureDetector(
                onTap: isEdited == false ? null : ()=> provider.editProfile(
                context,
                imageFile: imageFile,
                fullName: fullNameTex.text.trim()
               ),
              child: CustomText(text: "Save",color:isEdited == false  ?  Colors.white : Colors.blue)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      GestureDetector(
        onTap: ()=> getFromGallery(context),
        child: Center(
          child: Stack(
              children: [
              imageFile == null ? Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.blue,
                          image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(UserData.getUserProfilePic() ?? ""),
                          ),
                ),) : Container(
                        height: 150,
                        width: 150,
                       decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            image: DecorationImage(image: FileImage(imageFile!))
                          )
              ) ,   
             Positioned(
                  right:0,
                  bottom:40,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: Image.asset("assets/icons/bi_camera-fill.png",width: 30,),))
              ],
            ),
        ),
      ),
     SizedBox(height:size.height / 150 ,),
    const  Center(child: CustomText(text: "Change Profile Picture", color: Color(0xff3F37C9),weight: FontWeight.w800,)),
      SizedBox(height:size.height / 30 ,),
        CustomText(text: "Name",size: 12.sp,color:const Color(0xff657786)),
       TextFormField(        
            keyboardType: TextInputType.text,
            controller: fullNameTex,
            onChanged: (value){
              value = fullNameTex.text;     
              setState(() => isEdited = true);
          },
            decoration:const InputDecoration(              
              // prefixIcon: ,
             // filled: true,
              fillColor: Colors.white,
              floatingLabelStyle:TextStyle(
              ),
           // contentPadding:const EdgeInsets.only(left:10,bottom: 47 / 2),
            //   border:OutlineInputBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(4))),
           ),
            // onFieldSubmitted: (_) {
            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
            // },
       ),
     

          
      ],),
        )),
    );
  }
}