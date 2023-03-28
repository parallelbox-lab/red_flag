import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import 'package:red_flag/screens/auth/login/login.dart';
import 'package:red_flag/utils/constants.dart';
import 'package:red_flag/widgets/custom_form_field.dart';
import 'package:red_flag/view_model/register_view_model.dart';
import 'package:red_flag/widgets/custom_text.dart';
import 'package:red_flag/widgets/image_preview.dart';
import 'package:sizer/sizer.dart';

class ProfilePassword extends StatefulWidget {
  const ProfilePassword({ Key? key }) : super(key: key);
  static String routeName = "/profile-password";
  @override
  State<ProfilePassword> createState() => _ProfilePasswordState();
}

class _ProfilePasswordState extends State<ProfilePassword> {
  final _formKey = GlobalKey<FormState>();
  bool password = false;
  bool _isVisible = false;
  bool imageCheck = false;
 File? imageFile;
final _picker = ImagePicker();
  bool checkProfileImage(){
    if(imageCheck){
     return true;
    } else {
      return false;
    }
  }
/// Get image from gallery
 Future getFromGallery(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 0);
    if (pickedFile != null) {
      setState(() {
       imageCheck = true;
       imageFile = File(pickedFile.path);
      });
      Navigator.push(context, MaterialPageRoute(builder: (ctx) => ImagePreview(imagePreview: imageFile,)));
    }
  }
  void passwordStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
      final provider = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body:Container(
        height: double.infinity,
        width: double.infinity,
        padding:kPadding,
      decoration:const BoxDecoration(
          color:kFormBackround,
      ),
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 130,),
              CustomText(text: "Profile & Password",size:22.sp,weight: FontWeight.w700,color:Colors.white),
              const SizedBox(height: 20,),
              CustomText(text: "Complete the fields to access red flags",size:13.sp,weight: FontWeight.w400,color:Colors.white),
              const SizedBox(height: 20,),
              Center(
                child: imageFile == null ? Column(
                    children: [
                        GestureDetector(
                         onTap: ()=> getFromGallery(context),
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.blue
                          ),
                          child:const Icon(Icons.add),
                        ),
                      ),
                   const SizedBox(height: 10,),
                   CustomText(text: "Add Profile Image",size: 13.sp,color:Colors.white),
                   Visibility(
                    visible:checkProfileImage() == false ? true : false,
                    child:const CustomText(text: "Profile Image is Required",color: Colors.red,))
                    ],
                  ) : GestureDetector(
                      onTap: ()=> getFromGallery(context),
                    child: Column(
                      children: [
                        Container(
                        width: 90,
                        height: 90,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          image: DecorationImage(image: FileImage(imageFile!))
                        ),),
                     const SizedBox(height: 10,),
                     CustomText(text: "Change Profile Image",size: 13.sp,color:Colors.white)
                      
                      ],
                    ),
                  ),
                ),
            
              const SizedBox(height: 20,),
               TextFieldC(
               controller:provider.fullnameTex,
                text:"Full Name" ,
               placeHolderText: "E.g Bill Henry",
                onChanged: (value){
                   value = provider.fullnameTex.text;              
                  setState(
                    () {
                    if (value.isNotEmpty) {
                      provider.fullname = true;
                    } else {
                      provider.fullname = false;
                    }
                      },
                    ); 
                },
                validFunction: (value){
                  String? errorMessage;
                  if (value!.isEmpty) {
                    errorMessage = "\u26A0 Fullname is required";
                  }
                return errorMessage;
                },         
              ),
              const SizedBox(height:15),
               CustomText(text:"Confirm New Password", size: 13.sp,color: Colors.white,weight:FontWeight.w400),
                  Container(
                  height:62,
                  margin: const EdgeInsets.only(top: 15.0),
                  child: _buildPasswordField(provider.passwordTex),
                  ),   
            
          Padding(
          padding: kPadding,
          child: Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          width: double.infinity,
          height: 55.0,
          child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                primary: Colors.white,
                backgroundColor:const Color(0xFF3F37C9),
              ),
              onPressed:provider.isLoading ? null :  () async {
                 if (_formKey.currentState!.validate()|| !checkProfileImage()) {
                      _formKey.currentState!.save();
                    await provider.createAccount(provider.emailTex.text, provider.passwordTex.text, provider.fullnameTex.text,imageFile!, context);        
                  }
              },
              child:provider.isLoading ? const CupertinoActivityIndicator(color: Colors.white,) : Text("Create Account",
                  style: TextStyle(
                      fontFamily: 'Core Pro',
                      fontSize: 13.0.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.center))),
        ),
              const SizedBox(height:20),                    
            ],),
        ),
        ) ),
      
    );
  }
   
  TextFormField _buildPasswordField(TextEditingController passwordController) {
    return TextFormField(
      
      obscureText: _isVisible ? false : true,
      controller:passwordController,
      // onSaved: (newValue) =>  newValue!,
      onChanged: (value) {
        setState(
          () {
            if (value.isNotEmpty) {
              password = true;
            } else {
              password = false;
            }
          },
        );
      },
      validator: (value) {
        String? errorMessage;
        if (value!.isEmpty) {
          errorMessage = "\u26A0 Please Enter your password";
        } 
        return errorMessage;
      },
      decoration: InputDecoration(
        hintText: "e.g Password1#",
        filled: true,
        fillColor: Colors.white,
        // floatingLabelStyle: TextStyle(color:const Color(0xFF828282)),
        contentPadding:const EdgeInsets.only(left:10,bottom: 47 / 2),
        errorStyle: const TextStyle(
            fontFamily: 'Core Pro',
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () => passwordStatus(),
          icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}